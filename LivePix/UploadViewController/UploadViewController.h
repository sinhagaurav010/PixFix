//
//  UploadViewController.h
//  LivePix
//
//  Created by preet dhillon on 08/06/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
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
#import <AssetsLibrary/AssetsLibrary.h>
#import "ModalController.h"
//#define URLPOST @"http://74.53.228.211/~vodavo/webservices/addimage.php"

#define URLPOST @"http://74.53.228.211/~vodavo/webservices/addimage.php?image_name=abc&event_id="


//74.53.228.211/~vodavo/webservices/addevent.php?image_name=abc&event_id=123&user_email=ram@yopmail.com

#import "NSData+Base64.h"

@interface UploadViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{

    IBOutlet UIView *viewLib;
    IBOutlet UIImageView *imageViewPick;
    NSMutableArray *assetGroups;
    ALAssetsLibrary *library;
}


@property (nonatomic, retain) NSMutableArray *assetGroups;

+ (NSString*)base64forData:(NSData*)theData ;

-(IBAction)camera:(id)sender;
-(IBAction)clickTotakePhoto:(id)sender;
-(IBAction)upload:(id)sender;
-(void)getImagesFromPhotoLibrary;
@end
