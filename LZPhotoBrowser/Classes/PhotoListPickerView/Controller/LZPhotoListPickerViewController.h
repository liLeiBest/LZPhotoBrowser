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
/// 主题色，默认
@property (nonatomic, strong) UIColor *themeColor;
/// 图片选择列表改变回调
@property (nonatomic, copy) void (^selectPhotoListDidChangeCallback)(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets);


/// 实例
+ (instancetype)instance;

@end

NS_ASSUME_NONNULL_END
