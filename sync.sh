#!/bin/bash

SYNC_DIR="./sync"
S3_BUCKET_PATH=""

trap 'exit 1' ERR

function show_help {
cat << HELP
  usage: `basename $0` [OPTION]

  syncディレクトリとs3を同期
  オプション指定がない場合はdryrunを、-yオプション付与で同期を実行

  OPTION
    -y: 同期実行
HELP
}

#同期元(スクリプト実行環境を正にする)
OPTION="--delete"

case "$1" in
  "" )
    OPTION="${OPTION} --dryrun"
    ;;
  "-y" )
    ;;
  * )
    show_help
    exit 1
    ;;
esac

cd $(dirname $0)/..
aws s3 sync $SYNC_DIR $S3_BUCKET_PATH $OPTION
