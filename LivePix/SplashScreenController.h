//
//  SplashScreenController.h
//  LivePix
//
//  Created by preet dhillon on 08/06/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "FBLoginButton.h"
#import "Facebook.h"
#import "ModalController.h"
#import "MBProgressHUD.h"
#import "AddEventViewController.h"

@interface SplashScreenController : UIViewController<ModalDelegate>

{
    CLLocationManager *mangLoc;
    IBOutlet UITabBarController *controllertab;
    NSArray* _permissions;
    IBOutlet FBLoginButton* _fbButton;
    ModalController *modal;
}
@property(retain)NSString *loginUser;
-(IBAction)connectToFB:(id)sender;
@property (retain, nonatomic) Facebook * facebook;

@end