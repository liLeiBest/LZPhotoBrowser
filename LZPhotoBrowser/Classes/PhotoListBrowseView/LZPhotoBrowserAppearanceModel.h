//
//  LZPhotoBrowserAppearanceModel.h
//  LZPhotoBrowser
//
//  Created by Dear.Q on 2020/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZPhotoBrowserAppearanceModel : NSObject

/// 占位图
@property (nonatomic, strong, readonly) UIImage *placeholderImg;
/// 保存图片是否添加水印
@property (nonatomic, assign, readonly) BOOL watermark;
/// 水印图片
@property (nonatomic, strong, readonly) UIImage *watermarkImage;
/// 水印文本
@property (nonatomic, copy, readonly) NSString *watermarkText;
/// 设置占位图
- (LZPhotoBrowserAppearanceModel * (^)(UIImage *))placeholderImgSet;
/// 设置保存图片是否添加水印，默认 NO
- (LZPhotoBrowserAppearanceModel * (^)(BOOL))watermarkSet;
/// 设置水印图片，默认 nil
- (LZPhotoBrowserAppearanceModel * (^)(UIImage *))watermarkImageSet;
/// 设置水印文本，默认 nil
- (LZPhotoBrowserAppearanceModel * (^)(NSString *))watermarkTextSet;

@end

/// 实例，单例
LZPhotoBrowserAppearanceModel * PhotoBrowserAppearanceConfig(void);

NS_ASSUME_NONNULL_END
