Remove-Item    -Path "C:\Program Files\Mozilla Firefox\distribution\"     -Recurse                -Force
New-Item       -Path "C:\Program Files\Mozilla Firefox\"                  -ItemType Directory     -Name "distribution" 
New-Item       -Path "C:\Program Files\Mozilla Firefox\distribution\"     -ItemType File          -Name "policies.json"
@'
{"policies": {"Preferences": {"browser.tabs.groups.enabled": false
                             ,"browser.tabs.loadBookmarksInTabs": true
                             ,"browser.tabs.insertAfterCurrent": true
                           }
             }
}
'@   |   Out-File   -FilePath   "C:\Program Files\Mozilla Firefox\distribution\policies.json"




# 创建Firefox配置文件  about:config

