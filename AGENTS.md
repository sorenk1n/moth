## 1. 项目概述

本仓库是基于 Java 的多模块小说内容管理系统（novel-plus / novel），包含：

- `novel-front`：前台网站与作者创作后台（读者阅读、充值、作者发布章节等），同时集成 Spring AI，实现 AI 写作/扩写等能力。
- `novel-admin`：运营管理后台（书籍、用户、作者、财务、网站配置等后台管理）。
- `novel-crawl`：小说采集/爬虫服务（定时从外部站点采集小说内容）。
- `novel-common`：公共业务与基础设施模块（数据库、分表、缓存、HTTP 工具等）。

整体技术架构以 Spring Boot 为核心，结合 MyBatis、ShardingSphere-JDBC、Redis、MySQL 等组件，前端采用 Thymeleaf 模板 + 静态资源（非独立前端工程，无单独的 npm / pnpm 构建流程）。

---

## 2. 安装与运行

> 下文所有涉及 Node 包管理器的示例，如需使用，请统一改为 **pnpm**（例如 `pnpm install`、`pnpm run build`），不要使用 `npm`。

### 2.1 环境依赖与环境变量

必备依赖：

- JDK 21（建议安装 Zulu / Oracle / OpenJDK 21，并配置 `JAVA_HOME` 和 `PATH`）。
- Maven 3.8+（推荐 3.9），确保 `mvn -v` 可用。
- MySQL 8.x（默认使用本机 `localhost:3306`，数据库名 `novel_plus`）。
- Redis（建议运行在本机，默认 `127.0.0.1:6379`）。
- 可选：Node.js + pnpm（仅在需要对内嵌前端框架进行二次开发时使用，项目本身不依赖 npm 构建）。

建议配置的环境变量（Windows / macOS / Linux 视情况配置）：

- `JAVA_HOME`：指向 JDK 安装目录。
- `MAVEN_HOME`（可选）：指向 Maven 安装目录。
- 将 `JAVA_HOME/bin` 与 `MAVEN_HOME/bin` 加入 `PATH`。

### 2.2 初始化数据库与 Redis

1. 在 MySQL 中创建数据库：

   ```sql
   CREATE DATABASE novel_plus DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_general_ci;
   ```

2. 导入基础与增量脚本（顺序执行）：

   - `doc/sql/novel_plus.sql`
   - 同目录下按时间顺序执行 `20200511.sql`、`20200513.sql`、…、`20250712.sql`。

3. 根据本地环境修改数据库连接配置：

   - 文件：`config/shardingsphere-jdbc.yml`
   - 默认配置：
     - `jdbcUrl: jdbc:mysql://localhost:3306/novel_plus?...`
     - `username: root`
     - `password: test123456`
   - 如本地账号或密码不同，请修改 `username` / `password` 为你的实际值。

4. Redis 配置（开发环境）：

   - 主要在 `novel-common/src/main/resources/application-common-dev.yml` 与 `novel-admin/src/main/resources/application-dev.yml`：
     - `spring.data.redis.host` / `spring.redis.host`：默认 `127.0.0.1`
     - `port`：默认 `6379`
     - `password`：默认 `test123456`
   - 请根据本地 Redis 实际配置修改以上字段。

### 2.3 核心配置调整（本地开发建议）

1. 通用数据库与路径配置：

   - 文件：`novel-common/src/main/resources/application-common.yml`
     - `spring.datasource.url` 指向 `config/shardingsphere-jdbc.yml`，一般无需修改。
   - 文件：`novel-common/src/main/resources/application-common-dev.yml`
     - `spring.data.redis.*`：如上所述按需修改。
     - `content.save.path`：小说 TXT 存储路径，建议改为本机可写目录，例如：
       ```yaml
       content:
         save:
           storage: db
           path: D:/novel/books
       ```

