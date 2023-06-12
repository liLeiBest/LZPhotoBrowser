//
//  LZPhotoListBrowseView.m
//  LZPhotoBrowser
//
//  Created by Dear.Q on 2020/3/30.
//

#import "LZPhotoListBrowseView.h"
#import "LZPhotoBrowserManager.h"
#import <SDWebImage/SDWebImage.h>

/// 默认 9 宫格
static NSUInteger LZDefaultPhotoImageViewCount = 9;
/// 宫格 Tag
static NSInteger LZPhotoImageViewBaseTag = 1000;
@interface LZPhotoListBrowseView()

/** 图片数据源 */
@property (nonatomic, strong) NSMutableArray<id<LZPhotoListBrowseModelDelegate>> *photoDataSource;
/** Frame 数据源 */
@property (nonatomic, strong) NSMutableArray *frameDataSource;

@end
@implementation LZPhotoListBrowseView

// MARK: - Lazy Loading
- (NSMutableArray *)photoDataSource {
    if (nil == _photoDataSource) {
        _photoDataSource = [NSMutableArray array];
    }
    return _photoDataSource;
}

- (NSMutableArray *)frameDataSource {
    if (nil == _frameDataSource) {
        _frameDataSource = [NSMutableArray array];
    }
    return _frameDataSource;
}

// MARK: - Initialization
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
    }
    return self;
}

// MARK: - Public
- (void)setConfig:(LZPhotoListBrowseViewConfigModel *)config {
    _config = config;
    
    [self updateImageViews];
}

- (void)updatePhotoDataSource:(NSArray<id<LZPhotoListBrowseModelDelegate>> *)photoDataSource
              frameDataSource:(NSArray *)frameDataSource {
    for (UIImageView *imgView in self.subviews) {
        
        [imgView sd_cancelCurrentImageLoad];
        imgView.image = nil;
        imgView.frame = CGRectZero;
    }
    if (self.photoDataSource.count) {
        [self.photoDataSource removeAllObjects];
    }
    [self.photoDataSource addObjectsFromArray:photoDataSource];
    if (self.frameDataSource.count) {
        [self.frameDataSource removeAllObjects];
    }
    [self.frameDataSource addObjectsFromArray:frameDataSource];
    [self parsePhotosDataSource:photoDataSource];
}

// MARK: - UI Action
- (void)imageViewDidTap:(UITapGestureRecognizer *)tapGes {
    
    NSInteger index = tapGes.view.tag - LZPhotoImageViewBaseTag;
    index = index < self.config.maxShowCount ? index : 0;
    if (index < self.photoDataSource.count) {
        
        id<LZPhotoListBrowseModelDelegate> photoModel = [self.photoDataSource objectAtIndex:index];
        if ([photoModel respondsToSelector:@selector(extend)] && photoModel.extend) {
            if (self.config.videoPlayDidClick) {
                self.config.videoPlayDidClick(photoModel.extend);
            }
        } else {
            
            NSMutableArray *imgURLDataSource = [NSMutableArray arrayWithCapacity:self.photoDataSource.count];
            for (NSInteger index = 0; index < self.photoDataSource.count; index++) {
                
                id<LZPhotoListBrowseModelDelegate> photoModel = [self.photoDataSource objectAtIndex:index];
                NSURL *photoURL = nil;
                if ([photoModel respondsToSelector:@selector(photoURL)]) {
                    photoURL = photoModel.photoURL;
                }
                if (nil != photoURL) {
                    [imgURLDataSource addObject:photoURL];
                }
            }
            id sender = self.config.sender ?: self.viewController;
            [LZPhotoBrowserManager previewWithSender:sender photos:[imgURLDataSource copy] index:index];
        }
    }
}

// MARK: - Private
- (void)setupUI {
    
    self.userInteractionEnabled = YES;
    [self configImageViews:LZDefaultPhotoImageViewCount];
}

