//
//  InviteTableViewCellCell.h
//  LivePix
//
//  Created by Apple on 16/06/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface InviteTableViewCellCell : UITableViewCell

@property(retain)IBOutlet UILabel *lableEmail;
@property(retain)IBOutlet EGOImageView *imageMain;
@property(retain)IBOutlet UILabel *friendName;
@property(retain)IBOutlet UIButton *btnInv; 

-(void)setBttnWithTag:(NSInteger)index;
-(IBAction)clickToInvite:(id)sender;

@end
