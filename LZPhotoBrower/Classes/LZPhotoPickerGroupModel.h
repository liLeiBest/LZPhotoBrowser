//
//  LZPhotoPickerGroupModel.h
//  Pods
//
//  Created by Dear.Q on 2017/12/7.
//
//

#import <Foundation/Foundation.h>

@interface LZPhotoPickerGroupModel : NSObject

/** 相薄名称 */
@property (copy, nonatomic) NSString *groupName;
/** 相薄封面 */
@property (strong, nonatomic) UIImage *coverImage;
/** 相薄图片张数 */
@property (assign, nonatomic) NSUInteger assetsCount;

@end
