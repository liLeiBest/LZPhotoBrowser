//
//  LZPhotoListBrowseView.h
//  LZPhotoBrowser
//
//  Created by Dear.Q on 2020/3/30.
//

#import <UIKit/UIKit.h>
#import "LZPhotoListBrowseViewConfigModel.h"
#import "LZPhotoListBrowseModelDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface LZPhotoListBrowseView : UIView

/// LZPhotoListBrowseViewConfigModel
@property (nonatomic, strong) LZPhotoListBrowseViewConfigModel *config;


/// 更新图片数据源，需要提前计算 Frame
/// @param photoDataSource  NSArray
/// @param frameDataSource  NSArray
- (void)updatePhotoDataSource:(NSArray<id<LZPhotoListBrowseModelDelegate>> *)photoDataSource
              frameDataSource:(NSArray *)frameDataSource;

@end

NS_ASSUME_NONNULL_END
