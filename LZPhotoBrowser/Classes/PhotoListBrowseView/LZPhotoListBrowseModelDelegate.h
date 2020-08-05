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
/// 缩略图
@property (nonatomic, strong) NSURL *thumbnailPhotoURL;
/// 占位图
@property (nonatomic, strong) UIImage *placeholderImg;

@end

NS_ASSUME_NONNULL_END
