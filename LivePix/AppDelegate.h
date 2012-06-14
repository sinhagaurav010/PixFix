//
//  AppDelegate.h
//  LivePix
//
//  Created by    on 08/06/12.
//  Copyright (c)  . All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SplashScreenController.h"
#import "FBConnect.h"
#import "DataSet.h"
#import "ModalController.h"
@class SplashScreenController;
@class AddEventViewController;
static NSString* kAppId = @"308790145802337";

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    
}
@property(nonatomic,strong)AddEventViewController *AddEventController;
@property (nonatomic, retain) Facebook *facebook;

@property(strong,nonatomic)UINavigationController *navigation;
@property(strong,nonatomic)SplashScreenController *SplashController;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) DataSet *apiData;

@property (nonatomic, retain) NSMutableDictionary *userPermissions;

@end
