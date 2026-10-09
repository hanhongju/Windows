import os, shutil
if os.path.exists(os.path.join(r"C:\Program Files\Mozilla Firefox", "distribution")):
    shutil.rmtree(os.path.join(r"C:\Program Files\Mozilla Firefox", "distribution"))

os.makedirs(r"C:\Program Files\Mozilla Firefox\distribution", exist_ok=True)
f = open(r"C:\Program Files\Mozilla Firefox\distribution\policies.json", "w", encoding="utf-8")
f.write('''
{"policies":{"Preferences": {"browser.tabs.groups.enabled": false,
                            "browser.tabs.loadBookmarksInTabs": true,
                            "browser.tabs.insertAfterCurrent": true
                            }
            }
}
''')
f.close()




# 创建Firefox配置文件  about:config
# 验证是否设置成功     about:policies
