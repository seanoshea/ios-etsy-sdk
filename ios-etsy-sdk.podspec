Pod::Spec.new do |s|
  
  s.name         = "ios-etsy-sdk"
  s.version      = "1.0"
  s.summary      = "Very simple read-only (no OAUTH) library to connect to a few Etsy services."
  s.homepage     = "https://github.com/seanoshea/ios-etsy-sdk"
  
  s.license      = { :type => "Apache 2", :file => 'LICENSE' }
  
  s.author       = { "Sean O Shea" => "oshea.ie@gmail.com" }
  
  s.source       = {
      :git => "https://github.com/seanoshea/ios-etsy-sdk.git",
      :tag => "1.0"
  }
  
  s.platform     = :ios, '5.0'
  
  s.source_files = 'ios-etsy-sdk/'
  
  s.requires_arc = true
  
end
