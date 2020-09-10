//
//  ZLShowBigImgViewController+LZAlertController.m
//  LZPhotoBrowser
//
//  Created by Dear.Q on 2020/9/10.
//

#import "ZLShowBigImgViewController+LZAlertController.h"
#import "LZPhotoBrowserAppearanceModel.h"
#import <ZLPhotoBrowser/ZLBigImageCell.h>

@implementation ZLShowBigImgViewController (LZAlertController)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originSelector = NSSelectorFromString(@"showDownloadAlert");
        SEL swizzleSelector = @selector(lz_showActionAlert);
        LZ_exchangeInstanceMethod(self, originSelector, swizzleSelector);
    });
}

// MARK: - Private
- (void)lz_showActionAlert {
    if (PhotoBrowserAppearanceConfig().customActions
        && PhotoBrowserAppearanceConfig().customActions.count) {
        for (UICollectionView *collection in self.view.subviews) {
            if ([collection isKindOfClass:[UICollectionView class]]) {
                
                NSArray *visibleCells = collection.visibleCells;
                if (visibleCells && visibleCells.count) {
                    
                    ZLBigImageCell *cell = visibleCells[0];
                    UIImage *previewImg = cell.previewView.image;
                    NSIndexPath *indexPath = [collection indexPathForCell:cell];
                    PhotoBrowserAppearanceConfig().previewImg = previewImg;
                    PhotoBrowserAppearanceConfig().previewImgIndexPath = indexPath;
                    break;
                }
            }
        }
        LZQuickUnit.sheet(self, nil, nil, PhotoBrowserAppearanceConfig().customActions);
    } else {
        [self lz_showActionAlert];
    }
}

@end
