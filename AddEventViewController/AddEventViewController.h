//
//  AddEventViewController.h
//  LivePix
//
//  Created by    on 10/06/12.
//  Copyright (c)  . All rights reserved.
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

@interface AddEventViewController : UIViewController<ModalDelegate,EGORefreshTableHeaderDelegate,EventCellDelegate>
{
   IBOutlet UISegmentedControl *segment;
    BOOL _reloading;

    EGORefreshTableHeaderView *_refreshHeaderView;
    NSInteger indexToDel;
    
    ModalController *modal;
    NSInteger isGet;
    IBOutlet UITableView *tableEvent;
    UITextField *myTextField;
    
    IBOutlet UITabBarController *tabBarcont;
}
-(void)getEvents;

@property(retain)NSMutableArray *arrayEvent;
@end