2. 前台图片存储路径：

   - 文件：`novel-front/src/main/resources/application-dev.yml`
   - 默认为 Mac 路径：
     ```yaml
     pic.save.path: /Users/xiongxiaoyang/java/
     ```
   - 建议在本机改为：
     ```yaml
     pic:
       save:
         type: 1
         storage: local
         path: D:/novel/pic
     ```

3. 后台上传路径与端口：

   - 文件：`novel-admin/src/main/resources/application-dev.yml`
     - `java2nb.uploadPath` 默认 `/var/pic/`，建议改为 `D:/novel/admin_upload/` 或类似路径。
   - 文件：`novel-admin/src/main/resources/application.yml`
     - 默认端口 `server.port: 80`，开发环境建议改为非 80 端口（如 `8085`），避免权限问题：
       ```yaml
       server:
         port: 8085
       ```

4. AI / 支付 / OSS（可选）：

   - 文件：`novel-front/src/main/resources/application.yml`
     - `spring.ai.openai.*`：如需启用 AI 写作与封面生成功能，请在此配置你自己的 API Key 与模型；不使用时保持默认一般不会影响基础阅读功能。
   - 文件：`novel-front/src/main/resources/application-alipay.yml`
     - 支付宝沙箱支付配置，用于充值功能，如本地不做支付调试，可暂时忽略。
   - 文件：`novel-front/src/main/resources/application-oss.yml`
     - 阿里云 OSS 配置，如仅使用本地存储，可不配置或保持默认示例值。

### 2.4 构建命令

在仓库根目录执行（所有模块一次性构建）：

```bash
mvn clean package -DskipTests
```

构建完成后，主要产物：

- `novel-front/target/novel-front-<version>.jar`
- `novel-admin/target/novel-admin-<version>.jar`
- `novel-crawl/target/novel-crawl-<version>.jar`

> 注意：父 POM (`pom.xml`) 中设置了 `maven.test.skip=true`，默认跳过单元测试，本仓库中也几乎没有测试类。

### 2.5 运行方式

#### 2.5.1 使用 IDE（推荐）

- 导入方式：在 IDE（如 IntelliJ IDEA）中通过根目录 `pom.xml` 以 Maven 工程方式导入。
- 运行配置建议：
  - **Working directory**：设置为仓库根目录（保证 `${user.dir}` 下能找到 `config/shardingsphere-jdbc.yml`）。
  - 运行入口：
    - 前台站点：`com.java2nb.novel.FrontNovelApplication`（模块 `novel-front`）
    - 后台管理：`com.java2nb.AdminApplication`（模块 `novel-admin`）
    - 爬虫服务：`com.java2nb.novel.CrawlNovelApplication`（模块 `novel-crawl`）
  - 启动顺序建议：先启动 MySQL、Redis，再启动 `novel-admin` → `novel-front` → `novel-crawl`。

启动成功后，控制台会打印类似：

- 前台：`http://<your-ip>:8083`
- 后台：`http://<your-ip>:8085`（或你配置的端口）
- 爬虫：`http://<your-ip>:8081`

#### 2.5.2 使用 JAR 直接运行

在根目录执行：

```bash
java -jar novel-admin/target/novel-admin-5.3.0.jar
java -jar novel-front/target/novel-front-5.3.0.jar
java -jar novel-crawl/target/novel-crawl-5.3.0.jar
```

同样需要保证工作目录为项目根目录，并提前启动 MySQL 与 Redis。

#### 2.5.3 前端二次开发（如需）

项目前端主要通过 Thymeleaf 模板 + 静态资源实现，不是独立的前端工程。如果你要对内嵌的第三方前端库进行二次开发（例如 `wangEditor` 示例），请在对应目录自行使用 pnpm，而不是 npm，例如：

```bash
pnpm install
pnpm run build
```

---

## 3. 目录结构、页面路由与 API 概览

### 3.1 目录结构（后端为主）

