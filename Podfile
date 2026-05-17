# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'UURecoveryApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Swift基础库
  pod 'CXSwiftCommonModule',  :path => './CXSwiftCommonModule'
  # 轮播图组件库
  pod 'ZCycleView',  :path => './ZCycleView'
  # 钥匙串
  pod 'KeychainSwift',  :path => './keychain-swift'
  # IGListKit
  pod 'IGListKit', '4.0.0'
  # UserDefaults二次封装
  pod 'DefaultsKit'
  # Snapkit
  pod 'SnapKit'
  # 键盘管理
  pod 'IQKeyboardManager'
  
  # TabController
  pod "ESTabBarController-swift"
  # 布局
  pod 'FlexLayout'
  pod 'PinLayout'
  # 轮播图
  pod 'JJCarouselView'
  # 分页控制器
  pod 'JXSegmentedView'
  # 支付宝
  pod 'AlipaySDK-iOS'
  
  # 巨量归因
  pod 'BDASignalSDK'
  #  选择照片
  pod 'ZLPhotoBrowser'
  
 

  post_install do |installer|
      installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        end
      end
    end

end

