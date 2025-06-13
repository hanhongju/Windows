# 在 Windows 沙盒上安装 WinGet
Install-PackageProvider         -Name NuGet
Install-Module                  -Name Microsoft.WinGet.Client
Repair-WinGetPackageManager     -AllUsers
# 安装 SDK
winget install --accept-source-agreements Microsoft.DotNet.SDK.9
# BBDown已经以 Dotnet Tool 形式发布
dotnet tool install --global BBDown
