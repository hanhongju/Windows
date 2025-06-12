# 在 Windows 沙盒上安装 WinGet
$progressPreference = 'silentlyContinue'
Write-Host "Installing WinGet PowerShell module from PSGallery..."
Install-PackageProvider -Name NuGet -Force | Out-Null
Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
Write-Host "Using Repair-WinGetPackageManager cmdlet to bootstrap WinGet..."
Repair-WinGetPackageManager -AllUsers
Write-Host "Done."
# 安装 SDK
winget install Microsoft.DotNet.SDK.9
winget install Microsoft.DotNet.DesktopRuntime.9
winget install Microsoft.DotNet.AspNetCore.9
