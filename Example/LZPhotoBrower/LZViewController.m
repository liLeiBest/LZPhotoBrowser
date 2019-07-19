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

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
	[LZPhotoUtility fetchPhtotoAlbums];
}

@end
