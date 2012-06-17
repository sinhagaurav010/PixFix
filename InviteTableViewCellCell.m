//
//  InviteTableViewCellCell.m
//  LivePix
//
//  Created by Apple on 16/06/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
//

#import "InviteTableViewCellCell.h"

@implementation InviteTableViewCellCell
@synthesize imageMain,friendName,lableEmail,btnInv;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)setBttnWithTag:(NSInteger)index
{
    self.btnInv.tag = index;
    
    [self.btnInv  setImage:[UIImage imageNamed:@"check_empty_new.png"]
                  forState:UIControlStateNormal];
    [self.btnInv  setImage:[UIImage imageNamed:@"check_filled_new.png"]
                  forState:UIControlStateSelected];
 
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)clickToInvite:(id)sender
{
if(self.btnInv.selected == 0)
{
    self.btnInv.selected = 1;

}
else {
    self.btnInv.selected = 0;

}
}
@end
