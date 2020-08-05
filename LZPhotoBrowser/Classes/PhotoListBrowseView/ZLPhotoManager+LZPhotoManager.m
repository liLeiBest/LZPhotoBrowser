//
//  ZLPhotoManager+LZPhotoManager.m
//  LZPhotoBrowser
//
//  Created by Dear.Q on 2020/8/5.
//

#import "ZLPhotoManager+LZPhotoManager.h"
#import "LZPhotoBrowserAppearanceModel.h"

@implementation ZLPhotoManager (LZPhotoManager)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originSelector = @selector(saveImageToAblum:completion:);
        SEL swizzleSelector = @selector(LZ_saveImageToAblum:completion:);
        LZ_exchangeClassMethod(self, originSelector, swizzleSelector);
    });
}

// MARK: - Private
+ (void)LZ_saveImageToAblum:(UIImage *)image
              completion:(void (^ _Nullable)(BOOL suc, PHAsset *asset))completion {
    if (YES == PhotoBrowserAppearanceConfig().watermark) {
        
        UIImage *watermarkImage = PhotoBrowserAppearanceConfig().watermarkImage;
        UIImage *newImage = [image watermark:watermarkImage point:LZWatermarkPointLeftBottom];
        NSString *watermarkText = PhotoBrowserAppearanceConfig().watermarkText;
        NSDictionary *attributes = @{
            NSForegroundColorAttributeName : [UIColor whiteColor],
            NSFontAttributeName : [UIFont systemFontOfSize:30],
        };
        newImage = [newImage watermark:watermarkText attributes:attributes point:LZWatermarkPointRightBottom];
        image = newImage;
    }
    [self LZ_saveImageToAblum:image completion:completion];
}

@end
