#####################################################
# 客服消息管理 (about kf_account message)
# Created by zhangmingxin
# Date: 2018-05-17
# Wechat number: zmx119966
####################################################

module WechatPublicApi
  module Kf
    class << self

      # 是否设置使用指定客服发送客服消息，如果不指定可以不填写
      # @param <string> kf_account
      attr_accessor :kf_account

      ###
      # execute post
      # => example
      # message = {
      #   touser: openid,
      #   msgtype: 'text',
      #   text: {content: content},
      #   customservice:{
      #     kf_account: 'xxxxxxxx'
      #   }
      # }
      #
      # @param <JSON> message
      #
      def self.post_customer_message(message)
        # get access_token
        access_token = AccessToken.get()

        uri = URI.parse("https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=#{access_token}")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Post.new("/cgi-bin/message/custom/send?access_token=#{access_token}")
        request.add_field('Content-Type', 'application/json')
        request.body = message.to_json.gsub(/\\u([0-9a-z]{4})/) {|s| [$1.to_i(16)].pack("U")}
        response = http.request(request)
        JSON.parse(response.body)
      end

      ###
      # @param <string> openid  -- 用户的openid
      # @param <string> content -- 需要发送的客服消息内容
      #
      # 发送文字消息
      def self.text_message(openid, content)

        custom_message = {
          touser: openid,
          msgtype: 'text',
          text: {content: content}
        }

        if kf_account
          custom_message.merge({customservice:{account: kf_account}})
        end

        self.post_customer_message custom_message
      end

      ###
      # @param <string> media_id  -- 发送的图片/语音/视频/图文消息（点击跳转到图文消息页）的媒体ID
      #
      # 发送图片消息
      def self.image_message(openid, media_id)

        custom_message = {
          touser: openid,
          msgtype: 'image',
          image: {media_id: media_id}
        }

        if kf_account
          custom_message.merge({customservice:{account: kf_account}})
        end

        self.post_customer_message custom_message
      end

      # 发送图文消息（点击跳转到图文消息页面）
      def mpnews_message(openid, media_id)
        custom_message = {
          touser: openid,
          msgtype: 'mpnews',
          mpnews: {media_id: media_id}
        }
        if kf_account
          custom_message.merge({customservice:{account: kf_account}})
        end

        self.post_customer_message custom_message
      end

      ###
      # @param <JSON> articles -- 图文消息列表
      # => example
      # articles = [
      #   {
      #       "title":"Happy Day",
      #       "description":"Is Really A Happy Day",
      #       "url":"URL",
      #       "picurl":"PIC_URL"
      #   },
      #   {
      #       "title":"Happy Day",
      #       "description":"Is Really A Happy Day",
      #       "url":"URL",
      #       "picurl":"PIC_URL"
      #   }
      # ]
      #
      # 发送图文消息（点击跳转到外链）
      def self.news_message(openid, articles)
        custom_message = {
            touser: openid,
            msgtype: 'news',
            news: {
              articles: articles
            }
        }

        if kf_account
          custom_message.merge({customservice:{account: kf_account}})
        end
        self.post_customer_message custom_message
      end

      # 发送语音消息
      def self.voice_message(openid, media_id)

        custom_message = {
            touser: openid,
            msgtype: 'voice',
            voice: {
              media_id: media_id
            }
        }
        if kf_account
          custom_message.merge({customservice:{account: kf_account}})
        end
        self.post_customer_message custom_message
      end
    end
  end
end
