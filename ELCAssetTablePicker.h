//
//  AssetTablePicker.h
//
//  Created by Matt Tuzzolo on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol ELCAssestTableDataSource <NSObject>

-(void)selectedImage:(NSArray *)arraySelImg;
@end
@interface ELCAssetTablePicker : UITableViewController
{
    id <ELCAssestTableDataSource>ELCTableDelegate;
	ALAssetsGroup *assetGroup;
	
	NSMutableArray *elcAssets;
	int selectedAssets;
	
	id parent;
	
	NSOperationQueue *queue;
    
    NSMutableArray *assetGroups;
    ALAssetsLibrary *library;
}
@property (retain,nonatomic) id <ELCAssestTableDataSource>ELCTableDelegate;
@property (nonatomic, retain) NSMutableArray *assetGroups;
@property (nonatomic, assign) id parent;
@property (nonatomic, assign) ALAssetsGroup *assetGroup;
@property (nonatomic, retain) NSMutableArray *elcAssets;
@property (nonatomic, retain) IBOutlet UILabel *selectedAssetsLabel;

- (NSMutableArray *) selection; 
-(int)totalSelectedAssets;
-(void)preparePhotos;

-(void)doneAction:(id)sender;
-(void)getImagesFromPhotoLibrary;
-(void)goNextViewController;
@end