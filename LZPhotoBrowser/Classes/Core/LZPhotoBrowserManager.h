//
//  LZPhotoBrowserManager.h
//  LZPhotoBrowser
//
//  Created by Dear.Q on 2020/3/5.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZPhotoBrowserManager : NSObject

/// 显示相册
/// @param sender  UIViewController
/// @param maxSelectCount 最大照片选择数
/// @param selectedAsset 已经选中的图片
/// @param handler  选择完成回调
+ (void)showPhotoLibraryWithSender:(UIViewController *)sender
                    maxSelectCount:(NSUInteger)maxSelectCount
                     selectedAsset:(NSMutableArray<PHAsset *> * _Nullable)selectedAsset
                completionCallback:(void (^)(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets))handler;

/// 预览用户已选择的照片，并可以取消已选择的照片
/// @param sender  UIViewController
/// @param photos 已选择的 UIImage 照片数组
/// @param assets 已选择的 PHAsset 照片数组
/// @param index 点击的照片索引
/// @param handler  选择完成回调
+ (void)previewWithSender:(UIViewController *)sender
                   photos:(NSArray<UIImage *> *)photos
                   assets:(NSArray<PHAsset *> *)assets
                    index:(NSInteger)index
       completionCallback:(void (^)(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets))handler;

/// 浏览图片
/// @param sender  UIViewController
/// @param photos 接收对象
/// @param index 点击的照片/视频索引
+ (void)previewWithSender:(UIViewController *)sender
                   photos:(NSArray *)photos
                    index:(NSInteger)index;

/// 配置主题色
/// @param themeColor UIColor
+ (void)configThemeColor:(UIColor *)themeColor;

@end

NS_ASSUME_NONNULL_END
