#####################################################
# 消息加密解密
# Created by zhangmingxin
# Date: 2018-05-18
# Wechat number: zmx119966
####################################################

class WechatPublicApi
  module Aes
    # 解密
    def decrypt(key, dicrypted_string)
      cipher = OpenSSL::Cipher::AES.new(256, :CBC)
      cipher.decrypt
      cipher.key = key
      cipher.iv = '0000000000000000'
      cipher.padding = 0
      cipher.update(dicrypted_string) << cipher.final
    end

    # 加密
    def encrypt(aes_key, text, app_id)
      text    = text.force_encoding("ASCII-8BIT")
      random  = SecureRandom.hex(8)
      msg_len = [text.length].pack("N")
      text    = "#{random}#{msg_len}#{text}#{app_id}"
      text    = WxAuth.encode(text)
      text    = handle_cipher(:encrypt, aes_key, text)
      Base64.encode64(text)
    end

    private
    def handle_cipher(action, aes_key, text)
      cipher = OpenSSL::Cipher.new('AES-256-CBC')
      cipher.send(action)
      cipher.padding = 0
      cipher.key = aes_key
      cipher.iv  = aes_key[0...16]
      cipher.update(text) + cipher.final
    end
  end
end
