//
//  FullImageViewController.h
//  LivePix
//
//  Created by Apple on 12/06/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatagoryView.h"


@interface FullImageViewController : UIViewController

@property(retain)NSMutableDictionary *dictImage;
@property(retain)NSMutableArray *arrayImageUrl;
@property(retain)IBOutlet UILabel *labelName;
@property(retain) IBOutlet EGOImageView *imageEvent;
@property(retain)IBOutlet UIScrollView *scrollImages;
@property(assign)NSInteger selectedIndex;
@end
