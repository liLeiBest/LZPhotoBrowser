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
    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1596628910181&di=4dada1ee6e54f0373020e98c77d3972d&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D3571592872%2C3353494284%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1200%26h%3D1290",
    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1596628910181&di=a65490ad3a0fb8b9c5345c34ee5fa0bb&imgtype=0&src=http%3A%2F%2Ft7.baidu.com%2Fit%2Fu%3D3616242789%2C1098670747%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D900%26h%3D1350",
    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1596628910178&di=2968b3dde42f4de93b18c6090a34f579&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D2857883419%2C1187496708%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D763",
    @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1606318581,1963634275&fm=26&gp=0.jpg",
    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1596629071833&di=44ebc6ecd236d10a0bacdaf62699346c&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201506%2F05%2F20150605194427_mEXU2.jpeg",
    @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3632840947,546420089&fm=26&gp=0.jpg",
    @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3948370908,3263923036&fm=26&gp=0.jpg",
    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1596629483191&di=db493783c6049cabd181f21682380157&imgtype=0&src=http%3A%2F%2Fs7.rr.itc.cn%2Fg%2FwapChange%2F20156_3_15%2Fa69am33494090671477.JPEG",
    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1596629483190&di=bafe69b90638b98bb09286df53783567&imgtype=0&src=http%3A%2F%2Fn1.itc.cn%2Fimg8%2Fwb%2Fsmccloud%2Ffetch%2F2015%2F06%2F09%2F130181629280314394.JPEG",
    @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2154892101,3660422198&fm=26&gp=0.jpg",
    @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3633842791,3677476825&fm=26&gp=0.jpg",
    ];
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:photos.count];
    for (NSString *urlString in photos) {
        
        LZPhotoListBrowseModel *model = [[LZPhotoListBrowseModel alloc] init];
        model.photoURL = [NSURL URLWithString:urlString];
        model.thumbnailPhotoURL = [NSURL URLWithString:urlString];
        [arrM addObject:model];
    }
    CGFloat width = LZDeviceInfo.screen_width();
    LZPhotoBrowserAppearanceModel *appearanceConfig = PhotoBrowserAppearanceConfig().placeholderImgSet([UIImage imageNamed:@"placehoder"]).watermarkSet(YES).watermarkTextSet(@"娃哈哈");
    LZPhotoListBrowseViewConfigModel *config = defaultConfig().maxShowCountSet(4).maxCountSet(photos.count).maxWidthSet(width).calcu().appearanceConfigSet(appearanceConfig);
    self.browseView.config = config;
    self.browseViewHeight.constant = config.height;
    [self.browseView updatePhotoDataSource:arrM frameDataSource:config.frameDataSource];
    
    self.browseView.backgroundColor = [UIColor systemPinkColor];
}

- (NSString *)imgPath:(NSString *)name {
    return [[NSBundle mainBundle] pathForResource:name ofType:@"jpg"];
}

@end
