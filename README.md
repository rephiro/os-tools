# os-tools

  pythonを使用しない、bashのみの独自OpenStackクライアント。
  os-toolsは`jq`(<https://stedolan.github.io/jq/>)を利用しているため、
  あらかじめ`jq`をインストールしてから使用してください。

  作業用に作成したツールのため、本ツールのインストール／使用は自己責任でお願いします。

## 動作環境

  CentOS6.x系、7.x系で動くと思います。
  OpenStack Liberty で動作確認していますが、Keystone APIはv2のみ対応しています。

## インストール

    git clone https://github.com/rephiro/os-tools
    cd os-tools
    ./install-os-tools.sh
    . ~/.bashrc

## 使い方

  OpenStackの`keystonerc`を読み込んでから、`baseinfoget`を実行すれば準備完了です。

    . keytonerc
    baseinfoget

  トークンの取得、テナントIDの取得、エンドポイントURL(パブリックのみ)を取得し、
  環境変数に設定されます。
  大抵のOpenStack環境ではトークンの有効期限が設定されているため、有効期限が切れると
  API アクセスに失敗します。トークンを再取得するためには以下を実行してください。

    reget_token

### できること1 - os-curlで単純かつ原理的なAPIアクセス

  `baseinfoget`の実行後、`os-curl`コマンドでAPIにアクセス可能です。
  取得したエンドポイントURLは、`urls`コマンドで確認できます。

    os-curl $URL_nova/servers  # example

  jsonの生データが取得できるため、`jq`コマンドでお好きなように料理してください。

### できること2 - 簡易コマンドでpythonクライアントの真似事

  pythonクライアントがあれば不要な機能ですが、pythonクライアントをインストール
  したくないホストからAPIアクセスを行いたい場合などに使用してください。
  マニュアルはまだありません。。。詳細は`os-functions`の中身を参照してください。
  例えば以下のようなことができます。

#### インスタンスリストの取得

    # get_hostlist
    host3,bb5ee6f5-a0be-40ec-aac5-36b918f26294,apache,ACTIVE
    host2,22dc3cf8-6913-4a05-9e51-ff0eb944a628,postgres,ACTIVE
    host4,a6042e2a-2977-4cb4-9d9d-af5ee34ef27a,load-balancer,ACTIVE

#### イメージリストの取得

    # get_imagelist
    263a8f1f-78aa-4a2d-a15d-8afbd993a3fe,active,rhel7.2-forOS-base
    dfcc641a-f836-4c08-baf4-8a5fffa7715e,active,rhel6.5-clean
    610300b7-676e-48ea-9209-9438db97ddb9,active,rhel6.5-forOS-base
    4ed67397-da5b-4501-8891-42a7ae035184,active,rhel7.2-base

#### イメージダウンロード

    # download_image rhel7.2-forOS-base
    # ls rhel7.2-forOS-base.qcow2
    rhel7.2-forOS-base.qcow2

### できること3 - pythonクライアントのbash-completion設定

  おまけでついています。

