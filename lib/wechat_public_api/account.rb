#####################################################
# 微信公众号帐号管理 （带参二维码获得）
# Created by zhangmingxin
# Date: 2018-05-18
# Wechat number: zmx119966
####################################################

require "wechat_public_api/access_token"

module WechatPublicApi
  module Account
    class << self

      ###
      # 获取临时场景带惨二维码，30天有效
      # @param <int> sceneid -- 场景值ID，临时二维码时为32位非0整型，永久二维码时最大值为100000（目前参数只支持1--100000）
      # @return <string> url -- 二维码网址
      #
      def qrscene(sceneid)
        access_token = AccessToken.get()

        # 获取ticket
        uri = URI.parse("https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=#{access_token}")
        post_data = {
            'expire_seconds' => 2592000,
            'action_name' => 'QR_SCENE',
            'action_info' => {'scene' => {'scene_id' => sceneid}}}
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Post.new("/cgi-bin/qrcode/create?access_token=#{access_token}")
        request.add_field('Content-Type', 'application/json')
        request.body = post_data.to_json
        response = http.request(request)
        content = JSON.parse(response.body)
        ticket = content['ticket']

        # 通过ticket换取二维码
        url = 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=' + ticket
        url
      end

      ###
      # @param <int> sceneid -- 场景值ID，临时二维码时为32位非0整型，永久二维码时最大值为100000（目前参数只支持1--100000）
      # @return <string> url -- 二维码网址
      #
      def qrsrtscene(sceneid)
        access_token = AccessToken.get()

        # 获取ticket
        uri = URI.parse("https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=#{access_token}")
        post_data = {
            'action_name' => 'QR_LIMIT_STR_SCENE',
            'action_info' => {'scene' => {'scene_id' => sceneid}}}
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Post.new("/cgi-bin/qrcode/create?access_token=#{access_token}")
        request.add_field('Content-Type', 'application/json')
        request.body = post_data.to_json
        response = http.request(request)
        content = JSON.parse(response.body)
        ticket = content['ticket']

        # 通过ticket换取二维码
        url = 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=' + ticket
        url
      end

      ###
      # 保存带参数二维码到指定位置
      # @param <string> path -- 例如： "#{Rails.root}/public/qrcode"
      # @param <string> filename -- 文件名，可选参数，默认不填写则使用时间戳+随机数的方式命名
      #
      # @return <string> path -- 二维码的保存路径
      def save_qrcode(path, *filename)
        # 判断是否需要新建文件
        unless File.exist?(path)
          FileUtils.makedirs(path)
        end

        if filename
          path = "#{path}/#{filename}"
        else
          path = "#{path}/#{Time.now.to_i.to_s}_#{rand 1000.9999}"
        end

        File.open(path, 'wb') do |f|
          f.write(HTTParty.get(url).body)
        end

        path
      end

      ###
      # @param <string> longurl -- 需要被压缩的url
      #
      # @return <json> shorturl -- 返回短链接 {"errcode":0,"errmsg":"ok","short_url":"http:\/\/w.url.cn\/s\/AvCo6Ih"}
      # if false
      # @return {"errcode":40013,"errmsg":"invalid appid"}
      #
      def shorturl(longurl)
        access_token = AccessToken.get()
        uri = URI.parse("https://api.weixin.qq.com/cgi-bin/shorturl?access_token=#{access_token}")
        post_data = {action: "long2short", long_url: longurl}
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Post.new("/cgi-bin/shorturl?access_token=#{access_token}")
        request.add_field('Content-Type', 'application/json')
        request.body = post_data.to_json
        response = http.request(request)

        JSON.parse(response.body)
      end
    end
  end
end
