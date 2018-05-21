# 简介

基于ruby的微信公众号开发的API，包含对微信公众号菜单栏、客服消息、模板消息、帐号管理等接口的封装。

API长期更新维护，建议使用最新版本。

## 安装

添加 Gemfile:

```ruby
gem 'wechat_public_api'
```

执行 bundle:

    $ bundle install

或者直接通过 gem 安装:

    $ gem install wechat_public_api

## 0.1.4 版本文档

[0.1.4 版本文档][1]
[1]:https://github.com/Diyilou/wechat_public_api/blob/master/doc/0.1.4.md "版本：0.1.4"

## 两行代码获得 access_token

```ruby
wechat_api = WechatPublicApi.new appid: 'xx', app_secret: 'xx', access_token_cache: true
access_token = wechat_api.get_access_token
```
