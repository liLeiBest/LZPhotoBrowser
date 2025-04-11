//
//  LZPhotoBrowserManager.m
//  LZPhotoBrowser
//
//  Created by Dear.Q on 2020/3/5.
//

#import "LZPhotoBrowserManager.h"
#import "LZPhotoBrowserAppearanceModel.h"
#import <objc/objc.h>
#import <SDWebImage/SDWebImage.h>
#import <ZLPhotoBrowser/ZLPhotoBrowser-Swift.h>

UIColor *configThemeColor(UIColor *color) {
    static UIColor *_themeColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _themeColor = [UIColor colorWithR:80 G:169 B:52];
    });
    if (nil != color) {
        _themeColor = color;
    }
    return _themeColor;
}

@interface LZPhotoBrowserManager ()
@end
@implementation LZPhotoBrowserManager

// MARK: - Setter
+ (void)setAllowSelectImage:(BOOL)allowSelectImage {
    LZ_setAssociatedObject(self, _cmd, @(allowSelectImage));
}

+ (void)setAllowSelectVideo:(BOOL)allowSelectVideo {
    LZ_setAssociatedObject(self, _cmd, @(allowSelectVideo));
}

// MARK: - Getter
+ (BOOL)allowSelectImage {
    
    NSNumber *number = LZ_getAssociatedObject(self, @selector(setAllowSelectImage:));
    return number ? [number boolValue] : YES;
}

+ (BOOL)allowSelectVideo {
    return [LZ_getAssociatedObject(self, @selector(setAllowSelectVideo:)) boolValue];
}

// MARK: - Public
+ (void)showPhotoLibraryWithSender:(UIViewController *)sender
                    maxSelectCount:(NSUInteger)maxSelectCount
                     selectedAsset:(NSMutableArray<PHAsset *> * _Nullable)selectedAsset completionCallback:(nonnull void (^)(NSArray<UIImage *> * _Nullable, NSArray<PHAsset *> * _Nonnull))handler {
    
    ZLPhotoConfiguration *configuration = [self photoConfiguration];
    configuration.maxSelectCount = maxSelectCount;
    ZLPhotoPicker *photoPicker = [[ZLPhotoPicker alloc] initWithSelectedAssets:selectedAsset];
    photoPicker.selectImageBlock = ^(NSArray<ZLResultModel *> * _Nonnull results, BOOL isOriginal) {
        if (handler) {
            
            NSMutableArray *images = [NSMutableArray arrayWithCapacity:results.count];
            NSMutableArray *assets = [NSMutableArray arrayWithCapacity:results.count];
            for (ZLResultModel *result in results) {
                
                [images addObject:result.image];
                [assets addObject:result.asset];
            }
            handler(images, assets);
        }
    };
    photoPicker.selectImageRequestErrorBlock = ^(NSArray<PHAsset *> * _Nonnull assets, NSArray<NSNumber *> * _Nonnull indexs) {
        LZLog(@"图片解析出错的索引为: %@, 对应assets为: %@", indexs, assets);
    };
    [photoPicker showPhotoLibraryWithSender:sender];
}

+ (void)previewWithSender:(UIViewController *)sender
                   photos:(NSArray<UIImage *> *)photos
                   assets:(NSArray<PHAsset *> *)assets
                    index:(NSInteger)index
       completionCallback:(nonnull void (^)(NSArray<UIImage *> * _Nullable, NSArray<PHAsset *> * _Nonnull))handler {
    
    [self photoConfiguration];
    ZLPhotoPicker *photoPicker = [[ZLPhotoPicker alloc] initWithSelectedAssets:assets];
    photoPicker.selectImageBlock = ^(NSArray<ZLResultModel *> * _Nonnull results, BOOL isOriginal) {
        if (handler) {
            
            NSMutableArray *images = [NSMutableArray arrayWithCapacity:results.count];
            NSMutableArray *assets = [NSMutableArray arrayWithCapacity:results.count];
            for (ZLResultModel *result in results) {
                
                [images addObject:result.image];
                [assets addObject:result.asset];
            }
            handler(images, assets);
        }
    };
    photoPicker.selectImageRequestErrorBlock = ^(NSArray<PHAsset *> * _Nonnull assets, NSArray<NSNumber *> * _Nonnull indexs) {
        LZLog(@"图片解析出错的索引为: %@, 对应assets为: %@", indexs, assets);
    };
    [photoPicker previewAssetsWithSender:sender assets:assets index:index isOriginal:YES showBottomViewAndSelectBtn:YES];
}

