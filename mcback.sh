#!/bin/bash

# 实例id
INSTANCE_ID=$1

if [ -z "$1" ];  then
    echo "实例id不能为空"
    exit 1
fi

# 实例目录,为空则表示实例不存在
BAK_DIR_PATH="/opt/mcsmanager/daemon/data/InstanceData/${INSTANCE_ID}/world"

if [ ! -d "$BAK_DIR_PATH" ]; then
    echo "实例不存在"
    exit 1
fi

#备份路径
OUTPUT_DIR="/opt/mcsmanager/daemon/data/InstanceData/${INSTANCE_ID}/worldbak"

if pgrep -f "/opt/mcsmanager/daemon/data/InstanceData/${INSTANCE_ID}" > /dev/null; then
    mkdir -p "$OUTPUT_DIR"
    CURRENT_TIME=$(date +"%Y%m%d%H%M%s")
    #输出的文件名
    OUTPUT_FILE="${OUTPUT_DIR}/world_${CURRENT_TIME}.zip"

    FILE_COUNT=$(ls -l "$OUTPUT_DIR"/*.zip 2>/dev/null | wc -l)
    if [ "$FILE_COUNT" -ge 5 ]; then
        OLDEST_FILE=$(ls -1t "$OUTPUT_DIR"/*.zip | tail -1)
        rm -f "$OLDEST_FILE"
        echo "已删除最旧的备份文件:$OLDEST_FILE"
    fi
	
    #压缩
    zip -r "$OUTPUT_FILE" "$BAK_DIR_PATH"

    echo "$(date +"%Y-%m-%d %H:%M:%S")已备份:$OUTPUT_FILE" >> "${OUTPUT_DIR}/log.txt"
else 
    echo "$(date +"%Y-%m-%d %H:%M:%S")服务未运行,不进行备份" >> "${OUTPUT_DIR}/log.txt"
fi