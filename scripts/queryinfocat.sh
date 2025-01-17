#!/bin/bash

SEPARATOR="/"
QUERYTEXTDIR=".${SEPARATOR}gpmetrics${SEPARATOR}query_text${SEPARATOR}"
GPCC_HOME="$1"
DATA_FILE="$2"
MD5=${GPCC_HOME}${SEPARATOR}bin${SEPARATOR}gpcc_md5

cat_query_text(){
    echo -n "\""
    echo -n "$(cat $1)" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g'
    echo -n "\""
}

main() {
    local QID

    while IFS='' read -r line || [[ -n "$line" ]]; do
        IFS='|' read -ra PART <<< "${line}|"
        CNT=0
        for i in "${PART[@]}"; do
            if [ ${CNT} != 0 ]; then
                echo -n "|"
            fi
            ((CNT++))
            if [ ${CNT} == 2 ]; then
                QID="${i}"
            elif [ ${CNT} == 3 ]; then
                QID="${QID}-${i}"
            elif [ ${CNT} == 4 ]; then
                QID="${QID}-${i}"
            fi
            if [ "$CNT" == 15 ]; then
                ${MD5} "${QUERYTEXTDIR}q${QID}.txt"
            elif [ "$CNT" == 16 ]; then
                cat_query_text "${QUERYTEXTDIR}q${QID}.txt"
            else
                echo -n "${i}"
            fi
        done
        echo ""
    done < "${DATA_FILE}"
}

main "$@"
