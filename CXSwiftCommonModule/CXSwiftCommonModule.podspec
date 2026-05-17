#
# Be sure to run `pod lib lint CXSwiftCommonModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CXSwiftCommonModule'
  s.version          = '1.0.0'
  s.summary          = 'A short description of CXSwiftCommonModule.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://code.aliyun.com/zainguo/CXSwiftCommonModule.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zainguo' => '572249347@qq.com' }
  s.source           = { :git => 'https://code.aliyun.com/zainguo/CXSwiftCommonModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.swift_version = '5.0'

  # s.source_files = 'CXSwiftCommonModule/Classes/**/Constant.swift'

  # s.resource_bundles = {
  #   'CXSwiftCommonModule' => ['CXSwiftCommonModule/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'

   s.frameworks = 'UIKit'

   s.subspec 'Const' do |ss|
     ss.source_files  = 'CXSwiftCommonModule/Classes/Const/*.swift'
     ss.dependency 'CXSwiftCommonModule/Extension'

   end

   s.subspec 'Extension' do |ss|
     ss.source_files = 'CXSwiftCommonModule/Classes/Extension/*.swift'
     # 网络请求
     ss.dependency 'Moya/RxSwift'
     # 指定网络库，不然会崩溃，因为5.5.0使用了新的多线程特性
     ss.dependency 'Alamofire'
     # RX
     ss.dependency 'RxCocoa'
     # 图片加载
     ss.dependency 'Kingfisher'
     # KakaJSON
     ss.dependency 'KakaJSON'
     # MJRefresh
     ss.dependency 'MJRefresh'
     # HUD
#     ss.dependency 'MBProgressHUD'
     ss.dependency 'CXSwiftCommonModule/Tools'

   end

   s.subspec 'NavigationBar' do |ss|
     ss.source_files  = 'CXSwiftCommonModule/Classes/NavigationBar/*.swift'
     ss.dependency 'CXSwiftCommonModule/Extension'
   end

   s.subspec 'Network' do |ss|
     ss.source_files  = 'CXSwiftCommonModule/Classes/Network/*.swift'
     # 网络请求
     ss.dependency 'CXSwiftCommonModule/Extension'
   end

   s.subspec 'Router' do |ss|
     ss.source_files  = 'CXSwiftCommonModule/Classes/Router/*.swift'
     ss.dependency 'CXSwiftCommonModule/Extension'
   end

   s.subspec 'Tools' do |ss|
     ss.source_files  = 'CXSwiftCommonModule/Classes/Tools/*.swift'
   end

   s.subspec 'Then' do |ss|
   	ss.source_files = 'CXSwiftCommonModule/Classes/Then/*.swift'
   end

   s.subspec 'Reusable' do |ss|
   	ss.source_files = 'CXSwiftCommonModule/Classes/Reusable/*.swift'
   end
   
   s.subspec 'MBProgressHUD' do |ss|
     ss.source_files  = 'CXSwiftCommonModule/Classes/MBProgressHUD/*.{h,m}'
   end


end
