param(
  [string]$BaseUrl = "http://localhost:8083",
  [Parameter(Mandatory = $true)][string]$MerchantTradeNo,
  [string]$ExternalId = "888088",
  [string]$Md5Key = "",
  [string]$AesKey = ""
)

if ([string]::IsNullOrWhiteSpace($Md5Key) -or [string]::IsNullOrWhiteSpace($AesKey)) {
  Write-Host "Please provide -Md5Key and -AesKey (from default merchant config)." -ForegroundColor Yellow
  exit 1
}

function Get-Md5Hex([string]$text) {
  $md5 = [System.Security.Cryptography.MD5]::Create()
  $bytes = [System.Text.Encoding]::UTF8.GetBytes($text)
  $hash = $md5.ComputeHash($bytes)
  ($hash | ForEach-Object { $_.ToString("x2") }) -join ""
}

function Get-AesBase64([string]$plain, [string]$key) {
  $aes = [System.Security.Cryptography.Aes]::Create()
  $aes.Mode = [System.Security.Cryptography.CipherMode]::ECB
  $aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7
  $aes.Key = [System.Text.Encoding]::UTF8.GetBytes($key)
  $enc = $aes.CreateEncryptor()
  $bytes = [System.Text.Encoding]::UTF8.GetBytes($plain)
  $cipher = $enc.TransformFinalBlock($bytes, 0, $bytes.Length)
  [System.Convert]::ToBase64String($cipher)
}

$timeStamp = [string][DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
$md5 = Get-Md5Hex("$Md5Key`:$timeStamp")
$visitAuth = Get-AesBase64 $md5 $AesKey

$headers = @{
  "timeStamp" = $timeStamp
  "visitAuth" = $visitAuth
}

$body = @{
  externalId = $ExternalId
  merchantTradeNo = $MerchantTradeNo
  platformOutTradeNo = "PLT$MerchantTradeNo"
  thirdOutTradeNo = "THIRD$MerchantTradeNo"
  totalAmount = "10.00"
  tradeStatus = "TRADE_SUCCESS"
  buyerUserId = ""
  buyerInfo = ""
  attachInfo = ""
  createTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
  sucTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
  pltNotifySign = ""
}

$url = "$BaseUrl/pay/notify"
Write-Host "POST $url"
Invoke-WebRequest -Method Post -Uri $url -Headers $headers -Body $body -ContentType "application/x-www-form-urlencoded"
