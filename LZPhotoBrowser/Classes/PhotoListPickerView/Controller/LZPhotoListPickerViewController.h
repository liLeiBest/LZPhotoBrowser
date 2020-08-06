//
//  LZPhotoListPickerViewController.h
//  LZPhotoBrowser
//
//  Created by Dear.Q on 2020/2/27.
//

#import <UIKit/UIKit.h>
@class PHAsset;
NS_ASSUME_NONNULL_BEGIN

@interface LZPhotoListPickerViewController : UICollectionViewController

/// 最大图片数，默认 6张
@property (nonatomic, assign) NSUInteger maxCount;
/// 最大列数，默认 4 列
@property (nonatomic, assign) NSUInteger columns;
/// 行或列间距，默认 10
@property (nonatomic, assign) CGFloat spacing;
/// 内边距，默认 UIEdgeInsetsZero
@property (nonatomic, assign) UIEdgeInsets insets;
/// 主题色，默认 R:80 G:169 B:52
@property (nonatomic, strong) UIColor *themeColor;
/// 图片选择列表改变回调
@property (nonatomic, copy) void (^selectPhotoListDidChangeCallback)(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets, CGFloat totalHeight);


/// 实例
+ (instancetype)instance;

@end

NS_ASSUME_NONNULL_END
