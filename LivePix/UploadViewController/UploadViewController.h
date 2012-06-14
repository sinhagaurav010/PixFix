//
//  UploadViewController.h
//  LivePix
//
//  Created by    on 08/06/12.
//  Copyright (c)  . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "ELCImagePickerController.h"
#import "ELCAlbumPickerController.h"
#import "ELCAssetTablePicker.h"
#import "ELCAssetCell.h"
#import "ELCAsset.h"
#import "ELCAlbumPickerController.h"
#import "MBProgressHUD.h"
#import "ASINetworkQueue.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ModalController.h"
//#define URLPOST @"http://74.53.228.211/~vodavo/webservices/addimage.php"
#import "ELCAssetTablePicker.h"
#import "ELCImagePickerController.h"
#define URLPOST @"http://74.53.228.211/~vodavo/webservices/addimage.php?image_name=abc&event_id="


//74.53.228.211/~vodavo/webservices/addevent.php?image_name=abc&event_id=123&user_email=ram@yopmail.com

#import "NSData+Base64.h"

@interface UploadViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    NSInteger totalHit;
    ASINetworkQueue *myQueue;
    IBOutlet UITableView *tblViewHome;

    ELCAssetTablePicker *picker ;
    IBOutlet UIView *viewLib;
    IBOutlet UIImageView *imageViewPick;
    NSMutableArray *assetGroups;
    ALAssetsLibrary *library;
}
-(void)hitUrl:(NSInteger)index;

@property(retain)NSMutableArray *arrayAsset;

-(void)loadDataInTableView;
-(IBAction)ClickToshowBtn:(id)sender;

@property (nonatomic, retain) NSMutableArray *assetGroups;

+ (NSString*)base64forData:(NSData*)theData ;

-(IBAction)camera:(id)sender;
-(IBAction)clickTotakePhoto:(id)sender;
-(IBAction)upload:(id)sender;
-(void)getImagesFromPhotoLibrary;
@end
