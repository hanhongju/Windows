Remove-Item    -Path "C:\Program Files\Mozilla Firefox\distribution\"     -Recurse                -Force
New-Item       -Path "C:\Program Files\Mozilla Firefox\"                  -ItemType Directory     -Name "distribution" 
New-Item       -Path "C:\Program Files\Mozilla Firefox\distribution\"     -ItemType File          -Name "policies.json"
@'
{"policies": {"Preferences": 
                           {"browser.tabs.groups.enabled": {"Value": false}
                           ,"browser.tabs.loadBookmarksInTabs": {"Value": true}
                           ,"browser.tabs.insertAfterCurrent": {"Value": true}
                           }
             }
}
'@   |   Out-File   -FilePath   "C:\Program Files\Mozilla Firefox\distribution\policies.json"




# 创建Firefox配置文件
