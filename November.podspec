Pod::Spec.new do |spec|

  spec.name         = "November"
  spec.version      = "3.0.0"
  spec.summary      = "A handy API to convert `Date` to `String` and back written in swift"
  spec.description  = <<-DESC
  November provides a set of extensions to `Date` and `DateFormatter` to build a nice API which simplify the conversion from `Date` to `Strin and back.

  Creating a `NSDateFormatter` is an expensive task. For this reason, **November** takes care of caching the created `DateFormatter` in order to reuse them along the lifecycle of your app. 

                   DESC
  spec.homepage     = "https://github.com/ManueGE/November/"
  spec.license      = "MIT"


  spec.author    = "Manuel García-Estañ"
  spec.social_media_url   = "http://twitter.com/ManueGE"

  spec.ios.deployment_target  = '8.0'
  spec.osx.deployment_target  = '10.13'
  spec.tvos.deployment_target  = '11.2'
  spec.source       = { :git => "https://github.com/ManueGE/November.git", :tag => "#{spec.version}" }

  spec.requires_arc = true
  spec.framework = "Foundation"

  spec.source_files = "November/November/*.{swift}"

end
