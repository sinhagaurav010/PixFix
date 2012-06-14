//
//  SplashScreenController.m
//  LivePix
//
//  Created by preet dhillon on 08/06/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
//

#import "SplashScreenController.h"

@implementation SplashScreenController

@synthesize facebook = _facebook,loginUser;
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

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController  setNavigationBarHidden:YES];
}
-(void)goToHome
{
    
//    CATransition* transition = [CATransition animation];
//    transition.duration = 2.0;
//    transition.type = kCATransitionFade;
//    transition.subtype = kCATransitionFromTop;
//    
//    [self.navigationController.view.layer 
//     addAnimation:transition forKey:kCATransition];
    
    controllertab.selectedIndex = 0;
    [self.navigationController pushViewController:controllertab 
                                         animated:NO];
}
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    UINavigationController *navigation = (UINavigationController *)viewController;
//    
//    if([tabBarController selectedIndex] == 1)
//    {
//        if([CLLocationManager  locationServicesEnabled])
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info"
//                                                            message:@"Please Location service ON to check this.Do you want to ma" delegate:self
//                                                  cancelButtonTitle:nil otherButtonTitles:@"YES",@"NO", nil];
//            [alert show];
//            
//        
//        }
//    }
//}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    
//    [NSTimer    scheduledTimerWithTimeInterval:2.0 
//                                        target:self 
//                                      selector:@selector(goToHome)
//                                      userInfo:nil 
//                                       repeats:NO];

    
    AppDelegate  * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //    // Grab the facebook object from the app delegate.
    _facebook = appDelegate.facebook;
    _permissions =  [[NSArray arrayWithObjects:
                      @"read_stream", @"publish_stream", @"offline_access",@"email",@"user_birthday",@"user_photos",nil] retain];
    // _facebook = [[Facebook alloc] initWithAppId:AppIDAPI];
    //    
    //    //_facebook.sessionDelegate = self;
    //    
    _fbButton.isLoggedIn = NO;
    //    //_fbButton.
    [_fbButton updateImage];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)login {
    NSLog(@"Login Press");
    [_facebook authorize:_permissions delegate:self];
}

     

- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"received response");
    
}
- (void)request:(FBRequest *)request didLoad:(id)result {
//    
//    [ModalController showTheAlertWithMsg:@"Posted in FaceBook" 
//                               withTitle:@"Success"
//                            inController:self];
    
    self.loginUser = [result  objectForKey:@"email"]; 

    NSLog(@"%@-----  %@",[result  objectForKey:@"email"],result);
    NSLog(@"%@-----  ",[result  objectForKey:@"name"]);
    modal = [[ModalController  alloc] init];
    modal.delegate = self;

    [modal sendTheRequestWithPostString:nil
                          withURLString:[NSString stringWithFormat:@"%@%@&email=%@",KsURLSIGNUP,[result  objectForKey:@"name"],[result  objectForKey:@"email"]]];
    
    // [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];    
    
     //    if ([result isKindOfClass:[NSDictionary class]]) {
    //        dictResponse = [[NSMutableDictionary alloc] init];
    //        
    //        if([result objectForKey:@"birthday"])
    //            [dictResponse setObject:[result objectForKey:@"birthday"] forKey:@"birthday"];
    //          if([result objectForKey:@"email"])
    //            [dictResponse setObject:[result objectForKey:@"email"] forKey:@"email"];
    //        if([result objectForKey:@"first_name"])
    //            [dictResponse setObject:[result objectForKey:@"first_name"] forKey:@"first_name"];
    //        if([result objectForKey:@"last_name"])
    //            [dictResponse setObject:[result objectForKey:@"last_name"] forKey:@"last_name"];
    //        if([result objectForKey:@"gender"])
    //            [dictResponse setObject:[result objectForKey:@"gender"] forKey:@"gender"];
    //        if([result objectForKey:@"work"])
    //            if([[[result objectForKey:@"work"] objectAtIndex:0] objectForKey:@"employer"])
    //                if([[[[result objectForKey:@"work"] objectAtIndex:0] objectForKey:@"employer"] objectForKey:@"name"])
    //                    [dictResponse setObject:[[[[result objectForKey:@"work"] objectAtIndex:0]  
    //                                              objectForKey:@"employer"] 
    //                                             objectForKey:@"name"] forKey:@"employee"];
    //        
    //        if ([result objectForKey:@"id"]) {
    //            [dictResponse setObject:[result objectForKey:@"id"] forKey:@"fbId"];
    //        }
    //        
    //        modal = [[ModalController alloc] init];
    //        
    //        NSString *stringAuthLogin = [NSString stringWithFormat:@"email=%@&facebook_id=%@",[dictResponse 
    //                                                                                           objectForKey:@"email"],[dictResponse objectForKey:@"fbId"]];
    //        
    //        ////NSLog(@"string%@",stringAuthLogin);
    //        
    //        modal.delegate = self;
    //        
    //        //        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    //        //        hud.labelText = @"Loading...";
    //        
    //        [modal sendTheRequestWithPostString:stringAuthLogin withURLString:URLFACEBOOKLOGIN];
    /////////////////////////
    //        RegistrationViewController *RegistrationController = [[RegistrationViewController alloc] init];
    //        RegistrationController.dictFacebook = [NSMutableDictionary dictionaryWithDictionary:dictResponse];
    //        [self.navigationController pushViewController:RegistrationController animated:YES];
    
    //[dictResponse release];
    
    //}
    //	[self dismissModalViewControllerAnimated:TRUE];
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
    _fbButton.isLoggedIn = YES;
    [_fbButton updateImage];   
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"Loading...";

    [_facebook requestWithGraphPath:@"me" 
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

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {
    
    _fbButton.isLoggedIn = NO;
    [_fbButton updateImage];
}


/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {
    [_facebook logout:self];
}


-(IBAction)connectToFB:(id)sender
{

    if (_fbButton.isLoggedIn) {
        [self logout];
    } else {
        [self login];
    }
}

-(void)getdata
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];

    [ModalController  saveTheContent:self.loginUser
                             withKey:KsSAVEDLOGGEDIN];
    AddEventViewController *controller = [[AddEventViewController  alloc] initWithNibName:@"AddEventViewController"
                                                                                   bundle:nil];
    [self.navigationController  pushViewController:controller
                                          animated:YES];
    
    NSLog(@"%@",modal.stringRx);
}

-(void)getError
{
    [MBProgressHUD hideHUDForView:self.navigationController.view
                         animated:YES];
    [ModalController FuncAlertMsg:@"Error in network!!!"
                     inController:self];
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
