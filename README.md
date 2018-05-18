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

## 三行代码获得 access_token

```ruby
WechatPublicApi.app_id = 'appid'
WechatPublicApi.app_secret = 'secret'
access_token = WechatPublicApi::AccessToken.get() # access_token
```
## API文档

### WechatPublicApi模块配置，开启你的新项目

**参数说明**

* @param <String> app_id      # 公众号后台->开发->基本配置提供的AppID
* @param <String> app_secret  # 公众号后台->开发->基本配置提供的AppSecret
* @param <Boolearn> access_token_cache # 默认false，用于标识是否使用redis缓存查询到的access_token

使用`WechatPublicApi`模块封装的方法之前，需要配置 app_id、app_secret和access_token_cache（可选），具体如下：

```ruby
WechatPublicApi.app_id = 'wx440415e4c3b4b8f9'
WechatPublicApi.app_secret = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
access_token = WechatPublicApi::AccessToken.get() # access_token
```

**注意：** access_token_cache是一个布尔值，用于判断是否需要缓存access_token_cache，默认可不填，即默认不缓存access_token，如需缓存，请依照下方代码设置参数：

```ruby
WechatPublicApi.access_token_cache = true
```

### API功能概览

* 菜单栏操作
	* 创建菜单栏：`WechatPublicApi::Menu.create(post_data)`
	* 查询菜单栏：`WechatPublicApi::Menu.query()`
	* 删除菜单栏：`WechatPublicApi::Menu.delete()`
* 客服消息管理
	* 发送文字消息：`WechatPublicApi::Kf.text_message(openid, content)`
	* 发送图片消息：`WechatPublicApi::Kf.image_message(openid, media_id)`
	* 发送图文消息：`WechatPublicApi::Kf.mpnews_message(openid, media_id)`
	* 发送图文消息（点击跳转外链）: `WechatPublicApi::Kf.news_message(openid, articles)`
	* 发送语音消息：`WechatPublicApi::Kf.voice_message(openid, media_id)`
* 模板消息管理
	* 获取模板列表：`WechatPublicApi::Tp.get_all()`
	* 删除模板：`WechatPublicApi::Tp.delete(templet_id)`
	* 发送普通模板消息（不跳转小程序）`WechatPublicApi::Tp.general_message(openid, templet_id, url, data)`
	* 发送跳转小程序的模板消息：`WechatPublicApi::Tp.miniprogram_message(openid, templet_id, url, appid, pagepath, data)`
* 用户管理
  * 获取用户基本信息: `WechatPublicApi::User.get_userinfo(openid)`
* 帐号管理
  * 获取临时带参二维码: `WechatPublicApi::Account.qrscene(sceneid)`
  * 获取永久带参二维码: `WechatPublicApi::Account.qrsrtscene(sceneid)`
  * 保存带参二维码到本地： `WechatPublicApi::Account.save_qrcode(path, *filename)`
  * 生成短链接：`WechatPublicApi::Account.shorturl(longurl)`
* 素材管理
  * 获得临时图片素材的 media_id： `WechatPublicApi::Material.upload_image_media(file_path)`
  * 获得永久图片素材的 media_id： `WechatPublicApi::Material.upload_image_material(file_path)`
* 消息加密解密
  * 加密： `WechatPublicApi::Aes.encrypt(aes_key, text, app_id)`
  * 解密： `WechatPublicApi::Aes.decrypt(key, dicrypted_string)`

### 菜单栏操作API

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
# 创建菜单栏 -> 查询菜单栏列表
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

### 客服消息管理API

待更新... 可参考源代码，注释比较详细
