#####################################################
# 获得微信公众号的 access_token (Get wechat public access_token)
# Created by zhangmingxin
# Date: 2018-05-17
# Wechat number: zmx119966
####################################################

module WechatPublicApi
  module AccessToken
    class << self

      ###
      # 获取 access_token
      # 判断access_token_cache，决定是否需要缓存数据
      # @return <string> nil or access_token
      def get()
        appid = WechatPublicApi.app_id
        secret = WechatPublicApi.app_secret
        access_token_cache = WechatPublicApi.access_token_cache

        unless access_token_cache
          response = HTTParty.get("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{appid}&secret=#{secret}").body
          response_body = (JSON.parse response)
          
          unless response_body['access_token']
            return response_body
          end

          return response_body['access_token']
        end

        _cache_key = "#{appid}_access_token"
        _cached_access_token = $redis.get _cache_key
        if _cached_access_token == nil or _cached_access_token == ''
          response = HTTParty.get("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{appid}&secret=#{secret}").body
          response_body = (JSON.parse response)

          unless response_body['access_token']
            return response_body
          end

          _cached_access_token = response_body['access_token']
          $redis.set _cache_key, _cached_access_token, ex: 2.minutes
        end
        _cached_access_token
      end
    end
  end
end
