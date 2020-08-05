//
//  LZPhotoAuthorization.m
//  LZPhotoBrower
//
//  Created by Dear.Q on 2019/4/12.
//

#import "LZPhotoAuthorization.h"
#import <Photos/PHPhotoLibrary.h>

@interface LZPhotoAuthorization()<PHPhotoLibraryChangeObserver>

@end

@implementation LZPhotoAuthorization

+ (void)authorization {
	
	PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
	switch (oldStatus) {
		case PHAuthorizationStatusNotDetermined: {
			[PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
				if (status == PHAuthorizationStatusDenied) {
					[self openSystemSetting];
				}
			}];
		}
			break;
		case PHAuthorizationStatusRestricted:
			LZAlert(@"提示", @"因系统原因，无法访问相册！");
			break;
		case PHAuthorizationStatusDenied:
			[self openSystemSetting];
			break;
		case PHAuthorizationStatusAuthorized:
			break;
	}
	
	[[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];;
}

// MARK: - Private
+ (void)openSystemSetting {
	
	NSString *appName = [[NSBundle mainBundle].infoDictionary objectForKey:(__bridge NSString *)kCFBundleNameKey];
	NSString *content = [NSString stringWithFormat:@"您未允许\"%@\"访问系统相册，请打开手机\"设置\"-\"%@\",进行设置", appName, appName];
	LZAlert2(@"提示", content, ^(UIAlertAction * _Nonnull action) {
		
		NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
		if (@available(iOS 10, *)) {
			[[UIApplication sharedApplication] openURL:settingURL options:@{} completionHandler:nil];
		} else {
			if ([[UIApplication sharedApplication] canOpenURL:settingURL]) {
				[[UIApplication sharedApplication] openURL:settingURL];
			}
		}
	}, nil);
}

// MARK: - Delegate
// MARK: <PHPhotoLibraryChangeObserver>
- (void)photoLibraryDidChange:(PHChange *)changeInfo {
	
//	// Photos may call this method on a background queue;
//	// switch to the main queue to update the UI.
//	dispatch_async(dispatch_get_main_queue(), ^{
//		// Check for changes to the displayed album itself
//		// (its existence and metadata, not its member assets).
//		PHObjectChangeDetails *albumChanges = [changeInfo changeDetailsForObject:self.displayedAlbum];
//		if (albumChanges) {
//			// Fetch the new album and update the UI accordingly.
//			self.displayedAlbum = [albumChanges objectAfterChanges];
//			self.navigationController.navigationItem.title = self.displayedAlbum.localizedTitle;
//		}
//		
//		// Check for changes to the list of assets (insertions, deletions, moves, or updates).
//		PHFetchResultChangeDetails *collectionChanges = [changeInfo changeDetailsForFetchResult:self.albumContents];
//		if (collectionChanges) {
//			// Get the new fetch result for future change tracking.
//			self.albumContents = collectionChanges.fetchResultAfterChanges;
//			
//			if (collectionChanges.hasIncrementalChanges)  {
//				// Tell the collection view to animate insertions/deletions/moves
//				// and to refresh any cells that have changed content.
//				[self.collectionView performBatchUpdates:^{
//					NSIndexSet *removed = collectionChanges.removedIndexes;
//					if (removed.count) {
//						[self.collectionView deleteItemsAtIndexPaths:[self indexPathsFromIndexSet:removed]];
//					}
//					NSIndexSet *inserted = collectionChanges.insertedIndexes;
//					if (inserted.count) {
//						[self.collectionView insertItemsAtIndexPaths:[self indexPathsFromIndexSet:inserted]];
//					}
//					NSIndexSet *changed = collectionChanges.changedIndexes;
//					if (changed.count) {
//						[self.collectionView reloadItemsAtIndexPaths:[self indexPathsFromIndexSet:changed]];
//					}
//					if (collectionChanges.hasMoves) {
//						[collectionChanges enumerateMovesWithBlock:^(NSUInteger fromIndex, NSUInteger toIndex) {
//							NSIndexPath *fromIndexPath = [NSIndexPath indexPathForItem:fromIndex inSection:0];
//							NSIndexPath *toIndexPath = [NSIndexPath indexPathForItem:toIndex inSection:0];
//							[self.collectionView moveItemAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
//						}];
//					}
//				} completion:nil];
//			} else {
//				// Detailed change information is not available;
//				// repopulate the UI from the current fetch result.
//				[self.collectionView reloadData];
//			}
//		}
//	});
}

@end