- 根目录
  - `novel-common`：公共模块
    - `src/main/java/com/java2nb/novel`：公共实体、Mapper、服务等
    - `src/main/resources`：
      - `application-common.yml`：公共配置
      - `application-common-dev.yml` / `prod.yml`：环境差异配置
      - `mybatis/mapping/*.xml`：MyBatis 映射文件
  - `novel-front`：前台站点 + 作者后台
    - `src/main/java/com/java2nb/novel`
      - `FrontNovelApplication.java`：启动类
      - `controller`：对外 REST API 与页面控制器
        - `page` 包：负责 `.html` 页面路由（读者 / 用户 / 作者界面）
        - 其他 Controller：书籍、用户、作者、支付、新闻、友情链接、文件等 API
    - `src/main/resources`
      - `templates`：Thymeleaf 模板（`index.html`、`book/*.html`、`user/*.html` 等）
      - `static`：静态资源（CSS / JS / 图片）
      - `application*.yml`：前台服务配置
  - `novel-admin`：运营后台
    - `src/main/java/com/java2nb`
      - `AdminApplication.java`：后台启动类
      - `novel` 子包：小说业务后台接口（书籍、分类、评论、作者等）
      - `system` 子包：系统管理（用户、角色、菜单、数据权限等）
      - `common` 子包：通用组件（文件、字典、日志、代码生成等）
    - `src/main/resources`
      - `templates`：后台页面（`index.html`、模块子目录等）
      - `static`：后台静态资源
      - `application*.yml`：后台配置
  - `novel-crawl`：采集服务
    - `src/main/java/com/java2nb/novel`
      - `CrawlNovelApplication.java`：采集服务启动类
      - 采集配置、任务调度等类
    - `src/main/resources`
      - `templates`：采集管理页面
      - `application*.yml`：采集服务配置
  - `config/shardingsphere-jdbc.yml`：ShardingSphere 数据源与分表规则
  - `doc/sql`：数据库脚本
  - `templates`：可选前台模板包（如 `green`、`orange` 主题等）

### 3.2 前台主要页面路由

前台页面路由在 `novel-front/src/main/java/com/java2nb/novel/controller/page/PageController.java` 中定义，部分常用路由如下：

- 首页与通用：
  - `/`、`/index`、`/index.html`：首页
  - `/{url}.html`：通用单页
  - `/{module}/{url}.html`、`/{module}/{classify}/{url}.html`：模块化页面
- 用户中心：
  - `/user/login.html`：登录页
  - `/user/register.html`：注册页
  - `/user/userinfo.html`：用户信息
  - `/user/favorites.html`：书架
  - `/user/read_history.html`：阅读记录
- 支付：
  - `/pay/index.html`：充值中心
- 书籍：
  - `/book/bookclass.html`：分类列表
  - `/book/book_ranking.html`：排行榜
  - `/book/{bookId}.html`：书籍详情页
  - `/book/indexList-{bookId}.html`：章节目录页
  - `/book/{bookId}/{bookIndexId}.html`：章节阅读页
  - `/book/comment-{bookId}.html`：书籍评论列表
  - `/book/reply-{commentId}.html`：评论回复列表
- 作者：
  - `/author/register.html`：作者注册页面
- 资讯：
  - `/about/newsInfo-{newsId}.html`：新闻详情页

对应页面模板在 `novel-front/src/main/resources/templates` 目录下。

### 3.3 前台主要 REST API 概览

以下仅列出常用接口，完整定义请查看对应 Controller：

- 用户相关（`novel-front/src/main/java/com/java2nb/novel/controller/UserController.java`，前缀 `/user`）：
  - `POST /user/login`：用户登录，返回 JWT。
  - `POST /user/register`：用户注册。
  - `POST /user/refreshToken`：刷新 Token。
  - `GET /user/userInfo`：获取用户信息。
  - `POST /user/updateUserInfo`：更新用户信息。
  - `POST /user/updatePassword`：修改密码。
  - `GET /user/queryIsInShelf`：是否已加入书架。
  - `POST /user/addToBookShelf`：加入书架。
  - `GET /user/listBookShelfByPage`：分页查询书架。
  - `GET /user/listReadHistoryByPage`：分页查询阅读记录。
  - `POST /user/addReadHistory`：新增阅读记录。
  - `POST /user/addFeedBack` / `GET /user/listUserFeedBackByPage`：反馈相关。
  - `GET /user/listCommentByPage`：用户评论列表。
  - `POST /user/buyBookIndex`：购买章节。

