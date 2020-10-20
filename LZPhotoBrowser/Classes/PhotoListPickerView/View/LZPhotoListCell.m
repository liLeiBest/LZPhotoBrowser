//
//  LZPhotoListCell.m
//  LZPhotoBrowser
//
//  Created by Dear.Q on 2020/2/27.
//

#import "LZPhotoListCell.h"
#import <SDWebImage/SDWebImage.h>

@interface LZPhotoListCell ()

@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@property (nonatomic, weak) IBOutlet UIButton *deleteBtn;

@end
@implementation LZPhotoListCell

// MARK: - Initialization
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}

// MARK: - Public
- (void)setPhotoImg:(NSObject *)photoImg {
    _photoImg = photoImg;
    
    if ([photoImg isKindOfClass:[NSNull class]]) {
        
        self.deleteBtn.hidden = YES;
        self.imgView.image = [self image:@"photo_add_icon" inBundle:LZPhotoBrowserBundle];
    } else {
        if ([photoImg isKindOfClass:[NSString class]]) {
            
            self.deleteBtn.hidden = NO;
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:(NSString *)photoImg] placeholderImage:nil];
        } else if ([photoImg isKindOfClass:[NSURL class]]) {
            
            self.deleteBtn.hidden = NO;
            [self.imgView sd_setImageWithURL:(NSURL *)photoImg placeholderImage:nil];
        } else if ([photoImg isKindOfClass:[UIImage class]]) {
            
            self.deleteBtn.hidden = NO;
            self.imgView.image = (UIImage *)photoImg;
        }
    }
}

// MARK: - UI Action
- (IBAction)deleteDidTouch:(UIButton *)sender {
    
    if (self.deleteDidTouchCallback) {
        self.deleteDidTouchCallback(self);
    }
}

// MARK: - Private
- (void)setupUI {
    
    self.deleteBtn.backgroundColor = LZClearColor;
    [self.deleteBtn setImage:[self image:@"photo_delete_icon" inBundle:LZPhotoBrowserBundle]
                    forState:UIControlStateNormal];
}

@end
