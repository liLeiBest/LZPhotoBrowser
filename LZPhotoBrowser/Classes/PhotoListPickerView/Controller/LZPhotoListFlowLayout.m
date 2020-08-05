//
//  LZPhotoListFlowLayout.m
//  LZPhotoBrowser
//
//  Created by Dear.Q on 2020/2/27.
//

#import "LZPhotoListFlowLayout.h"

@implementation LZPhotoListFlowLayout

/// 初始状态
/// @param itemIndexPath  NSIndexPath
- (nullable UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    
    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attr.center = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMaxY(self.collectionView.bounds));
    attr.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), M_PI);
    return attr;
}

/// 终结状态
/// @param itemIndexPath  NSIndexPath
- (nullable UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    
    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attr.alpha = 0.0f;
    return attr;
}

@end
