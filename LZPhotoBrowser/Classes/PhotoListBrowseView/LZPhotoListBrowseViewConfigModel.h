//
//  LZPhotoListBrowseViewConfigModel.h
//  LZPhotoBrowser
//
//  Created by Dear.Q on 2020/3/31.
//

#import <Foundation/Foundation.h>
#import "LZPhotoBrowserAppearanceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LZPhotoListBrowseViewConfigModel : NSObject

/// 默认配置
+ (LZPhotoListBrowseViewConfigModel * (^)(void))defaultConfig;
@property (nonatomic, strong, readonly) id sender;
- (LZPhotoListBrowseViewConfigModel * (^)(id sender))senderSet;

// MARK: <设置外观>
/// 外观
@property (nonatomic, strong, readonly) LZPhotoBrowserAppearanceModel *appearanceConfig;
/// 外观设置
- (LZPhotoListBrowseViewConfigModel * (^)(LZPhotoBrowserAppearanceModel *))appearanceConfigSet;

// MARK: <计算 Frame>
/// 最大显示数量
@property (nonatomic, assign, readonly) NSUInteger maxShowCount;
/// 图片实际张数
@property (nonatomic, assign, readonly) NSUInteger maxCount;
/// 高度
@property (nonatomic, assign, readonly) CGFloat height;
/// Frame 数组
@property (nonatomic, strong, readonly) NSArray *frameDataSource;
/** 视频播放回调 */
@property (nonatomic, copy) void(^videoPlayDidClick)(id videoModel);
/// 设置图片最大展示张数，默认 4
- (LZPhotoListBrowseViewConfigModel * (^)(NSUInteger))maxShowCountSet;
/// 设置图片实际张数，默认 4
- (LZPhotoListBrowseViewConfigModel * (^)(NSUInteger))maxCountSet;
/// 设置最大宽度，默认 [UIScreen mainScreen].bounds.size.width
- (LZPhotoListBrowseViewConfigModel * (^)(CGFloat))maxWidthSet;
/// 设置边距，默认 UIEdgeInsetsZero
- (LZPhotoListBrowseViewConfigModel * (^)(UIEdgeInsets))insetsSet;
/// 设置间距，默认 6.0
- (LZPhotoListBrowseViewConfigModel * (^)(CGFloat))spacingSet;
/// 开始计算高度和 Frame
- (LZPhotoListBrowseViewConfigModel * (^)(void))calcu;

@end

LZPhotoListBrowseViewConfigModel * defaultConfig(void);

NS_ASSUME_NONNULL_END
