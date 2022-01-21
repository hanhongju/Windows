# 利用爬虫下载草榴【新時代的我們】和【達蓋爾的旗幟】两个板块帖子内的图片
# https://github.com/yikesoftware/t66y_spider
apt          -y     update
apt          -y     install      python3 wget
pip3         install             bs4 requests tqdm lxml
wget         -c     https://raw.githubusercontent.com/hanhongju/my_script/master/t66y_spider.py
python3      t66y_spider.py -h
python3      t66y_spider.py -c 2 -p 0
#打包下载的文件
tar           -cf         /home/wordpress/t66y.tar        -P       ./t66y/





