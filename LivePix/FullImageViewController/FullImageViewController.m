//
//  FullImageViewController.m
//  LivePix
//
//  Created by Apple on 12/06/12.
//  Copyright (c)  . All rights reserved.
//

#import "FullImageViewController.h"

@interface FullImageViewController ()

@end

@implementation FullImageViewController
@synthesize dictImage,labelName,imageEvent,scrollImages,arrayImageUrl,selectedIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    int incX = 0;
    [self.scrollImages setContentSize:CGSizeMake([self.arrayImageUrl  count]*320, 416)];
    self.scrollImages.pagingEnabled = YES;
    for(int i=0;i<[arrayImageUrl  count];i++)
    {
        CatagoryView *eventImage;
        eventImage = [[CatagoryView alloc] init];
        
        NSArray *bundle = [[NSBundle mainBundle] loadNibNamed:@"CatagoryView"
                                                        owner:eventImage 
                                                      options:nil];
        
        for (id object in bundle) {
            if ([object isKindOfClass:[eventImage class]])
                eventImage= (CatagoryView *)object;
        }   
        
        eventImage.frame = CGRectMake( incX,0, 320 , 416);
        eventImage.imageProduct.imageURL = [NSURL  URLWithString:[[self.arrayImageUrl  objectAtIndex:i]objectForKey:@"image-path"]];
        eventImage.lableName.text = [[self.arrayImageUrl  objectAtIndex:i] objectForKey:@"image-name"];
        eventImage.backgroundColor = [UIColor  blackColor];
        eventImage.lableDate.text = [[self.arrayImageUrl  objectAtIndex:i] objectForKey:@"image-date"];//
        incX+= 320;
        [self.scrollImages  addSubview:eventImage];
        
    }
    labelName.text = [self.dictImage objectForKey:@"image-name"];
    [self.scrollImages setContentOffset:CGPointMake(selectedIndex*320, 0)];
    //    imageEvent.imageURL = [self.dictImage  objectForKey:@"image-path"];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
