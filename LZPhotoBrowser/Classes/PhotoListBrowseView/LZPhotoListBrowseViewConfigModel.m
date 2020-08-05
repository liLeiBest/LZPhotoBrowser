//
//  LZPhotoListBrowseViewConfigModel.m
//  LZPhotoBrowser
//
//  Created by Dear.Q on 2020/3/31.
//

#import "LZPhotoListBrowseViewConfigModel.h"

@interface LZPhotoListBrowseViewConfigModel ()

@property (nonatomic, strong) id sender;
@property (nonatomic, strong) LZPhotoBrowserAppearanceModel *appearanceConfig;
@property (nonatomic, assign) NSUInteger maxShowCount;
@property (nonatomic, assign) NSUInteger maxCount;
@property (nonatomic, assign) CGFloat maxWidth;
@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, assign) CGFloat spacing;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSArray *frameDataSource;

@end
@implementation LZPhotoListBrowseViewConfigModel

// MARK: - Initialization
- (instancetype)init {
    if (self = [super init]) {
        
        self.maxShowCount = 4;
        self.maxCount = 4;
        self.maxWidth = [UIScreen mainScreen].bounds.size.width;
        self.insets = UIEdgeInsetsZero;
        self.spacing = 6.0;
        self.height = 0;
    }
    return self;
}

// MARK: - Public
+ (LZPhotoListBrowseViewConfigModel * _Nonnull (^)(void))defaultConfig {
    return ^id {
        return [[self alloc] init];
    };
}

- (LZPhotoListBrowseViewConfigModel * _Nonnull (^)(id _Nonnull))senderSet {
    return ^id (id sender) {
        self.sender = sender;
        return self;
    };
}

- (LZPhotoListBrowseViewConfigModel * _Nonnull (^)(LZPhotoBrowserAppearanceModel * _Nonnull))appearanceConfigSet {
    return ^id (LZPhotoBrowserAppearanceModel *appearanceConfig) {
        self.appearanceConfig = appearanceConfig;
        return self;
    };
}

- (LZPhotoListBrowseViewConfigModel * _Nonnull (^)(NSUInteger))maxShowCountSet {
    return ^id (NSUInteger maxShowCount) {
        self.maxShowCount = maxShowCount;
        return self;
    };
}

- (LZPhotoListBrowseViewConfigModel * _Nonnull (^)(NSUInteger))maxCountSet {
    return ^id (NSUInteger maxCount) {
        self.maxCount = maxCount;
        return self;
    };
}

- (LZPhotoListBrowseViewConfigModel * _Nonnull (^)(CGFloat))maxWidthSet {
    return ^id (CGFloat maxWidth){
        self.maxWidth = maxWidth;
        return self;
    };
}

- (LZPhotoListBrowseViewConfigModel * _Nonnull (^)(UIEdgeInsets))insetsSet {
    return ^id (UIEdgeInsets insets) {
        self.insets = insets;
        return self;
    };
}

- (LZPhotoListBrowseViewConfigModel * _Nonnull (^)(CGFloat))spacingSet {
    return ^id (CGFloat spacing) {
        self.spacing = spacing;
        return self;
    };
}

- (LZPhotoListBrowseViewConfigModel * _Nonnull (^)(void))calcu {
    return ^id  {
      
        NSMutableArray *frameDataSource = [NSMutableArray arrayWithCapacity:self.maxShowCount];
        NSUInteger count = self.maxShowCount >= self.maxCount ? self.maxCount : self.maxShowCount;
        self.height = [self calcTotalHeightWithPhotosCount:count maxWidth:self.maxWidth frameDataSource:&frameDataSource];
        self.frameDataSource = [frameDataSource copy];
        return self;
    };
}

// MARK: - Private
- (CGFloat)calcTotalHeightWithPhotosCount:(NSUInteger)count
                                 maxWidth:(CGFloat)maxWidth
                          frameDataSource:(NSMutableArray **)frameDataSource {
    
    NSMutableArray *frameArrM = *frameDataSource;
    CGFloat x = 0, y = 0, w = 0, h = 0;
    CGFloat top = self.insets.top, left = self.insets.left, bottom = self.insets.bottom, right = self.insets.right;
    CGFloat padding = self.spacing;
    CGFloat totalHeight = 0;
    switch (count) {
        case 0: {
            totalHeight = 0;
        }
            break;
        case 1: {
            
            x = left;
            y = top;
            w = maxWidth - left - right;
            h = maxWidth * 9.0 / 16;
            CGRect frame = CGRectMake(x, y, w, h);
            [frameArrM addObject:[NSValue valueWithCGRect:frame]];
            totalHeight = CGRectGetMaxY(frame) + bottom;
        }
            break;
        default: {
            
            NSUInteger column;
            if (4 >= count) {
                column = 2;
            } else {
                column = 3;
            }
            
            CGFloat row = count / column + 1;
            if (!(count % column)) {
                row = count / column;
            }
//            row = row > 3 ? 3 : row;
            
            w = (maxWidth - left - right - (column -1) * padding) / column;
            h = w * 3.0 / 4;
            for (CGFloat i = 0; i < row; i++) {
                for (CGFloat j = 0; j < column; j++) {
                    
                    x = j * (w + padding) + left;
                    y = i * (h + padding) + top;
                    
                    int index = i * column + j;
                    if (index < count) {
                        
                        CGRect frame = CGRectMake(x, y, w, h);
                        [frameArrM addObject:[NSValue valueWithCGRect:frame]];
                    }
                }
            }
            totalHeight = row * h + (row - 1) * padding + top + bottom;
        }
            break;
    }
    return totalHeight;
}

@end

LZPhotoListBrowseViewConfigModel * defaultConfig(void) {
    return [[LZPhotoListBrowseViewConfigModel alloc] init];;
}
