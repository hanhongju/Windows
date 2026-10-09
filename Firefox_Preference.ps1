$PSVersionTable
Remove-Item    -Path "C:\Program Files\Mozilla Firefox\distribution\"     -Recurse                -Force
New-Item       -Path "C:\Program Files\Mozilla Firefox\"                  -ItemType Directory     -Name      "distribution" 
New-Item       -Path "C:\Program Files\Mozilla Firefox\distribution\"     -ItemType File          -Name      "policies.json"
@'
{"policies": {"Preferences": {"browser.tabs.groups.enabled": false
                             ,"browser.tabs.loadBookmarksInTabs": true
                             ,"browser.tabs.insertAfterCurrent": true
                           }
             }
}
'@   |   Out-File   -FilePath   "C:\Program Files\Mozilla Firefox\distribution\policies.json"   #该命令需Powershell 7版本才能将格式定为UTF-8，否则为UTF-8-BOM会报错




# 创建Firefox配置文件  about:config
# 验证是否设置成功     about:policies
