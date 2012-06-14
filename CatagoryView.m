//
//  CatagoryView.m
//  viaprive
//
//  Created by preet dhillon on 31/03/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
//

#import "CatagoryView.h"

@implementation CatagoryView

@synthesize lableName,lableDate,imageProduct;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


    //self.imageProduct.imageURL = url;
-(void)setProductImage:(NSURL *)url
{
        self.imageProduct.placeholderImage = [UIImage imageNamed:@"back.png"];
        self.imageProduct.imageURL = url;
}


-(void)setPrice:(NSString *)price
{
    self.lableDate.text = price;
}

-(void)setName:(NSString *)name
{
    self.lableName.text = name;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
