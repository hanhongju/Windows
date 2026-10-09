pip install pyinstaller
cd  C:\Users\Admin\Desktop

@'
# -*- coding: utf-8 -*-
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
print("✅ 策略写入完成，重启Firefox访问 about:policies 查看")
input("\n按回车退出...")
'@   |   Out-File   -FilePath   "firefox_policy.py" -Encoding utf8

pyinstaller -F -c firefox_policy.py




# 使用python在桌面上创建一个exe文件，用来修改Firefox的配置文件
