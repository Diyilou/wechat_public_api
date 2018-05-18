#####################################################
# 微信公众号素材管理
# Created by zhangmingxin
# Date: 2018-05-18
# Wechat number: zmx119966
####################################################

require "wechat_public_api/access_token"

module WechatPublicApi
  module Material
    class << self

      ###
      # 获得临时图片素材的 media_id
      # @param <string> file_path -- 图片素材的路径
      #
      # @return <json> {"type":"TYPE","media_id":"MEDIA_ID","created_at":123456789}
      # if false
      # @return <json> {"errcode":40004,"errmsg":"invalid media type"}
      #
      def upload_image_media(file_path)
        # request access_token
        access_token = AccessToken.get()
        response = RestClient.post('https://api.weixin.qq.com/cgi-bin/media/upload',
                                   {
                                       access_token: access_token,
                                       type: 'image',
                                       media: File.new(file_path, 'rb')})
        JSON.parse(response)
      end

      ###
      # 新增永久图片素材
      # @param <string> file_path -- 图片素材的路径
      #
      # @return <json> {"type":"TYPE","media_id":"MEDIA_ID","created_at":123456789}
      # if false
      # @return <json> {"errcode":40004,"errmsg":"invalid media type"}
      #
      def upload_image_material(file_path)
        # request access_token
        access_token = AccessToken.get()
        response = RestClient.post('https://api.weixin.qq.com/cgi-bin/material/add_material',
                                   {
                                       access_token: access_token,
                                       type: 'image',
                                       media: File.new(file_path, 'rb')})
        JSON.parse(response)
      end
    end
  end
end
