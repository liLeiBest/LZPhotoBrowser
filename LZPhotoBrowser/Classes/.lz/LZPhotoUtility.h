//
//  LZPhotoUtility.h
//  LZPhotoBrower
//
//  Created by Dear.Q on 2019/4/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZPhotoUtility : NSObject

+ (void)fetchPhtotoAlbums;

@end

void LZAlert(NSString *title, NSString *content);
void LZAlert1(NSString *title, NSString *content, void(^ __nullable SureHandler)(UIAlertAction * _Nonnull action));
void LZAlert2(NSString *title, NSString *content, void(^ __nullable SureHandler)(UIAlertAction * _Nonnull action), void(^ __nullable CancleHandler)(UIAlertAction * _Nonnull action));

NS_ASSUME_NONNULL_END
