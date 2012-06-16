//
//  EventViewCell.m
//  LivePix
//
//  Created by Michael Plasse on 14/06/12.
//  Copyright (c)  . All rights reserved.
//

#import "EventViewCell.h"

@implementation EventViewCell
@synthesize lableCreater,delegate,lableName,imageMain,btnDel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(IBAction)deleteEvent:(id)sender
{
    [delegate  deleteWith:self.btnDel.tag];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
