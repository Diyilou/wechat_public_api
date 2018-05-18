#####################################################
# 公众号自定义菜单栏模块 (about wechat public menu)
# Created by zhangmingxin
# Date: 2018-05-17
# Wechat number: zmx119966
####################################################

require "wechat_public_api/access_token"

module WechatPublicApi
  module Menu
    class << self

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
      def create(post_data)
        # request access_token
        access_token = AccessToken.get()

        uri = URI.parse("https://api.weixin.qq.com/cgi-bin/menu/create?access_token=#{access_token}")
        post_data = post_data
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Post.new("/cgi-bin/menu/create?access_token=#{access_token}")
        request.add_field('Content-Type', 'application/json')
        request.body = post_data
        response = http.request(request)
        (JSON.parse response.body)
      end

      # get wechat public menu list
      def query()
        # request access_token
        access_token = AccessToken.get()
        response = HTTParty.get("https://api.weixin.qq.com/cgi-bin/menu/get?access_token=ACCESS_TOKEN=#{access_token}").body
        (JSON.parse response)
      end

      ###
      # delete wechat query from access_token
      # @return <JSON> {"errcode"=>0, "errmsg"=>"ok"}
      #
      def delete()
        # request access_token
        access_token = AccessToken.get()
        response = HTTParty.get("https://api.weixin.qq.com/cgi-bin/menu/delete?access_token=ACCESS_TOKEN=#{access_token}").body
        (JSON.parse response)
      end
    end
  end
end
