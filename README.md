# 简介

基于ruby的微信公众号开发的API，包含对微信公众号菜单栏、客服消息、模板消息、帐号管理等接口的封装。

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

#### 三行代码获得 access_token

```ruby
WechatPublicApi.app_id = 'appid'
WechatPublicApi.app_secret = 'secret'
access_token = WechatPublicApi::AccessToken.get() # access_token
```
#### 使用说明

##### 初始化配置

**源代码**

```ruby
module WechatPublicApi
  class << self
    # 默认不缓存 access_token, access_token_cache = True 缓存
    # @param <Boolearn> access_token_cache
    attr_accessor :app_id, :app_secret, :access_token_cache
  end
end
```

**参数说明**

> @param <String> app_id      # 公众号后台->开发->基本配置提供的AppID
> @param <String> app_secret  # 公众号后台->开发->基本配置提供的AppSecret
> @param <Boolearn> access_token_cache # 默认false，用于标识是否使用redis缓存查询到的access_token

使用`WechatPublicApi`模块封装的方法之前，需要配置 app_id、app_secret和access_token_cache（可选），具体如下：

```ruby
WechatPublicApi.app_id = 'appid'
WechatPublicApi.app_secret = 'secret'
access_token = WechatPublicApi::AccessToken.get() # access_token
```

`access_token_cache` 说明： access_token_cache是一个布尔值，用于判断是否需要缓存access_token_cache，默认可不填，即默认不缓存access_token，如需缓存，请依照下方代码设置参数：

```ruby
WechatPublicApi.access_token_cache = true
```

##### 功能列表

* 菜单栏操作
* 客服消息管理
* 模板消息管理

#### 菜单栏操作API

1. 自定义菜单查询

```ruby
# no params
# @return
# {
#   "menu": {
#       "button": [
#       {
#        "type": "view",
#        "name": "",
#        "url": "",
#        "sub_button": []
#       },
#       {
#        "type": "click",
#        "name": "",
#        "key": "menu_3",
#        "sub_button": []
#       }
#     ]
#   }
# }
#
menu_list = WechatPublicApi::Menu.query()
```

2. 自定义菜单创建

```ruby
###
# create wechat public menu
# @param <json> post_data
#
# =>  post_data example
# {
# 	  "button": [
#     {
#  		 "type": "view",
#  		 "name": "",
#  		 "url": "",
#  		 "sub_button": []
#  	  },
#     {
#  		 "type": "click",
#  		 "name": "",
#  		 "key": "menu_3",
#  		 "sub_button": []
#  	  }
#   ]
# }
#
# if success
# @return <JSON> {"errcode"=>0, "errmsg"=>"ok"}
# if failed
# @return <JSON> {"errcode"=>40166, "errmsg"=>"...."}
#
status = WechatPublicApi::Menu.create(post_data)
```

3. 自定义菜单删除

```ruby
# @return <JSON> {"errcode"=>0, "errmsg"=>"ok"}
status = WechatPublicApi::Menu.delete()
```

菜单栏操作API主要包含以上三个方法，接下来看一个完整示例：

```ruby
# 创建菜单栏 -> 查询菜单栏裂变
# 初始化配置
WechatPublicApi.app_id = 'wx440415e4c3b4b8f9'
WechatPublicApi.app_secret = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
# 创建菜单栏
post_data = {
	  "button": [
    {
 		 "type": "view",
 		 "name": "",
 		 "url": "",
 		 "sub_button": []
 	  },
    {
 		 "type": "click",
 		 "name": "",
 		 "key": "menu_3",
 		 "sub_button": []
 	  }
  ]
}
status = WechatPublicApi::Menu.create(post_data)
if status.errcode.to_i == 0 && status.errmsg == 'ok'
  # 返回菜单栏列表
  menu_list = WechatPublicApi::Menu.query()
end
```

**注意：** 菜单栏创建和查询的方法包含了查询access_token

#### 客服消息管理API
