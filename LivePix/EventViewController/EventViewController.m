//
//  EventViewController.m
//  LivePix
//
//  Created by preet dhillon on 08/06/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
//

#import "EventViewController.h"

@implementation EventViewController
@synthesize webEvent,arrayimages;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(void)getdata
{
    
    scrollEventImages = [[UIScrollView  alloc] initWithFrame:frameScrl];
    [self.view  addSubview:scrollEventImages];
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    
    NSDictionary *_xmlDictionaryData = [[XMLReader dictionaryForXMLData:[modal dataXml] 
                                                                  error:nil] retain];
    NSLog(@"%@",_xmlDictionaryData);
    
    if(![[_xmlDictionaryData  objectForKey:@"images"] isEqualToString:@"Image Not Found"])
    {
    if([[[_xmlDictionaryData objectForKey:@"event-images"] objectForKey:@"images"] isKindOfClass:[NSArray  class]])
    {
        arrayimages = [[NSMutableArray  alloc] initWithArray:[[_xmlDictionaryData objectForKey:@"event-images"] objectForKey:@"images"]];
    }
    else
    {
        arrayimages     = [[NSMutableArray  alloc] init];
        [arrayimages addObject:[[_xmlDictionaryData objectForKey:@"event-images"] objectForKey:@"images"] ];
    }
    NSLog(@"%@",modal.stringRx);
    
    int sizeScr = ceil([arrayimages  count]/3);
    [scrollEventImages   setContentSize:CGSizeMake(320, sizeScr*93)];
    int incx = 10;
    int incY = 10;
    int count = 0;
    for(int i=0;i<[arrayimages  count];i++)
    {
        EGOImageView *imageEvet = [[EGOImageView  alloc] initWithFrame:CGRectMake(incx, incY, 93, 93)];
        imageEvet.imageURL = [NSURL  URLWithString:[[arrayimages  objectAtIndex:i] objectForKey:@"image-path"]];
        [scrollEventImages  addSubview:imageEvet];
        
        if((i+1)%3==0)
        {
            incY += 103;
            incx = 10;
        }
        else
            incx +=103;
    }
    }
    else
    {
        [ModalController  FuncAlertMsg:@"No image Found!" inController:self];
    }
}

-(void)getError
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    [ModalController FuncAlertMsg:@"Error in network!!!"
                     inController:self];
}


#pragma mark - View lifecycle

//- (void)viewWillAppear:(BOOL)animated
//{
//
//    
//
//}
- (void)viewDidLoad
{


    self.navigationItem.title = @"Event";
    [self.navigationController.navigationBar  setTintColor:[UIColor blackColor]];

    [self.view setBackgroundColor:[UIColor  blackColor]];
    
//    [webEvent loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.veryawesome.com/livepix/"]]];
//    webEvent.scalesPageToFit = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    
    frameScrl = scrollEventImages.frame;
    
    [scrollEventImages removeFromSuperview];
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText=@"Loading...";
    
    
    modal = [[ModalController  alloc] init];
    modal.delegate = self;
    [modal  sendTheRequestWithPostString:nil withURLString:[NSString stringWithFormat:@"%@%@",KsAlLEVENTIMAgES,[ModalController getContforKey:KsSELEVENT]]];
    
    [self.navigationController  setNavigationBarHidden:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD  hideHUDForView:self.navigationController.view animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD  hideHUDForView:self.navigationController.view animated:YES];

    //    if(isFirst == 1)
    //    {
    //         isFirst = 0;
    [MBProgressHUD  hideHUDForView:self.navigationController.view animated:YES];
    //    [ModalController FuncAlertMsg:@"No Connection Found" inController:self];
    //    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