+ (void)previewWithSender:(UIViewController *)sender
                   photos:(nonnull NSArray *)photos
                    index:(NSInteger)index {
    
    NSInteger count = photos.count;
    NSMutableArray *arrNetImages = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        
        NSObject *image = photos[i] ;
        if ([image isKindOfClass:[UIImage class]]) {
            [arrNetImages addObject:image];
        } else if ([image isKindOfClass:[NSURL class]]) {
            [arrNetImages addObject:image];
        } else if ([image isKindOfClass:[NSString class]]) {
            [arrNetImages addObject:[NSURL URLWithString:(NSString *)image]];
        } else {
            continue;
        }
    }
    if (0 == arrNetImages.count) {
        return;
    }
    
    ZLImagePreviewController *vc = [[ZLImagePreviewController alloc] initWithDatas:arrNetImages index:index showSelectBtn:NO showBottomView:NO urlType:^enum ZLURLType(NSURL * _Nonnull url) {
        return ZLURLTypeImage;
    } urlImageLoader:^(NSURL * _Nonnull url, UIImageView * _Nonnull img, void (^ _Nonnull progress)(CGFloat), void (^ _Nonnull loadFinish)(void)) {
        [img sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            loadFinish();
        }];
    }];
    NSArray *actions = PhotoBrowserAppearanceConfig().customActions;
    if (actions && actions.count) {
        vc.longPressBlock = ^(ZLImagePreviewController * _Nullable vc, UIImage * _Nullable image, NSInteger index) {
            
            PhotoBrowserAppearanceConfig().previewImg = image;
            PhotoBrowserAppearanceConfig().previewImgURL = nil;
            PhotoBrowserAppearanceConfig().previewImgIndexPath = [NSIndexPath indexPathWithIndex:index];
            
            NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:actions.count];
            for (UIAlertAction *action in PhotoBrowserAppearanceConfig().customActions) {
                [arrM addObject:[action copy]];
            }
            LZQuickUnit.sheet(vc, nil, nil, [arrM copy]);
        };
    }
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [sender showDetailViewController:vc sender:nil];
}

+ (void)configThemeColor:(UIColor *)themeColor {
    configThemeColor(themeColor);
}

// MARK: - Private
+ (ZLPhotoConfiguration *)photoConfiguration {
    
    ZLPhotoUIConfiguration *uiConfiguration = [ZLPhotoUIConfiguration default];
    uiConfiguration.showSelectedMask = YES;
    uiConfiguration.selectedMaskColor = [UIColor colorWithWhite:0 alpha:0.6];
    uiConfiguration.sortAscending = NO;
    uiConfiguration.cellCornerRadio = 5.0;
    uiConfiguration.showCaptureImageOnTakePhotoBtn = NO;
    // 颜色，状态栏样式
    uiConfiguration.indexLabelBgColor = configThemeColor(nil);
    uiConfiguration.bottomToolViewBtnNormalTitleColor = LZWhiteColor;
    uiConfiguration.bottomToolViewBtnNormalBgColor = configThemeColor(nil);
    uiConfiguration.bottomToolViewBtnDisableBgColor = [UIColor colorWithHexString:@"#EEEEEE"];
    uiConfiguration.statusBarStyle = UIStatusBarStyleDefault;
    uiConfiguration.showIndexOnSelectBtn = YES;
    
    ZLPhotoConfiguration *configuration = [ZLPhotoConfiguration default];
    configuration.allowMixSelect = NO;
    configuration.allowSelectImage = self.allowSelectImage;
    configuration.allowSelectVideo = self.allowSelectVideo;
    configuration.allowSelectGif = NO;
    configuration.allowSelectLivePhoto = YES;
    configuration.allowEditImage = YES;
    configuration.allowEditVideo = NO;
    configuration.allowSlideSelect = YES;
    configuration.allowDragSelect = YES;
    configuration.allowTakePhotoInLibrary = YES;
    configuration.canSelectAsset = ^BOOL (PHAsset * _Nonnull results) {
        LZLog(@"取消选择图片");
        return YES;
    };

    return configuration;
}

@end