- (void)updateImageViews {
    
    NSUInteger count = self.config.maxShowCount >= self.config.maxCount ? self.config.maxCount : self.config.maxShowCount;
    if (count > self.subviews.count) {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [self configImageViews:count];
    }
}

- (void)configImageViews:(NSUInteger)count {
    for (NSInteger index = 0; index < count; index++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.userInteractionEnabled = YES;
        imageView.layer.cornerRadius = 8.0f;
        imageView.layer.masksToBounds = YES;
        imageView.tag = LZPhotoImageViewBaseTag + index;
        UITapGestureRecognizer *tap =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap:)];
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
        UIImageView *playIcon = [[UIImageView alloc] initWithFrame:imageView.bounds];
        playIcon.image = [self image:@"video_play_icon" inBundle:LZPhotoBrowserBundle];
        playIcon.backgroundColor = [UIColor clearColor];
        playIcon.contentMode = UIViewContentModeScaleAspectFit;
        [imageView addSubview:playIcon];
        if (index == count - 1) {
            
            UILabel *addLabel = [self surplusLabel];
            [imageView addSubview:addLabel];
        }
    }
}

- (void)parsePhotosDataSource:(NSArray<id<LZPhotoListBrowseModelDelegate>> *)dataSource {
    
    BOOL greaterThanMaxCount = dataSource.count > self.config.maxShowCount;
    NSUInteger count = dataSource.count;
    for (NSInteger index = 0; index < count; index++) {
        
        id<LZPhotoListBrowseModelDelegate> photoModel = [dataSource objectAtIndex:index];
        if ([photoModel conformsToProtocol:@protocol(LZPhotoListBrowseModelDelegate)]) {
            
            NSURL *photoURL = nil;
            if ([photoModel respondsToSelector:@selector(photoURL)]) {
                photoURL = photoModel.photoURL;
            }
            if (index < self.config.maxShowCount) {
                // 设置图片
                UIImageView *imgView = self.subviews[index];
                NSURL *thumbnailPhotoURL = nil;
                if ([photoModel respondsToSelector:@selector(thumbnailPhotoURL)]) {
                    thumbnailPhotoURL = photoModel.thumbnailPhotoURL;
                }
                thumbnailPhotoURL = thumbnailPhotoURL ?: photoURL;
                UIImage *placeholderImg = nil;
                if ([photoModel respondsToSelector:@selector(placeholderImg)]) {
                    placeholderImg = photoModel.placeholderImg;
                }
                placeholderImg = placeholderImg ?: self.config.appearanceConfig.placeholderImg;
                [imgView sd_setImageWithURL:thumbnailPhotoURL placeholderImage:placeholderImg];
                // 设置Frame
                imgView.frame = [self.frameDataSource[index] CGRectValue];
                for (UIView *subView in imgView.subviews) {
                    if ([subView isKindOfClass:[UIImageView class]]) {
                        if ([photoModel respondsToSelector:@selector(extend)] && photoModel.extend) {
                            
                            subView.hidden = NO;
                            subView.frame = imgView.bounds;
                            subView.height = imgView.height * 0.45;
                            subView.centerY = imgView.height * 0.5;
                        } else {
                            
                            subView.hidden = YES;
                            subView.frame = CGRectZero;
                        }
                    }
                }
            }
        }
    }
    if (greaterThanMaxCount) {
        
        UIImageView *imgView = [self.subviews lastObject];
        if (self.subviews.count > self.config.maxShowCount) {
            imgView = [self.subviews objectAtIndex:self.config.maxShowCount - 1];
        }
        for (UIView *subView in imgView.subviews) {
            if ([subView isKindOfClass:[UILabel class]]) {
                
                UILabel *addLabel = (UILabel *)subView;
                addLabel.text = [NSString stringWithFormat:@"+%lu", dataSource.count - self.config.maxShowCount];
                addLabel.frame = imgView.bounds;
            }
        }
    }
}

- (UILabel *)surplusLabel {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.alpha = 0.6;
    label.backgroundColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:20.0f];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = LZWhiteColor;
    return label;
}

@end
