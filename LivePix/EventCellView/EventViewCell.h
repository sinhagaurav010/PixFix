//
//  EventViewCell.h
//  LivePix
//
//  Created by Michael Plasse on 14/06/12.
//  Copyright (c)  . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface EventViewCell : UITableViewCell
@property(retain)IBOutlet EGOImageView *imageMain;

@property(retain)IBOutlet UILabel *lableName;
@property(retain)IBOutlet UILabel *lableCreater;

@end
