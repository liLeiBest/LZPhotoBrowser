//
//  LZPhotoBrowserManager.m
//  LZPhotoBrowser
//
//  Created by Dear.Q on 2020/3/5.
//

#import "LZPhotoBrowserManager.h"
#import <ZLPhotoBrowser/ZLPhotoBrowser.h>

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

// MARK: - Public
+ (void)showPhotoLibraryWithSender:(UIViewController *)sender
                    maxSelectCount:(NSUInteger)maxSelectCount
                     selectedAsset:(NSMutableArray<PHAsset *> * _Nullable)selectedAsset completionCallback:(nonnull void (^)(NSArray<UIImage *> * _Nullable, NSArray<PHAsset *> * _Nonnull))handler {
    
    ZLPhotoActionSheet *actionSheet = self.photoActionSheet;
    actionSheet.configuration.maxSelectCount = maxSelectCount;
    actionSheet.arrSelectedAssets = selectedAsset;
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        if (handler) {
            handler(images, assets);
        }
    }];
    [actionSheet showPhotoLibraryWithSender:sender];
}

+ (void)previewWithSender:(UIViewController *)sender
                   photos:(NSArray<UIImage *> *)photos
                   assets:(NSArray<PHAsset *> *)assets
                    index:(NSInteger)index
       completionCallback:(nonnull void (^)(NSArray<UIImage *> * _Nullable, NSArray<PHAsset *> * _Nonnull))handler {
    
    ZLPhotoActionSheet *actionSheet = self.photoActionSheet;
    actionSheet.sender = sender;
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        if (handler) {
            handler(images, assets);
        }
    }];
    [actionSheet previewSelectedPhotos:photos
                                assets:assets
                                 index:index
                            isOriginal:YES];
}

+ (void)previewWithSender:(UIViewController *)sender
                   photos:(nonnull NSArray *)photos
                    index:(NSInteger)index {
    
    NSInteger count = photos.count;
    NSMutableArray *arrNetImages = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        
        NSObject *image = photos[i] ;
        if ([image isKindOfClass:[UIImage class]]) {
            [arrNetImages addObject:GetDictForPreviewPhoto((UIImage *)image, ZLPreviewPhotoTypeUIImage)];
        } else if ([image isKindOfClass:[NSURL class]]) {
            [arrNetImages addObject:GetDictForPreviewPhoto((NSURL *)image, ZLPreviewPhotoTypeURLImage)];
        } else if ([image isKindOfClass:[NSString class]]) {
            [arrNetImages addObject:GetDictForPreviewPhoto([NSURL URLWithString:(NSString *)image], ZLPreviewPhotoTypeURLImage)];
        } else {
            continue;
        }
    }
    if (0 == arrNetImages.count) {
        return;
    }
    
    ZLPhotoActionSheet *actionSheet = self.photoActionSheet;
    actionSheet.sender = sender;
    [actionSheet previewPhotos:arrNetImages index:index hideToolBar:YES complete:^(NSArray * _Nonnull photos) {
    }];
}

+ (void)configThemeColor:(UIColor *)themeColor {
    configThemeColor(themeColor);
}

// MARK: - Private
+ (ZLPhotoActionSheet *)photoActionSheet {
    
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    actionSheet.configuration.showSelectedMask = YES;
    actionSheet.configuration.selectedMaskColor = [UIColor colorWithWhite:0 alpha:0.6];
    actionSheet.configuration.sortAscending = NO;
    actionSheet.configuration.showSelectBtn = YES;
    actionSheet.configuration.allowSelectImage = YES;
    actionSheet.configuration.allowSelectVideo = NO;
    actionSheet.configuration.allowSelectGif = NO;
    actionSheet.configuration.allowSelectLivePhoto = NO;
    actionSheet.configuration.allowForceTouch = YES;
    actionSheet.configuration.allowEditImage = YES;
    actionSheet.configuration.hideClipRatiosToolBar = YES;
    actionSheet.configuration.allowEditVideo = NO;
    actionSheet.configuration.allowSlideSelect = YES;
    actionSheet.configuration.allowDragSelect = YES;
    actionSheet.configuration.allowTakePhotoInLibrary = YES;
    actionSheet.configuration.showCaptureImageOnTakePhotoBtn = NO;
    actionSheet.configuration.shouldAnialysisAsset = YES;
    //颜色，状态栏样式
    actionSheet.configuration.indexLabelBgColor = configThemeColor(nil);
    actionSheet.configuration.bottomBtnsNormalTitleColor = LZWhiteColor;
    actionSheet.configuration.bottomBtnsNormalBgColor = configThemeColor(nil);
    actionSheet.configuration.bottomBtnsDisableBgColor = [UIColor colorWithHexString:@"#EEEEEE"];
    actionSheet.configuration.statusBarStyle = UIStatusBarStyleDefault;
    actionSheet.selectImageRequestErrorBlock = ^(NSArray<PHAsset *> * _Nonnull errorAssets, NSArray<NSNumber *> * _Nonnull errorIndex) {
        LZLog(@"图片解析出错的索引为: %@, 对应assets为: %@", errorIndex, errorAssets);
    };
    actionSheet.cancleBlock = ^{
        LZLog(@"取消选择图片");
    };
    return actionSheet;
}

@end
