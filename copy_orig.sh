#!/bin/bash

CWD=$(pwd)
TMP_DIR="${CWD}/tmp"
ORIG_PATH="/homeassistant/components/aws_s3"
NEW_DIR="${CWD}/custom_components/s3_compatible"

clean_up() {
    rm -rf ${TMP_DIR}
}

clone_from_orig() {
    git clone -b master -n --depth=1 --filter=tree:0 https://github.com/home-assistant/core.git ${TMP_DIR}
    if [[ -d ${TMP_DIR} ]]; then
        cd ${TMP_DIR}
        git sparse-checkout set --no-cone ${ORIG_PATH}
        git checkout
        cd $CWD
    else
        echo "#### ERROR! folder ${TMP_DIR} not exists ####"
    fi
}

mv_from_orig() {
    mv ${TMP_DIR}${ORIG_PATH}/__init__.py ${NEW_DIR}/__init__.py
    mv ${TMP_DIR}${ORIG_PATH}/backup.py ${NEW_DIR}/backup.py
    mv ${TMP_DIR}${ORIG_PATH}/const.py ${NEW_DIR}/const.py
    mv ${TMP_DIR}${ORIG_PATH}/config_flow.py ${NEW_DIR}/config_flow.py
    mv ${TMP_DIR}${ORIG_PATH}/strings.json ${NEW_DIR}/strings.json
}

clean_up
clone_from_orig
mv_from_orig
clean_up
