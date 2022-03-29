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

/** Frame 数据源 */
@property (nonatomic, strong) NSMutableArray *frameDataSource;
/** 原始图数据源 */
@property (nonatomic, strong) NSMutableArray *orgImgDataSource;

@end
@implementation LZPhotoListBrowseView

// MARK: - Lazy Loading
- (NSMutableArray *)frameDataSource {
    if (nil == _frameDataSource) {
        _frameDataSource = [NSMutableArray array];
    }
    return _frameDataSource;
}

- (NSMutableArray *)orgImgDataSource {
    if (nil == _orgImgDataSource) {
        _orgImgDataSource = [NSMutableArray array];
    }
    return _orgImgDataSource;
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
    if (self.frameDataSource.count) {
        [self.frameDataSource removeAllObjects];
    }
    [self.frameDataSource addObjectsFromArray:frameDataSource];
    if (self.orgImgDataSource.count) {
        [self.orgImgDataSource removeAllObjects];
    }
    [self parsePhotosDataSource:photoDataSource];
}

// MARK: - UI Action
- (void)imageViewDidTap:(UITapGestureRecognizer *)tapGes {
    
    NSInteger index = tapGes.view.tag - LZPhotoImageViewBaseTag;
    index = index < self.config.maxShowCount ? index : 0;
    id sender = self.config.sender ?: self.viewController;
    [LZPhotoBrowserManager previewWithSender:sender photos:self.orgImgDataSource index:index];
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
        
        CGRect frame = CGRectZero;
        UIImageView *imgView = nil;
        id<LZPhotoListBrowseModelDelegate> photoModel = [dataSource objectAtIndex:index];
        if ([photoModel conformsToProtocol:@protocol(LZPhotoListBrowseModelDelegate)]) {
            
            NSURL *photoURL = photoModel.photoURL;
            [self.orgImgDataSource addObject:photoURL];
            if (index <  self.config.maxShowCount) {
                
                imgView = self.subviews[index];
                NSURL *thumbnailPhotoURL = photoModel.thumbnailPhotoURL;
                thumbnailPhotoURL = thumbnailPhotoURL ?: photoURL;
                UIImage *placeholderImg = photoModel.placeholderImg;
                placeholderImg = placeholderImg ?: self.config.appearanceConfig.placeholderImg;
                [imgView sd_setImageWithURL:thumbnailPhotoURL placeholderImage:placeholderImg];
                frame = [self.frameDataSource[index] CGRectValue];
            }
        }
        imgView.frame = frame;
    }
    if (greaterThanMaxCount) {
        
        UIImageView *imgView = [self.subviews lastObject];
        if (self.subviews.count > self.config.maxShowCount) {
            imgView = [self.subviews objectAtIndex:self.config.maxShowCount - 1];
        }
        UILabel *addLabel = [imgView.subviews lastObject];
        if (nil == addLabel) {
            
            addLabel = [self surplusLabel];
            [imgView addSubview:addLabel];
        }
        addLabel.text = [NSString stringWithFormat:@"+%lu", dataSource.count - self.config.maxShowCount];
        addLabel.frame = imgView.bounds;
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
