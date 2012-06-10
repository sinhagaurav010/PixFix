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
@interface EventViewController : UIViewController<ModalDelegate>
{
    
    ModalController *modal;
    NSMutableArray *imageEGOArray;
    IBOutlet UIScrollView *scrollEventImages;
    CGRect frameScrl;
}
@property(retain)NSMutableArray *arrayimages;
@property(retain)IBOutlet UIWebView *webEvent;
@end
