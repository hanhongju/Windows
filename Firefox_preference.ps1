New-Item    -ItemType Directory     -Path "C:\Program Files\Mozilla Firefox\"                          -Name "distribution" 
New-Item    -ItemType File              -Path "C:\Program Files\Mozilla Firefox\distribution\"       -Name "policies.json"
@'
{"policies": {"Preferences": 
                           {"browser.tabs.groups.enabled": {"Value": false}
                           ,"browser.tabs.loadBookmarksInTabs": {"Value": true}
                           ,"browser.tabs.insertAfterCurrent": {"Value": true}
                           }
             }
}
'@   |   Out-File   -FilePath   "C:\Program Files\Mozilla Firefox\distribution\policies.json"




