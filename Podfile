platform :ios, '9.0'
inhibit_all_warnings!
source 'https://github.com/CocoaPods/Specs.git'

target 'AlphaWallet' do
  use_frameworks!

  pod 'BigInt', '~> 3.0'
  pod 'R.swift'
  pod 'JSONRPCKit', :git=> 'https://github.com/bricklife/JSONRPCKit.git'
  pod 'APIKit'
  pod 'Eureka', '~> 4.0.1'
  pod 'MBProgressHUD'
  pod 'StatefulViewController'
  pod 'QRCodeReaderViewController', :git=>'https://github.com/yannickl/QRCodeReaderViewController.git', :branch=>'master'
  pod 'KeychainSwift'
  pod 'SwiftLint'
  pod 'SeedStackViewController'
  pod 'RealmSwift'
  pod 'BonMot', '~> 5.0'
  pod 'Lokalise'
  pod 'Moya', '~> 10.0.1'
  pod 'JavaScriptKit'
  pod 'CryptoSwift', :git=>'https://github.com/krzyzanowskim/CryptoSwift', :branch=>'master'
  pod 'SwiftyXMLParser', :git => 'https://github.com/yahoojapan/SwiftyXMLParser.git'
  pod 'Kingfisher', '~> 4.0'
  pod 'TrustKeystore', :git=>'https://github.com/alpha-wallet/trust-keystore-snapshot', :branch=>'master'
  pod 'SwiftyJSON'
  # pod 'web3swift', :git=>'https://github.com/BANKEX/web3swift', :branch=>'master'
  pod 'SAMKeychain'
  pod 'iOSSnapshotTestCase'

  target 'AlphaWalletTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'AlphaWalletUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['JSONRPCKit'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.0'
      end
    end
    if ['TrustKeystore'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
      end
    end
  end
end

