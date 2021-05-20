source 'https://github.com/CocoaPods/Specs.git'
source 'git@git.core.cloud.weemo.com:ios/cocoapods-internal.git'

platform :ios, '13.0'

target "SightCallAgent" do
  use_frameworks!
  
  # USDK pod
  # - to integrate it as a development pod, use :path. Ex:
 #pod 'LSUniversalSDK', :path => '../livesight-universalsdk'
  # - for a release version, use the :git parameter. Ex:
 pod 'LSUniversalSDK', :git => 'git@git.core.cloud.weemo.com:ios/livesight-universalsdk.git', :branch => 'develop'
  # - you can also use a :branch, a :tag or a :commit parameter. Ex:
  
  
  pod 'LSUniversalBroadcastSDK', :git => 'git@git.core.cloud.weemo.com:ios/livesight-universalbroadcastsdk.git'
  pod 'LSApplicationModelSDK', :git => 'git@git.core.cloud.weemo.com:ios/livesight-visual-support-model.git'
#   pod 'LSBrandedAppColors', :git => 'git@git.core.cloud.weemo.com:ios/cocoapods/LSBrandedAppColors.git'
#   pod 'LSQualityOfService', :git => 'git@git.core.cloud.weemo.com:ios/cocoapods/lsqualityofservice.git'
#   pod 'UIColor+Categories', :git => 'git@git.core.cloud.weemo.com:ios/uicolor-categories.git'
#   
#   pod 'OAStackView'
end

# target "Visual Broadcast" do
#   use_frameworks!
#   pod 'LSUniversalBroadcastSDK', :git => 'git@git.core.cloud.weemo.com:ios/livesight-universalbroadcastsdk.git'
# end

    post_install do |installer|
    	installer.pods_project.build_configurations.each do |config|
    		config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
    		
    		if config.name == 'Release'
              config.build_settings['BITCODE_GENERATION_MODE'] = 'bitcode'
          	else
              config.build_settings['BITCODE_GENERATION_MODE'] = 'marker'
          	end
    
    		cflags = config.build_settings['OTHER_CFLAGS'] || ['$(inherited)']
          	if config.name == 'Release'
              cflags << '$(inherited) -fembed-bitcode'
          	else
              cflags << '$(inherited) -fembed-bitcode-marker'
          	end    
          	config.build_settings['OTHER_CFLAGS'] = cflags
    	end
      installer.pods_project.targets.each do |target|
        target.build_configurations.each do |target_config|
          target_config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
        end
      end
end
