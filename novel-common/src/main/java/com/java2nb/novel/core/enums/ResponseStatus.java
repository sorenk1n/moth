package com.java2nb.novel.core.enums;

import io.github.xxyopen.model.resp.IResultCode;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

/**
 * @author 11797
 */

@Getter
@AllArgsConstructor
@NoArgsConstructor
public enum ResponseStatus implements IResultCode {


    /**
     * 用户相关错误
     * */
   NO_LOGIN(1001, "未登录或登录失效！"),
    VEL_CODE_ERROR(1002, "验证码错误！"),
    USERNAME_EXIST(1003,"该手机号已注册！"),
    USERNAME_PASS_ERROR(1004,"手机号或密码错误！"),
    TWO_PASSWORD_DIFF(1005, "两次输入的新密码不匹配!"),
    OLD_PASSWORD_ERROR(1006, "旧密码不匹配!"),
    USER_NO_BALANCE(1007, "用户余额不足"),

    /**
     * 评论相关错误
     * */
    HAS_COMMENTS(3001, "已评价过该书籍！"),

    /**
     * 作者相关错误
     * */
    INVITE_CODE_INVALID(4001, "邀请码无效！"),
    AUTHOR_STATUS_FORBIDDEN(4002, "作者状态异常，暂不能管理小说！")
    , BOOKNAME_EXISTS(4003,"已发布过同名小说！"),

    /**
     * 小说相关错误
     */
    BOOK_EXISTS(5001,"该小说已存在")

            ,
    /**
     * 搜索引擎相关错误
     * */
    ES_SEARCH_FAIL(9001,"搜索引擎查询错误！"),

    /**
     * 文件相关错误
     * */
    FILE_DIR_MAKE_FAIL(10001,"目录创建失败"),
    FILE_NOT_IMAGE(10002,"请上传图片类型的文件"),
    FILE_SIZE_LIMIT(10003,"文件大小超出限制"),

    /**
     * openapi相关错误
     */
    OPENAPI_AUTH_FAIL(20001, "openapi鉴权失败"),
    OPENAPI_APP_DISABLED(20002, "openapi接入方不可用"),
    OPENAPI_SIGN_ERROR(20003, "签名错误"),
    OPENAPI_TIMESTAMP_EXPIRED(20004, "请求已过期"),
    OPENAPI_NONCE_REPLAY(20005, "重复请求"),
    OPENAPI_RATE_LIMIT(20006, "请求过于频繁"),
    OPENAPI_ALIPAY_CONFLICT(20007, "支付宝用户已绑定其他外部用户"),
    OPENAPI_ORDER_CONFLICT(20008, "外部订单已存在"),
    OPENAPI_PARAM_ERROR(20009, "openapi参数错误"),

    /**
     * 其他通用错误
     * */
    PASSWORD_ERROR(88001,"密码错误！");

    private int code;
    private String msg;


}
