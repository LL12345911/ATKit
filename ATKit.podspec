#
#  Be sure to run `pod spec lint ATKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

   s.name         = 'AAChaATKitrtKit'
    s.version      = '1.0'
    s.summary      = '的信息图图表,完全满足工作所需.'
    s.description  = <<-DESC 
    ***
    ddddddd
    ***
                   DESC
    s.homepage     = 'https://github.com/LL12345911/ATKit'
    s.license      = { :type => "MIT", :file => 'LICENSE' }
    s.authors      = { "Mars" => "sky12345911@163.com" }
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/LL12345911/ATKit.git', :tag => s.version}
    s.social_media_url = 'https://github.com/LL12345911/ATKit'
    s.source_files = 'ATKitLib/**/*.{h,m}'
    #s.resource_bundles    = { 'AAChartKitLib' => 'AAChartKitLib/AAJSFiles.bundle' }
    s.prefix_header_contents = '#import "Atkit.h"'
    s.requires_arc = true
    s.ios.frameworks = 'UIKit'
    s.ios.deployment_target = '8.0'


end
