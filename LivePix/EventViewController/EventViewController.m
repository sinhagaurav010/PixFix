//
//  EventViewController.m
//  LivePix
//
//  Created by    on 08/06/12.
//  Copyright (c)  . All rights reserved.
//

#import "EventViewController.h"

@implementation EventViewController
@synthesize webEvent,facebook = _facebook,arrayimages,stringTitle;
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
    [MBProgressHUD hideHUDForView:self.navigationController.view 
                         animated:YES];
    
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
    [scrollEventImages   setContentSize:CGSizeMake(320, sizeScr*103)];
    int incx = 10;
    int incY = 10;
    int count = 0;
        
        
    for(int i=0;i<[arrayimages  count];i++)
    {
        EGOImageView *imageEvet = [[EGOImageView  alloc] initWithFrame:CGRectMake(incx, incY, 93, 93)];
        imageEvet.placeholderImage = [UIImage  imageNamed:@"icon-placeholder.png"];
        
        imageEvet.userInteractionEnabled = YES;
        imageEvet.tag = i;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer  alloc] initWithTarget:self
                                                                                   action:@selector(tapImage:)];
        [imageEvet  addGestureRecognizer:gesture];
        
        imageEvet.imageURL = [NSURL  URLWithString:[[arrayimages  objectAtIndex:i] 
                                      objectForKey:@"image-thumb"]];
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

-(void)tapImage:(UITapGestureRecognizer *)rec
{
    FullImageViewController *controller = [[FullImageViewController  alloc] init];
    controller.dictImage = [arrayimages objectAtIndex:rec.view.tag];
    controller.arrayImageUrl = self.arrayimages;
    controller.selectedIndex = rec.view.tag;
    
    [self.navigationController  pushViewController:controller
                                          animated:YES];
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

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1 :
        {
            UploadViewController *controller = [[UploadViewController  alloc] init];
            [self.navigationController  pushViewController:controller
                                                  animated:YES];
            [controller  release];
        }
        break;
        case 0:
        {
            NSLog(@"workInBackGround");
            [self login];
                     
        }
            break;
        default:
            break;
    }

}
-(void)option
{
    UIActionSheet *action = [[UIActionSheet  alloc] initWithTitle:@"Option"
                                                     delegate:self
                                            cancelButtonTitle:nil 
                                       destructiveButtonTitle:nil
                                            otherButtonTitles:@"Invite Friends",@"Add Photos",@"Cancel", nil];
    action.actionSheetStyle = UIActionSheetStyleDefault;
    [action  showInView:self.view];
}
- (void)viewDidLoad
{
    
    AppDelegate  * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //    // Grab the facebook object from the app delegate.
    _facebook = appDelegate.facebook;
    _permissions =  [[NSArray arrayWithObjects:
                      @"read_stream", @"publish_stream", @"offline_access",@"email",@"user_birthday",@"user_photos",nil] retain];
    self.navigationItem.title =self.stringTitle;
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Options" 
                                                                           style:UIBarButtonItemStyleBordered 
                                                                          target:self
                                                                          action:@selector(option)];
    [self.navigationController.navigationBar  setTintColor:[UIColor blackColor]];

    [self.view setBackgroundColor:[UIColor  blackColor]];
    
//    [webEvent loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.veryawesome.com/livepix/"]]];
//    webEvent.scalesPageToFit = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)login {
    NSLog(@"Login Press");
    [_facebook authorize:_permissions 
                delegate:self];
}




/**
 * Called when a request returns and its response has been parsed into
 * an object. The resulting object may be a dictionary, an array, a string,
 * or a number, depending on the format of the API response. If you need access
 * to the raw response, use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */

/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    //    [MBProgressHUD hideHUDForView:self.navigationController.view
    //                         animated:YES];
    //    
    //    [ModalController    showTheAlertWithMsg:@"Failed To Post" withTitle:@"Sorry" inController:self];
}

- (void)fbDidLogin {
    
    NSLog(@"fbLogin");
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//    hud.labelText = @"Loading...";
//    
//    [_facebook requestWithGraphPath:@"me" 
//                        andDelegate:self];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Come check out Live pic app.", @"message",
                                   nil];
    
    [_facebook dialog:@"apprequests"
            andParams:params
          andDelegate:self];

    
    // FBRequest *request = [[FBRequest alloc] init];
    //    //
    //    //    
    //    //    
    //    //    request = [_facebook requestWithGraphPath:@"me" andDelegate:self];
    //    NSMutableDictionary *variables = [NSMutableDictionary dictionaryWithCapacity:4];
    //    
    //    //[variables setObject:@"http://farm6.static.flickr.com/5015/5570946750_a486e741.jpg" forKey:@"link"];
    //    //[variables setObject:@"http://farm6.static.flickr.com/5015/5570946750_a486e741.jpg" forKey:@"picture"];
    //    [variables setObject:@"You scored 99999" forKey:@"name"];
    //    [variables setObject:@" " forKey:@"caption"];
    //    [variables setObject:[NSString stringWithFormat:@"%@",[dictInfo objectForKey:FIELDDESC]] forKey:@"message"];
    //    
    //    [_facebook requestWithMethodName:@"stream.publish" andParams:variables andHttpMethod:@"POST" andDelegate:self];
}
/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
    NSLog(@"did not login");
}

- (void)viewWillAppear:(BOOL)animated
{
    
    frameScrl = scrollEventImages.frame;
    
    [scrollEventImages removeFromSuperview];
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.navigationController.view 
                                            animated:YES];
    hud.labelText=@"Loading...";
    
    modal = [[ModalController  alloc] init];
    modal.delegate = self;
    [modal  sendTheRequestWithPostString:nil 
                           withURLString:[NSString stringWithFormat:@"%@%@",KsAlLEVENTIMAgES,[ModalController getContforKey:KsSELEVENT]]];
    
    [self.navigationController  setNavigationBarHidden:NO];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD  hideHUDForView:self.navigationController.view 
                          animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD  hideHUDForView:self.navigationController.view 
                          animated:YES];

    //    if(isFirst == 1)
    //    {
    //         isFirst = 0;
    [MBProgressHUD  hideHUDForView:self.navigationController.view 
                          animated:YES];
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
