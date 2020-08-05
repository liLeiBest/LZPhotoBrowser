//
//  LZPhotoUtility.m
//  LZPhotoBrower
//
//  Created by Dear.Q on 2019/4/12.
//

#import "LZPhotoUtility.h"
#import <Photos/Photos.h>
#import <Photos/PHCollection.h>

@implementation LZPhotoUtility

+ (void)fetchPhtotoAlbums {
	
	PHFetchResult<PHAssetCollection *> *collectionList =
	[PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeMoment
											 subtype:PHAssetCollectionSubtypeAny
											 options:nil];
	[collectionList enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		
	}];
	
	PHFetchResult *smartAlbumsFetchResult1 = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:nil];
	[smartAlbumsFetchResult1 enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(PHAssetCollection * _Nonnull collection, NSUInteger idx, BOOL *stop) {
		
	}];
}

- (void)addNewAssetWithImage:(UIImage*)image toAlbum:(PHAssetCollection*)album {
	
	[[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
		
		PHAssetChangeRequest *createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
		PHObjectPlaceholder *assetPlaceholder = [createAssetRequest placeholderForCreatedAsset];
		PHAssetCollectionChangeRequest *albumChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:album];
		[albumChangeRequest addAssets:@[assetPlaceholder]];
	} completionHandler:^(BOOL success, NSError* error) {
		NSLog(@"Finished adding asset. %@", (success ? @"Success" : error));
	}];
}

- (void)toggleFavoriteForAsset:(PHAsset *)asset {
	
	[[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
		// Create a change request from the asset to be modified.
		PHAssetChangeRequest *request = [PHAssetChangeRequest changeRequestForAsset:asset];
		// Set a property of the request to change the asset itself.
		request.favorite = !asset.favorite;
		
	} completionHandler:^(BOOL success, NSError *error) {
		NSLog(@"Finished updating asset. %@", (success ? @"Success." : error));
	}];
}

@end


void LZAlert(NSString *title, NSString *content) {
	LZAlert1(title, content, nil);
}
void LZAlert1(NSString *title, NSString *content, void(^SureHandler)(UIAlertAction * _Nonnull action)) {
	LZAlert2(title, content, SureHandler, nil);
}
void LZAlert2(NSString *title, NSString *content, void(^ __nullable SureHandler)(UIAlertAction * _Nonnull action), void(^ __nullable CancleHandler)(UIAlertAction * _Nonnull action)) {
	
	UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
	[alertCtr addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:SureHandler]];
	[alertCtr addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:CancleHandler]];
	[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertCtr animated:YES completion:nil];
}
