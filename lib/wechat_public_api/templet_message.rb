#####################################################
# 微信公众号模板消息相关接口 (About templet message of wechat public)
# Created by zhangmingxin
# Date: 2018-05-17
# Wechat number: zmx119966
####################################################

class WechatPublicApi
  module Tp
    ###
    # @param <JSON> message
    # @param <string> url_params  -- 消息路径
    # 发送模板消息接口
    def post_template_message(message, url_params)
      # get access_token
      access_token = get_access_token()

      uri = URI.parse("https://api.weixin.qq.com/cgi-bin/message/template/#{url_params}?access_token=#{access_token}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Post.new("/cgi-bin/message/template/#{url_params}?access_token=#{access_token}")
      request.add_field('Content-Type', 'application/json')
      # 部分字符转换为json后  成为unicode编码
      request.body = message.to_json.gsub(/\\u([0-9a-z]{4})/) {|s| [$1.to_i(16)].pack("U")}
      response = http.request(request)
      JSON.parse(response.body)
    end

    ###
    # @param <string> openid -- 用户的openid
    # @param <string> templet_id -- 微信公众号后台提供的模板ID
    # @param <string> url -- 模板跳转链接
    # @param <string> appid -- 小程序的appid
    # @param <string> pagepath -- 小程序页面路径 (eq: /index/index)
    # @param <JSON> data -- 模板数据
    # => data example
    # data = {
    #    "first": {
    #        "value":"恭喜你购买成功！",
    #        "color":"#173177"
    #    },
    #    "keyword1":{
    #        "value":"巧克力",
    #        "color":"#173177"
    #    },
    #    "keyword2": {
    #        "value":"39.8元",
    #        "color":"#173177"
    #    },
    #    "keyword3": {
    #        "value":"2014年9月22日",
    #        "color":"#173177"
    #    },
    #    "remark":{
    #        "value":"欢迎再次购买！",
    #        "color":"#173177"
    #    }
    #  }
    # 小程序模板消息
    def tp_miniprogram_message(openid, templet_id, url, appid, pagepath, data)
      message = {
          'touser': openid,
          'template_id': templet_id,
          'url': url,
          "miniprogram":{
             "appid": appid,
             "pagepath": pagepath
           },
          'data': data
      }

      post_template_message message, 'send'
    end

    # 普通的模板消息，不跳转小程序
    def tp_general_message(openid, templet_id, url, data)
      message = {
          'touser': openid,
          'template_id': templet_id,
          'url': url,
          'data': data
      }
      post_template_message message, 'send'
    end

    # 删除模板
    def tp_delete_template(templet_id)
      message = {
        'template_id': template_id
      }
      post_template_message message, 'del_private_template'
    end

    # 获得模板列表
    def tp_get_all()
      access_token = get_access_token()
      response = HTTParty.get("https://api.weixin.qq.com/cgi-bin/template/get_all_private_template?access_token=#{access_token}").body
      response_body = (JSON.parse response)
      response_body
    end
  end
end
