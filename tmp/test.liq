#!/usr/bin/liquidsoap -v

#CONFIG
set("log.stdout",true)
set("init.allow_root",true)
#set("scheduler.log",true)
set("scheduler.fast_queues",2)
#set("log.level",5)

#SOURCE
radio=mksafe(normalize(playlist("/tmp/test.m3u",mode="randomize",reload=1,reload_mode="rounds")))


#OUTPUT HIGH BITRATE
output.icecast(%fdkaac(channels=2, samplerate=44100, bitrate=192, afterburner=false, aot="mpeg4_aac_lc", transmux="adts", sbr_mode=false),
host="127.0.0.1",
port=8000,
password="hackmebadly",
description="Test(High Bitrate)",
url="http://localhost/high",
public=false,
genre="Rock",
mount="high",
radio )

#OUTPUT LOW BITRATE
output.icecast(%fdkaac(channels=2, samplerate=44100, bitrate=64, afterburner=false, aot="mpeg4_aac_lc", transmux="adts", sbr_mode=false),
host="127.0.0.1",
port=8000,
password="hackmebadly",
description="Test (low Bitrate)",
url="http://localhost/low",
public=false,
genre="Rock",
mount="low",
radio )
