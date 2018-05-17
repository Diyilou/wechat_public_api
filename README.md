# =简介

基于微信公众号开发的API，包含对微信公众号菜单栏、客服消息、模板消息、帐号管理等接口的封装。

## 安装

添加 Gemfile:

```ruby
gem 'wechat_public_api'
```

执行 bundle:

    $ bundle install

或者直接通过 gem 安装:

    $ gem install wechat_public_api

## 文档

### example: 三行代码获得 access_token

```ruby
WechatPublicApi.app_id = 'appid'
WechatPublicApi.app_secret = 'secret'
access_token = WechatPublicApi::AccessToken.get() # access_token
```
### 使用说明
