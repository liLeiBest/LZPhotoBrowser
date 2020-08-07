Pod::Spec.new do |s|

    s.name          = 'LZPhotoBrowser'
    s.version       = '0.1.2'
    s.summary       = 'A short description of LZPhotoBrowser..'
    s.description      = <<-DESC
    图片浏览器：
    1.选择图片列表。
    2.图片展示宫格。
                         DESC
    s.homepage      = 'https://github.com/liLeiBest'
    s.license       = 'MIT'
    s.author        = { 'lilei' => 'lilei0502@139.com' }
    s.social_media_url = 'https://github.com/liLeiBest'
    s.source        = { :git => 'https://github.com/liLeiBest/LZPhotoBrowser.git', :tag => s.version.to_s }
    s.requires_arc  = true
    s.platform      = :ios, '9.0'
    s.frameworks    = 'Foundation', 'UIKit', 'Photos'

    # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.public_header_files     = 'LZPhotoBrowser/Classes/**/*.h'
    s.source_files            =
    'LZPhotoBrowser/Classes/**/*.{h,m}',
#    'LZPhotoBrowser/Classes/PhotoListPickerView/**/*.storyboard',
    ''

    # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.resource_bundles        = {
            'LZPhotoBrowserResourceBundle' => ['LZPhotoBrowser/Classes/Resources/*']
        }
    s.resource                =   'LZPhotoBrowser/Classes/Resources/LZPhotoListPickerViewController.storyboardc'

    # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.dependency 'LZDependencyToolkit'
    s.dependency 'ZLPhotoBrowser'
    s.dependency 'SDWebImage'

    # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
    # s.dependency "JSONKit", "~> 1.4"
	
	pch_AF = <<-EOS
    
    static NSString * const LZPhotoBrowserBundle = @"LZPhotoBrowserResourceBundle";
    #import <LZDependencyToolkit/LZDependencyToolkit.h>
    
    EOS
    s.prefix_header_contents = pch_AF

end
