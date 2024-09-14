# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Arabic Keyboard Ex.' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for Arabic Keyboard Ex.
  pod 'SideMenuSwift'
#  pod 'SwiftyStoreKit'

end

target 'Arabic Keyboard Ios' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Arabic Keyboard Ios
  pod 'SideMenuSwift'
  pod 'SwiftyStoreKit'
  pod 'Google-Mobile-Ads-SDK'
  pod 'SVProgressHUD'
  pod 'RevenueCat'
  pod 'iOSDropDown'
  pod 'Firebase/Crashlytics'
  pod 'GoogleMLKit/Translate'
  pod 'GoogleMLKit/LanguageID'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['APPLICATION_EXTENSION_API_ONLY'] = 'No'
     end
  end
end
