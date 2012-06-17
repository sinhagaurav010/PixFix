//
//  InviteFriendViewControllerViewController.h
//  LivePix
//
//  Created by Apple on 16/06/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalController.h"
#import "MBProgressHUD.h"
#import "InviteTableViewCellCell.h"
#import <AddressBook/AddressBook.h>
#import <MessageUI/MessageUI.h>


@interface InviteFriendViewControllerViewController : UIViewController

{
}
@property(retain)InviteTableViewCellCell *cellinvited;
@property(retain)IBOutlet UITableView *tableView;
@property(retain)NSMutableDictionary *inviteFriendDict;
@property(retain)NSMutableArray *arrayContacts;
@end
