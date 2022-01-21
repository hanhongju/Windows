

apt        update  -y
apt        install  -y  python3  git
pip3       install requests bs4  scrapy crawl


git clone https://github.com/Nymphet/t66y-spider.git

cd t66ySpider

# 爬達蓋爾的旗幟的帖子，保存帖子标题和图片地址

scrapy crawl DaGaiEr

# 爬新時代的我們的帖子，保存帖子标题和图片地址

scrapy crawl XinShiDai

# 收集亚洲无码原创区帖子内的图片地址和种子链接，也保存帖子标题和帖子url

scrapy crawl YaZhouWuMa

# 亚洲无码转帖交流区，保存图片地址，种子链接，帖子标题，帖子url

scrapy crawl YaZhouWuMaZhuanTie

# 亚洲有码原创区，同上

scrapy crawl YaZhouYouMa

# 亚洲有码转帖交流区，同上

scrapy crawl YaZhouYouMaZhuanTie
