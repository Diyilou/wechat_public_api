require "wechat_public_api/version"
require "wechat_public_api/menu"
require "wechat_public_api/kf_message"
require "wechat_public_api/templet_message"
require "wechat_public_api/access_token"
require "wechat_public_api/accout"
require "wechat_public_api/aes"
require "wechat_public_api/utils"
require "wechat_public_api/user"
require "wechat_public_api/material"

module WechatPublicApi
  class << self
    # 默认不缓存 access_token, access_token_cache = True 缓存
    # @param <Boolearn> access_token_cache
    attr_accessor :app_id, :app_secret, :access_token_cache
  end
end