- 书籍相关（`BookController`，前缀 `/book`）：
  - `GET /book/listBookSetting`：推荐位书籍列表。
  - `GET /book/listClickRank` / `listNewRank` / `listUpdateRank`：各类排行榜。
  - `GET /book/listBookCategory`：分类列表。
  - `GET /book/searchByPage`：书籍搜索。
  - `GET /book/queryBookDetail/{id}`：书籍详情。
  - `GET /book/listRank`：综合排行榜。
  - `POST /book/addVisitCount`：增加访问量。
  - `GET /book/queryBookIndexAbout`：章节相关信息。
  - `GET /book/listRecBookByCatId`：按分类推荐。
  - `GET /book/listCommentByPage` / `listCommentReplyByPage`：评论与回复列表。
  - `POST /book/addBookComment` / `addCommentReply`：新增评论与回复。
  - `POST /book/toggleCommentLike` / `toggleCommentUnLike` / `toggleReplyLike` / `toggleReplyUnLike`：点赞 / 踩操作。
  - `GET /book/queryNewIndexList` / `/book/queryIndexList`：章节列表。

- 作者相关（`AuthorController`，前缀 `/author`）：
  - `GET /author/checkPenName`：检测笔名是否占用。
  - `GET /author/listBookByPage`：作者书籍列表。
  - `POST /author/addBook`：作者新增书籍。
  - `POST /author/updateBookStatus`：更新书籍状态（上架/下架等）。
  - `POST /author/addBookContent` / `updateBookContent`：新增/更新章节内容。
  - `GET /author/queryIndexContent/{indexId}`：查询章节内容。
  - `POST /author/updateBookPic`：更新书籍封面。
  - `GET /author/listIncomeDailyByPage` / `listIncomeMonthByPage`：作者收入统计。
  - AI 写作相关：
    - `GET /author/queryAiGenPic`：AI 生成封面图。
    - `POST /author/ai/expand` / `ai/condense` / `ai/continue` / `ai/polish`：AI 文本处理。
    - `GET /author/ai/stream/*`：AI 流式 SSE 文本处理接口。

- 支付相关（`PayController`，前缀 `/pay`）：
  - `POST /pay/aliPay`：支付宝支付下单。
  - `POST /pay/aliPay/notify`：支付宝异步通知回调。

- 其他：
  - 新闻（`NewsController`，前缀 `/news`）：
    - `GET /news/listIndexNews`：首页新闻列表。
    - `GET /news/listByPage`：分页新闻列表。
    - `POST /news/addReadCount`：增加新闻阅读量。
  - 友情链接（`FriendLinkController`，前缀 `/friendLink`）：
    - `GET /friendLink/listIndexLink`：首页友情链接列表。
  - 文件（`FileController`，前缀 `/file`）：
    - `GET /file/getVerify`：验证码图片。
    - `POST /file/picUpload`：图片上传。
  - 缓存（`CacheController`，前缀 `/cache`）：
    - `GET /cache/refresh/{pass}/{type}`：刷新缓存（受密码保护）。

### 3.4 后台主要 API 与页面

后台接口集中在 `novel-admin/src/main/java/com/java2nb` 各个 Controller 中，主要以 `/novel/*`、`/sys/*`、`/common/*` 为前缀：

- 小说业务（前缀 `/novel`）：
  - `/novel/book`、`/novel/bookIndex`、`/novel/bookContent`、`/novel/bookComment`：书籍及章节管理。
  - `/novel/category`：分类管理。
  - `/novel/author`、`/novel/authorCode`：作者与邀请码管理。
  - `/novel/news`：资讯管理。
  - `/novel/websiteInfo`：站点信息配置。
  - `/novel/friendLink`：友情链接管理。
  - `/novel/user`、`/novel/userFeedback`：用户与反馈管理。
  - `/novel/pay`：支付记录与财务相关。
  - `/novel/stat`：统计报表。

