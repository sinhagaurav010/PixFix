//
//  EventViewCell.h
//  LivePix
//
//  Created by Rohit Dhawan on 14/06/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface EventViewCell : UITableViewCell
@property(retain)IBOutlet EGOImageView *imageMain;

@property(retain)IBOutlet UILabel *lableName;
@property(retain)IBOutlet UILabel *lableCreater;

@end
