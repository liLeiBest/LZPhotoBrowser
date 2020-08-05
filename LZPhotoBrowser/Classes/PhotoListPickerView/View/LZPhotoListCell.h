//
//  LZPhotoListCell.h
//  LZPhotoBrowser
//
//  Created by Dear.Q on 2020/2/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZPhotoListCell : UICollectionViewCell

// 图片（UIImage、NSNull）
@property (nonatomic, strong) NSObject *photoImg;
// 删除响应回调
@property (nonatomic, copy) void (^deleteDidTouchCallback)(LZPhotoListCell *cell);

@end

NS_ASSUME_NONNULL_END
