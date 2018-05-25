require "wechat_public_api/version"
require "wechat_public_api/menu"
require "wechat_public_api/kf_message"
require "wechat_public_api/templet_message"
require "wechat_public_api/access_token"
require "wechat_public_api/account"
require "wechat_public_api/aes"
require "wechat_public_api/utils"
require "wechat_public_api/user"
require "wechat_public_api/material"

class WechatPublicApi
  include AccessToken
  include Account
  include Aes
  include Kf
  include Material
  include Menu
  include Tp
  include User
  include Utils

  # 默认不缓存 access_token, access_token_cache = True 缓存
  # @param <hash> aoptions
  # => example
  # wechat_api = WechatPublicApi.new appid: 'xx', app_secret: 'xx', access_token_cache: true
  # wechat_api.app_id -- get appid
  #
  #  api.get_access_token
  #

  attr_accessor :app_id, :app_secret, :access_token_cache
  def initialize(options={})
    @app_id = options[:app_id]
    @app_secret = options[:app_secret]
    @access_token_cache = options[:access_token_cache]
  end
end
