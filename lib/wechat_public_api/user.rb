#####################################################
# 公众号用户管理
# Created by zhangmingxin
# Date: 2018-05-18
# Wechat number: zmx119966
####################################################

class WechatPublicApi
  module User
    # 获取用户信息
    # @return <JSON>
    # {
    #     "subscribe": 1,
    #     "openid": "o6_bmjrPTlm6_2sgVt7hMZOPfL2M",
    #     "nickname": "Band",
    #     "sex": 1,
    #     "language": "zh_CN",
    #     "city": "广州",
    #     "province": "广东",
    #     "country": "中国",
    #     "headimgurl":"http://thirdwx.qlogo.cn/mmopen/g3MonUZtNHkdmzicIlibx6iaFqAc56vxLSUfpb6n5WKSYVY0ChQKkiaJSgQ1dZuTOgvLLrhJbERQQ4eMsv84eavHiaiceqxibJxCfHe/0",
    #     "subscribe_time": 1382694957,
    #     "unionid": " o6_bmasdasdsad6_2sgVt7hMZOPfL"
    #     "remark": "",
    #     "groupid": 0,
    #     "tagid_list":[128,2],
    #     "subscribe_scene": "ADD_SCENE_QR_CODE",
    #     "qr_scene": 98765,
    #     "qr_scene_str": ""
    # }
    #
    # if failed
    # {"errcode":40013,"errmsg":"invalid appid"}
    #
    def get_userinfo(openid)
      # request access_token
      access_token = get_access_token()
      JSON.parse HTTParty.get("https://api.weixin.qq.com/cgi-bin/user/info?access_token=#{access_token}&openid=#{openid}&lang=zh_CN").body
    end
  end
end
