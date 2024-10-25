#!/bin/bash
if [ -z "$1" ];then
    echo "请输入文件名"
    exit 1
fi

if [ ! -f "$1" ];then
    echo "文件不存在"
    exit 1
fi

line_count=$(wc -l < $1)
char_count=$(wc -m < $1)
word_count=$(wc -w < $1)
echo "文件行数：$line_count"
echo "文件字数：$word_count"
echo "文件字符数：$char_count"