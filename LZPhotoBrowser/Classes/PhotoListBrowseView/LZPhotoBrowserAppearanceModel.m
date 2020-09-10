//
//  LZPhotoBrowserAppearanceModel.m
//  LZPhotoBrowser
//
//  Created by Dear.Q on 2020/8/5.
//

#import "LZPhotoBrowserAppearanceModel.h"

@interface LZPhotoBrowserAppearanceModel ()

@property (nonatomic, strong) UIImage *placeholderImg;
@property (nonatomic, assign) BOOL watermark;
@property (nonatomic, strong) UIImage *watermarkImage;
@property (nonatomic, copy) NSString *watermarkText;
@property (nonatomic, strong) NSArray<UIAlertAction *> *customActions;

@end
@implementation LZPhotoBrowserAppearanceModel

// MARK: - Initialization
- (instancetype)init {
    if (self = [super init]) {
        self.watermark = NO;
    }
    return self;
}

// MARK: - Public
- (LZPhotoBrowserAppearanceModel * _Nonnull (^)(UIImage * _Nonnull))placeholderImgSet {
    return ^id (UIImage *placeholderImg) {
        self.placeholderImg = placeholderImg;
        return self;
    };
}

- (LZPhotoBrowserAppearanceModel * _Nonnull (^)(BOOL))watermarkSet {
    return ^id (BOOL watermark) {
        self.watermark = watermark;
        return self;
    };
}

- (LZPhotoBrowserAppearanceModel * _Nonnull (^)(UIImage * _Nonnull))watermarkImageSet {
    return ^id (UIImage *watermarkImage) {
        self.watermarkImage = watermarkImage;
        return self;
    };
}

- (LZPhotoBrowserAppearanceModel * _Nonnull (^)(NSString * _Nonnull))watermarkTextSet {
    return ^id (NSString *watermarkText) {
        self.watermarkText = watermarkText;
        return self;
    };
}

- (LZPhotoBrowserAppearanceModel * _Nonnull (^)(NSArray<UIAlertAction *> * _Nonnull))customActionsSet {
    return ^id (NSArray *customActions) {
        self.customActions = customActions;
        return self;
    };
}

// MARK: - Private
+ (instancetype)sharedPhotoBrowserAppearanceModel {
    
    static LZPhotoBrowserAppearanceModel *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[LZPhotoBrowserAppearanceModel alloc] init];
    });
    return _instance;
}

@end

LZPhotoBrowserAppearanceModel * PhotoBrowserAppearanceConfig(void) {
    return [LZPhotoBrowserAppearanceModel sharedPhotoBrowserAppearanceModel];
}
