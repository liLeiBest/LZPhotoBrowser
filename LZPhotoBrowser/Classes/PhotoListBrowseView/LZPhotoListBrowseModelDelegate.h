//
//  LZPhotoListBrowseModelDelegate.h
//  LZPhotoBrowser
//
//  Created by Dear.Q on 2020/3/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LZPhotoListBrowseModelDelegate <NSObject>

/// 原图
@property (nonatomic, strong) NSURL *photoURL;

@optional
/// 缩略图
@property (nonatomic, strong) NSURL *thumbnailPhotoURL;
/// 占位图
@property (nonatomic, strong) UIImage *placeholderImg;
/// 扩展对象，可以用于视频对象
@property (nonatomic, strong) NSObject *extend;

@end

NS_ASSUME_NONNULL_END
