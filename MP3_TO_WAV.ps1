Set-Location   -Path   $PSScriptRoot
$Files = Get-ChildItem  -Filter  "*.mp3"  -File
foreach ($File in $Files) {
    $inputFile   =   $File.FullName
    $outputFile  =   $File.BaseName  +  ".wav"
    ffmpeg  -i  $inputFile  $outputFile
}




# 使用ffmpeg将当前目录中的MP3转换为WAV，需先将ffmpeg设置在系统环境变量PATH中