- 系统管理（前缀 `/sys` / `/system`）：
  - `/sys/user`、`/sys/role`、`/sys/menu`：系统用户、角色、菜单。
  - `/system/sysDept`：部门管理。
  - `/system/dataPerm`、`/system/roleDataPerm`：数据权限管理。
  - `/sys/online`：在线会话管理。

- 通用（前缀 `/common`）：
  - `/common/dict`：数据字典。
  - `/common/sysFile`：文件上传与管理。
  - `/common/log`：操作日志。
  - `/common/generator`：代码生成器。

后台页面模板位于 `novel-admin/src/main/resources/templates`，入口页面：

- `/login`：登录页（`templates/login.html`）。
- `/index`：主框架页面（`templates/index.html` + `main.html`）。

---

## 4. 技术栈与重要依赖

### 4.1 后端核心技术

- **语言与运行时**：Java 21
- **框架**：
  - Spring Boot（前台 `3.4.0`，后台 `2.7.18`）
  - Spring MVC（REST API 与页面路由）
  - Spring Cache、Spring Scheduling、Spring Transaction
  - Spring AI（集成 OpenAI / SiliconFlow 等大模型）
- **持久化**：
  - MyBatis + MyBatis Dynamic SQL
  - PageHelper（分页插件）
  - MyBatis Generator（自动生成实体与 Mapper）
- **数据库与分表**：
  - MySQL 8.x
  - ShardingSphere-JDBC（数据源管理 + 分表，在 `config/shardingsphere-jdbc.yml` 中配置）
- **缓存与消息**：
  - Redis（Spring Data Redis + Jedis / Redisson）
- **安全与认证**：
  - Apache Shiro（后台权限控制）
  - Spring Security（采集模块）
  - JWT（JJWT，用于前台用户登录状态）
- **模板与视图**：
  - Thymeleaf（前台与后台页面渲染）
  - NekoHTML（HTML 解析）
- **其他**：
  - Lombok（简化实体与日志）
  - Fastjson / Jackson（JSON 序列化）
  - Apache Commons 系列（IO / Text / Lang3 等）
  - Aliyun OSS SDK（对象存储）
  - 支付宝 SDK（支付功能）

### 4.2 AI 相关依赖

- 父 POM 中引入 `spring-ai-bom`，前台模块 `novel-front` 依赖：
  - `org.springframework.ai:spring-ai-starter-model-openai`
- 默认示例使用 SiliconFlow 平台的 DeepSeek-R1 文本模型与 Kolors 图像模型，具体配置见：
  - `novel-front/src/main/resources/application.yml` 中 `spring.ai.openai.*`。

### 4.3 前端与静态资源

- 不使用独立的单页应用框架（如 React/Vue）进行主站渲染，主要依赖：
  - jQuery / Layui / 自定义 JS 与 CSS。
  - 第三方编辑器 `wangEditor`（部分示例中自带 Node 工程说明，如果需要运行这些示例，请用 `pnpm` 而非 `npm`）。

---

## 5. 关于 pnpm 的约定

- 本项目核心构建与运行完全基于 **Maven + Spring Boot**，默认不要求安装 Node 或使用 pnpm。
- 如你在本项目中新增前端子工程（如 `web` / `admin-ui` 等）或修改内嵌前端示例，并需要使用 Node 包管理器：
  - 请统一使用 **pnpm**，并在相关文档和脚本中使用：
    - `pnpm install`
    - `pnpm run dev`
    - `pnpm run build`
  - 不要在本项目新增文档或脚本中使用 `npm` 命令。

编写或修改代码时，如有与本文不一致的地方，以本 AGENTS 文档为准进行统一。若增加新的模块或重要依赖，建议同步更新本文件。
