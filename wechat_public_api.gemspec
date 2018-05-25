
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "wechat_public_api/version"

Gem::Specification.new do |spec|
  spec.name          = "wechat_public_api"
  spec.version       = WechatPublicApi::VERSION
  spec.authors       = ["张明鑫 wechat number: zmx119966"]
  spec.email         = ["mnzmx_z@163.com"]

  spec.summary       = %q{微信公众号开发API，包含对微信公众号菜单栏、客服消息、模板消息、帐号管理等接口的封装，API长期更新维护，建议使用最新版本.}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/Diyilou/wechat_public_api.git"
  spec.license       = "MIT"
  spec.documentation = "https://yuque.com/qianlansedehei/wechat_public_api"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "redis"
  spec.add_development_dependency "httparty"
  spec.add_development_dependency "json"
  spec.add_development_dependency "rest-client"
  spec.add_development_dependency 'unf_ext', '~> 0.0.7.5'
end
