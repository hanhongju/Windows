import requests
import threading
import multiprocessing
import signal
from bs4 import BeautifulSoup
from lxml import html
import json
import xml
import sys
import argparse
import os
import time
import tqdm

# 帖子前缀的分类标签，可以自己添加
class_list1 = ["[亞洲]", "[歐美]", "[動漫]", "[寫真]", "[原创]", "[其它]"]

# 如果当前域名失效了可以自行更换main_url（经常的事
main_url = "http://cl.170x.xyz/"
url1 = f"{main_url}/thread0806.php?fid=8&search=&page="
url2 = f"{main_url}/thread0806.php?fid=16&search=&page="

max_thread = 64
useProxy = False
max_retried = 3

# UA设置
head = dict()
head['User-Agent'] = 'Mozilla/5.0 (Linux; Android 4.1.1; Nexus 7 Build/JRO03D) AppleWebKit/535.19 (KHTML,  like Gecko) Chrome/18.0.1025.166  Safari/535.19'




def myRequest_get(url, stream=False, timeout=(15, 220)):
    global useProxy
    if useProxy:
        return requests.get(url, proxies=proxies, headers=head, stream=stream, timeout=timeout)
    else:
        return requests.get(url, headers=head, stream=stream, timeout=timeout)


def download_pic(name, url, path):
    '''
    该函数用于下载指定帖子内的所有图片
    '''
    count = -1
    try:
        os.mkdir(path+"/"+name[:4])
    except:
        pass
    if os.path.exists(path+"/"+name[:4]+"/"+name[4:]):
        print("path['"+path+"/"+name[:4]+"/"+name[4:]+"'] exists")
        return 0
    else:
        os.mkdir(path+"/"+name[:4]+"/"+name[4:])
    try:
        f = myRequest_get(url, False)
    except Exception as e:
        print("download failed:", e)
        return 0
    soup = BeautifulSoup(f.content, "lxml")
    photo_div = soup.find_all('div', class_="tpc_content do_not_catch")
    try:
        photo_list = photo_div[0].find_all('img')
    except Exception as e:
        print("\nUrl(%s) filed to get photo list cause :" % (url), e)
        return 0

    savepath = path+"/"+name[:4]+"/"+name[4:]
    photo_num = len(photo_list)
    index = 0

    for li in photo_list:
        index += 1
        pic_url = li.get('ess-data')
        if pic_url == None:
            continue
        _retried = max_retried
        while True:
            try:
                r = myRequest_get(pic_url, stream=True)
            except Exception as e:
                if _retried > 0:
                    _retried -= 1
                    print("[%d/%d] Try again to download [%s] from post [%s]" %
                          (index, photo_num, pic_url, url))
                    continue
                else:
                    print("[%d/%d] Failed to download image [%s] in post [%s]:" %
                          (index, photo_num, pic_url, url), str(e))
                    break
            if r.status_code == 200:
                count += 1
                try:
                    savefilename = savepath+"/" + \
                        str(count)+"."+pic_url.split(".")[-1]
                except:
                    savefilename = savepath+"/"+str(count)+".jpg"
                with open(savefilename, 'wb') as _:
                    _.write(r.content)
                    print("[%d/%d] Image saved [%s] from post [%s]" %
                          (index, photo_num, pic_url, url))
            else:
                print(r.status_code, ":url(%s) request failed!" % (pic_url))
            del r
            break

    print("帖子[%s]下载完成，共下载[%d/%d]幅图片，有[%d]幅下载失败。" %
          (url, count+1, photo_num, photo_num-count-1))


