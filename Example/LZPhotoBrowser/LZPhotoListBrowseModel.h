//
//  LZPhotoListBrowseModel.h
//  LZPhotoBrowser_Example
//
//  Created by Dear.Q on 2020/8/6.
//  Copyright © 2020 Dear.Q. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZPhotoListBrowseModel : NSObject<LZPhotoListBrowseModelDelegate>

/// 原图
@property (nonatomic, strong) NSURL *photoURL;
/// 缩略图
@property (nonatomic, strong) NSURL *thumbnailPhotoURL;
/// 占位图
@property (nonatomic, strong) UIImage *placeholderImg;

@end

NS_ASSUME_NONNULL_END
