//
//  AddEventViewController.h
//  LivePix
//
//  Created by preet dhillon on 10/06/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ModalController.h"
#import "XMLReader.h"
#import "SplashScreenController.h"
#import "UploadViewController.h"
#import "EventViewController.h"
#import "NewEventViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "EventViewCell.h"

@interface AddEventViewController : UIViewController<ModalDelegate,EGORefreshTableHeaderDelegate>
{
    BOOL _reloading;

    EGORefreshTableHeaderView *_refreshHeaderView;

    ModalController *modal;
    BOOL isGet;
    IBOutlet UITableView *tableEvent;
    UITextField *myTextField;
    
    IBOutlet UITabBarController *tabBarcont;
}
-(void)getEvents;

@property(retain)NSMutableArray *arrayEvent;
@end