def get_list(class_name, url):  # 该函数获取板块内的帖子列表
    '''
    该函数获取板块内的帖子列表
    '''
    if os.path.exists("./t66y/"+class_name):
        print("path['./t66y/"+class_name+"'] exists")
    else:
        os.mkdir("./t66y/"+class_name)
    post_class = ""
    try:
        f = myRequest_get(url, False)
    except Exception as e:
        print("Connect failed:", e)
        sys.exit(0)
    soup = BeautifulSoup(f.content, "lxml")
    td = soup.find_all('td', class_="tal")
    post_list = dict()
    for i in td:
        if "↑" in str(i):  # 过滤几个置顶公告帖
            continue
        for item in class_list1:
            if item in str(i):
                post_class = item
                break
            else:
                post_class = "[其它]"
        post_title = i.find_all('h3')[0].find_all('a')[0].string
        post_title = post_class+post_title
        post_url = str(i.find_all('h3')[0]).split('"')[1]
        post_url = main_url+post_url
        post_list[post_title] = post_url

    bar = tqdm.tqdm(post_list)
    bar.set_description("获取【%s】帖子列表=>" % (class_name))
    for key in bar:
        # download_pic(key,post_list[key],"./t66y/"+class_name)
        while(1):
            if threading.active_count() < max_thread:
                break
            else:
                time.sleep(2)
        download_thread = threading.Thread(target=download_pic, args=(
            key, post_list[key], "./t66y/"+class_name,))  # 多线程下载
        download_thread.setDaemon(True)  # 设置守护进程
        download_thread.start()
        time.sleep(0.1)


def pre_exit():
    while(1):
        thread_unfinished = threading.active_count() - init_thread_num
        if thread_unfinished > 0:
            print("\n***剩余下载线程：[%d]***\n 长时间无响应请(Ctrl+C)结束进程..." %
                  (thread_unfinished))
            time.sleep(10)
        else:
            print("下载已完成！")
            sys.exit(0)


def on_recv_sigterm(signum, frame):
    global sub_process_list

    for p in sub_process_list:
        p.terminate()
        sub_process_list.remove(p)

    sys.exit(0)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-c', '--class_id', type=int, default=0,
                        help="'1' for 【新時代的我們】, '2' for 【達蓋爾的旗幟】, '0' for both")
    parser.add_argument('-s', '--start', type=int,
                        default=1, help="Page_start(default=1)")
    parser.add_argument('-e', '--end', type=int, default=1, help="Page_end")
    parser.add_argument('-m', '--max_thread', type=int,
                        default=60, help="Max thread num(default=300)")
    parser.add_argument('-p', '--noproxy', type=int, default=1,
                        help="'0': not use proxy; '1': use proxy; (default=1)")
    args = parser.parse_args()
    class_id = args.class_id
    start = args.start
    end = args.end
    global useProxy
    global init_thread_num
    init_thread_num = threading.active_count()  # 计算初始线程数
    if args.noproxy == 0:  # 关闭代理
        useProxy = False

    if class_id > 2:
        print("Sorry no class [", class_id, "] !")
        sys.exit(0)
    if end < start or start < 1:
        print("Bad range!")
        sys.exit(0)
    if os.path.exists("./t66y"):
        print("path[',/t66y'] exists")
    else:
        os.mkdir("./t66y")
    print("Enjoy your life!")

    # 存储所有的子进程
    global sub_process_list
    sub_process_list = []

    # 注册SIGTERM信号捕捉函数,来管理子进程的退出
    signal.signal(signal.SIGTERM, on_recv_sigterm)
    signal.signal(signal.SIGINT, on_recv_sigterm)

    if class_id == 0:
        print("将下载【新時代的我們】和【達蓋爾的旗幟】的图片...")
        for i in range(start, end+1):
            print("开始下载第", i, "页")
            p1 = multiprocessing.Process(
                target=get_list, args=("新時代的我們", url1+str(i)))
            p2 = multiprocessing.Process(
                target=get_list, args=("達蓋爾的旗幟", url2+str(i)))
            p1.start()
            p2.start()
            sub_process_list.append(p1)
            sub_process_list.append(p2)
            p1.join()
            p2.join()
            #get_list("新時代的我們", url1+str(i))
            #get_list("達蓋爾的旗幟", url2+str(i))
        pre_exit()
    else:
        if class_id == 1:
            print("将下载【新時代的我們】的图片...")
            for i in range(start, end+1):
                print("开始下载第", i, "页")
                get_list("新時代的我們", url1+str(i))
            pre_exit()
        if class_id == 2:
            print("将下载【達蓋爾的旗幟】的图片...")
            for i in range(start, end+1):
                print("开始下载第", i, "页")
                get_list("達蓋爾的旗幟", url2+str(i))
            pre_exit()


if __name__ == "__main__":
    main()
