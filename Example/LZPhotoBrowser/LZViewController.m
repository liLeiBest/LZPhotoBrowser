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
    
}

// MARK: - UI Action
- (IBAction)mutiPhotoesSelectDidTouch:(id)sender {
    
    LZPhotoListPickerViewController *ctr = [LZPhotoListPickerViewController instance];
    ctr.maxCount = 3;
    [self.navigationController pushViewController:ctr animated:YES];
}

- (IBAction)singlePhotoSelectDidTouch:(id)sender {
    
    [LZPhotoBrowserManager showPhotoLibraryWithSender:self maxSelectCount:1 selectCompletionHandler:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets) {
        NSLog(@"选择的图片：%@", images);
    }];
}

- (IBAction)photoesBrowseDidTouch:(id)sender {
    
    NSArray *photos = @[
    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1596628910178&di=2968b3dde42f4de93b18c6090a34f579&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D2857883419%2C1187496708%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D763",
    @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1606318581,1963634275&fm=26&gp=0.jpg",
    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1596629071833&di=44ebc6ecd236d10a0bacdaf62699346c&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201506%2F05%2F20150605194427_mEXU2.jpeg",
    @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3632840947,546420089&fm=26&gp=0.jpg"
    ];
    NSMutableArray *arrM = [NSMutableArray arrayWithArray:photos];
    for (NSInteger i = 1; i < 6; i++) {
        
        NSString *imgName = [NSString stringWithFormat:@"%d", (int)i];
        NSString *imgPath = [[NSBundle mainBundle] pathForResource:imgName ofType:@"jpg"];
        UIImage *img = [UIImage imageWithContentsOfFile:imgPath];
        [arrM addObject:img];
    }
    [LZPhotoBrowserManager previewWithSender:self photos:arrM index:0];
}

@end
