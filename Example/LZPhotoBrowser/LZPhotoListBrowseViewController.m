//
//  LZPhotoListBrowseViewController.m
//  LZPhotoBrowser_Example
//
//  Created by Dear.Q on 2020/8/6.
//  Copyright © 2020 Dear.Q. All rights reserved.
//

#import "LZPhotoListBrowseViewController.h"
#import "LZPhotoListBrowseModel.h"

@interface LZPhotoListBrowseViewController ()

@property (nonatomic, weak) IBOutlet LZPhotoListBrowseView *browseView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *browseViewHeight;

@end

@implementation LZPhotoListBrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)dealloc {
    LZLog();
}

// MARK: - Private
- (void)setupUI {
    
    NSArray *photos = @[
        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1596628910178&di=2968b3dde42f4de93b18c6090a34f579&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D2857883419%2C1187496708%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D763",
        @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1606318581,1963634275&fm=26&gp=0.jpg",
        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1596629071833&di=44ebc6ecd236d10a0bacdaf62699346c&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201506%2F05%2F20150605194427_mEXU2.jpeg",
        @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3632840947,546420089&fm=26&gp=0.jpg"
    ];
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:photos.count];
    for (NSString *urlString in photos) {
        
        LZPhotoListBrowseModel *model = [[LZPhotoListBrowseModel alloc] init];
        model.photoURL = [NSURL URLWithString:urlString];
        model.thumbnailPhotoURL = [NSURL URLWithString:urlString];
        [arrM addObject:model];
    }
    CGFloat width = LZDeviceInfo.screen_width();
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    PhotoBrowserAppearanceConfig().placeholderImgSet([UIImage imageNamed:@"placehoder"]).watermarkSet(YES).watermarkTextSet(@"娃哈哈").customActionsSet(@[cancel, save, delete]);
    LZPhotoListBrowseViewConfigModel *config = defaultConfig().maxShowCountSet(4).maxCountSet(photos.count).maxWidthSet(width).calcu().appearanceConfigSet(PhotoBrowserAppearanceConfig());
    self.browseView.config = config;
    self.browseViewHeight.constant = config.height;
    [self.browseView updatePhotoDataSource:arrM frameDataSource:config.frameDataSource];
    
    self.browseView.backgroundColor = [UIColor systemPinkColor];
}

- (NSString *)imgPath:(NSString *)name {
    return [[NSBundle mainBundle] pathForResource:name ofType:@"jpg"];
}

@end
