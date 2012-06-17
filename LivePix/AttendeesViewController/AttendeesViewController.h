//
//  AttendeesViewController.h
//  LivePix
//
//  Created by Apple on 18/06/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalController.h"
#import "MBProgressHUD.h"
#import "XMLReader.h"
#import "EventViewCell.h"
@interface AttendeesViewController : UIViewController<ModalDelegate>
{
    ModalController *modal;
    NSMutableArray *arrayAttendees;
}
@property(retain)IBOutlet UITableView *tableAttendees;
   
@end
