//
//  CatagoryView.h
//  viaprive
//
//  Created by preet dhillon on 31/03/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface CatagoryView : UIView
{
   

}

-(void)setProductImage:(NSURL *)url;

-(void)setPrice:(NSString *)price;
-(void)setName:(NSString *)name;
@property(retain) IBOutlet UILabel *lablePrice;
@property(retain) IBOutlet EGOImageView *imageProduct;

@property(retain) IBOutlet UILabel *lableName;
@end
