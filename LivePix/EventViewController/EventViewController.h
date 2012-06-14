//
//  EventViewController.h
//  LivePix
//
//  Created by preet dhillon on 08/06/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ModalController.h"
#import "XMLReader.h"
#import "EGOImageView.h"
#import "FullImageViewController.h"
#import "UploadViewController.h"
#import "Facebook.h"
#import "AppDelegate.h"

@interface EventViewController : UIViewController<ModalDelegate>
{  
    
    ModalController *modal;
    NSMutableArray *imageEGOArray;
    IBOutlet UIScrollView *scrollEventImages;
    CGRect frameScrl;
    NSArray *_permissions;
}
- (void)login;
@property (retain, nonatomic) Facebook * facebook;


@property(retain)NSString *stringTitle;

@property(retain)NSMutableArray *arrayimages;
@property(retain)IBOutlet UIWebView *webEvent;
@end
