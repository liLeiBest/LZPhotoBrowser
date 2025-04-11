//
//  LZViewController.m
//  LZPhotoBrower
//
//  Created by lilei_hapy@163.com on 06/07/2017.
//  Copyright (c) 2017 lilei_hapy@163.com. All rights reserved.
//

#import "LZViewController.h"

@interface LZViewController ()

@end

@implementation LZViewController

// MARK: - Initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

// MARK: - UI Action
- (IBAction)mutiPhotoesSelectDidTouch:(id)sender {
    
    LZPhotoListPickerViewController *ctr = [LZPhotoListPickerViewController instance];
    ctr.insets = UIEdgeInsetsMake(0, 20, 0, 20);
    ctr.selectedList = @[[NSURL URLWithString:@"http://gips3.baidu.com/it/u=3557221034,1819987898&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=960"], [NSURL URLWithString:@"http://gips1.baidu.com/it/u=1746086795,2510875842&fm=3028&app=3028&f=JPEG&fmt=auto?w=1024&h=1024"], [NSURL URLWithString:@"http://gips2.baidu.com/it/u=3944689179,983354166&fm=3028&app=3028&f=JPEG&fmt=auto?w=1024&h=1024"], [NSURL URLWithString:@"http://gips0.baidu.com/it/u=2298867753,3464105574&fm=3028&app=3028&f=JPEG&fmt=auto?w=960&h=1280"], [NSURL URLWithString:@"http://gips2.baidu.com/it/u=295419831,2920259701&fm=3028&app=3028&f=JPEG&fmt=auto?w=720&h=1280"], [NSURL URLWithString:@"https://gips0.baidu.com/it/u=2946692232,559515331&fm=3028&app=3028&f=JPEG&fmt=auto&q=100&size=f960_1280"]];
    ctr.selectPhotoListDidChangeCallback = ^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets, CGFloat totalHeight) {
        NSLog(@"选择的图片:%@\n%@", images, assets);
    };
    [self.navigationController pushViewController:ctr animated:YES];
}

- (IBAction)singlePhotoSelectDidTouch:(id)sender {
    
    [LZPhotoBrowserManager showPhotoLibraryWithSender:self maxSelectCount:1 selectedAsset:nil completionCallback:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets) {
        NSLog(@"选择的图片：%@", images);
    }];
}

- (IBAction)photoesBrowseDidTouch:(id)sender {
    
    NSArray *photos = @[
    @"http://gips3.baidu.com/it/u=3557221034,1819987898&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=960",
    @"http://gips1.baidu.com/it/u=1746086795,2510875842&fm=3028&app=3028&f=JPEG&fmt=auto?w=1024&h=1024",
    @"http://gips2.baidu.com/it/u=3944689179,983354166&fm=3028&app=3028&f=JPEG&fmt=auto?w=1024&h=1024",
    @"http://gips0.baidu.com/it/u=2298867753,3464105574&fm=3028&app=3028&f=JPEG&fmt=auto?w=960&h=1280",
    @"http://gips2.baidu.com/it/u=295419831,2920259701&fm=3028&app=3028&f=JPEG&fmt=auto?w=720&h=1280",
    @"https://gips0.baidu.com/it/u=2946692232,559515331&fm=3028&app=3028&f=JPEG&fmt=auto&q=100&size=f960_1280"
    ];
    NSMutableArray *arrM = [NSMutableArray arrayWithArray:photos];
    for (NSInteger i = 1; i < 6; i++) {
        
        NSString *imgName = [NSString stringWithFormat:@"%d", (int)i];
        NSString *imgPath = [[NSBundle mainBundle] pathForResource:imgName ofType:@"jpg"];
        UIImage *img = [UIImage imageWithContentsOfFile:imgPath];
        [arrM addObject:img];
    }
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@--%@", PhotoBrowserAppearanceConfig().previewImgIndexPath, PhotoBrowserAppearanceConfig().previewImg);
    }];
    UIAlertAction *share = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    PhotoBrowserAppearanceConfig().placeholderImgSet([UIImage imageNamed:@"placehoder"]).watermarkSet(YES).watermarkTextSet(@"娃哈哈").customActionsSet(@[cancel, save, share]);
    [LZPhotoBrowserManager previewWithSender:self photos:arrM index:0];
}

// MARK: - Private
- (void)setupUI {
    
    
}

@end
