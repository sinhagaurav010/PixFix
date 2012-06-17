//
//  EventViewCell.h
//  LivePix
//
//  Created by Michael Plasse on 14/06/12.
//  Copyright (c)  . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@protocol EventCellDelegate <NSObject>

-(void)deleteWith:(NSInteger)index;

@end


@interface EventViewCell : UITableViewCell
@property(retain)IBOutlet EGOImageView *imageMain;

-(IBAction)deleteEvent:(id)sender;
@property(retain)id<EventCellDelegate>delegate;

@property(retain)IBOutlet UILabel *lableName;
@property(retain)IBOutlet UILabel *lableCreater;
@property(retain)IBOutlet  UIButton *btnDel;
@property(retain)IBOutlet UILabel *lableTime;
@end
