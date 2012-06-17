//
//  EventViewController.m
//  LivePix
//
//  Created by    on 08/06/12.
//  Copyright (c)  . All rights reserved.
//
/*event-date" = "2012-06-12";
 "event-description" = "this is a party";
 "event-id" = 13;
 "event-image-path" = "http://74.53.228.211/~vodavo/webservices/app_event_images/1339523580img.jpg";
 "event-name" = "ants badly party";
 "event-user" = "michaelplasse@gmail.com";
 "event-user-name" = "Michael Plasse";
 */
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
    
    if(isdel == 0)
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
        
//        UILongPressGestureRecognizer* longPressGesture = [[UILongPressGestureRecognizer alloc]
//                                                          initWithTarget:self
//                                                          action:@selector(handleLongPressGesture:)];
//        
//        
//        //longPressGesture.minimumPressDuration = 2.0;
//        [imageEvet addGestureRecognizer:longPressGesture];

        UISwipeGestureRecognizer *leftSwipe  =  [[UISwipeGestureRecognizer alloc]initWithTarget:self 
                                                                                         action:@selector(handleLongPressGesture:)];
        [leftSwipe setDirection:( UISwipeGestureRecognizerDirectionLeft)];
        leftSwipe.delegate  =   self;
        [imageEvet addGestureRecognizer:leftSwipe];
        
        
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
    else 
    {
       if([modal.stringRx rangeOfString:@"Image was deleted"].length>0)
       {
           [ModalController  FuncAlertMsg:@"Image was deleted" inController:self];
           [self  refresh];
       }
       else 
       {
           [ModalController  FuncAlertMsg:@"Image was not deleted" inController:self];

       }
    }
}


-(void)handleLongPressGesture:(UISwipeGestureRecognizer*)sender 
{
    if([[[self.arrayimages    objectAtIndex:sender.view.tag] objectForKey:@"image-creator"] isEqualToString:[ModalController  getContforKey:KsSAVEDID]])
//    if(UIGestureRecognizerStateEnded == sender.state)
//    {
        indexTag = [sender   view].tag;
        isdel = 1;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Do you want to delete this Image"
                                                        message:nil 
                                                       delegate:self 
                                              cancelButtonTitle:nil 
                                              otherButtonTitles:@"YES",@"NO", nil];
        alert.tag = 1299;
        [alert show];
        [alert release];
//    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
if(alertView.tag == 1299)
{
    [modal  sendTheRequestWithPostString:nil 
                           withURLString:[NSString stringWithFormat:KsDeleteImage,[[arrayimages  objectAtIndex:indexTag]objectForKey:@"image-id"],[ModalController getContforKey:KsSAVEDID]]];   
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
        case 2:
        {
            AttendeesViewController *attendeesController = [[AttendeesViewController  alloc] init];
            [self.navigationController  pushViewController:attendeesController
                                                  animated:YES];
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
                                                otherButtonTitles:@"Invite Friends",@"Add Photos",@"Attendees",@"Cancel", nil];
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
    
    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    NSArray *contactArr = (NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);

    NSLog(@"%@",contactArr);
    
    arrayContact = [[NSMutableArray  alloc] init];
    
    for (int i = 0; i < [contactArr count]; i++) 
    {
        NSMutableDictionary *dictPerson = [[NSMutableDictionary  alloc] init];
        
        ABRecordRef person = (ABRecordRef)[contactArr objectAtIndex:i];
        //
        
        if((NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty))
        [dictPerson  setObject:(NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty) forKey:@"FName"];
        
        if((NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty))
        [dictPerson  setObject:(NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty) forKey:@"LName"];
        
        [dictPerson  setObject:@"n" forKey:@"status"];
        if((NSString *)ABRecordCopyValue(person, kABPersonEmailProperty))
        {
            
            ABMultiValueRef emailProperty = ABRecordCopyValue(person, kABPersonEmailProperty);
            
            NSArray *emailArray = (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(emailProperty);            [dictPerson  setObject:[NSString stringWithFormat:@"%@", [emailArray objectAtIndex:0]] forKey:@"Email"];
        
        }
        
        
        NSData *contactImageData = (NSData*)ABPersonCopyImageDataWithFormat(person,  
                                                                            kABPersonImageFormatThumbnail);
        
        if(contactImageData)
        {
        UIImage *img = [[UIImage alloc] initWithData:contactImageData];
        [dictPerson  setObject:img
                        forKey:@"image"];
        }
        
        [arrayContact  addObject:dictPerson];
        
        
       
//        [dictPerson  setObject:[[UIImage alloc] initWithData:[person imageData]]  forKey:@"imgae"];
        
//        for(CFIndex j = 0; j < ABMultiValueGetCount(address); j++)
//        {
//            CFDictionaryRef addressDict = ABMultiValueCopyValueAtIndex(address, j);
//            
//            CFStringRef streetValue = CFDictionaryGetValue(addressDict, kABPersonAddressStreetKey);
//            
//            CFStringRef cityValue = CFDictionaryGetValue(addressDict, kABPersonAddressCityKey);
//            
//            CFStringRef stateValue = CFDictionaryGetValue(addressDict, kABPersonAddressStateKey);
//            
//            CFStringRef zipValue = CFDictionaryGetValue(addressDict, kABPersonAddressZIPKey);
//            
//            CFStringRef countryValue = CFDictionaryGetValue(addressDict, kABPersonAddressCountryKey);
//            
//            
//        }
//        
    }
    
    InviteFriendViewControllerViewController *controller = [[InviteFriendViewControllerViewController  alloc] init];
    controller.arrayContacts = [[NSMutableArray alloc] initWithArray:arrayContact];
    
    
    [self.navigationController  pushViewController:controller
                                          animated:YES];
//    NSLog(@"~~~~~~~%@",arrayContact);
	// creating the picker
//	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
//	// place the delegate of the picker to the controll
//	picker.peoplePickerDelegate = self;
//    
//	// showing the picker
//	[self presentModalViewController:picker animated:YES];
//	// releasing
//	[picker release];
}

//- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
//    // assigning control back to the main controller
//	[self dismissModalViewControllerAnimated:YES];
//}
//
//- (BOOL)peoplePickerNavigationController: (ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
//    
//	// setting the first name
////    firstName.text = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
//    
//	// setting the last name
////    lastName.text = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);	
//    NSLog(@"%@ %@",(NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty),(NSString *)ABRecordCopyValue(person,  kABPersonEmailProperty));
//    
//	// setting the number
//	/*
//	 this function will set the first number it finds
//     
//	 if you do not set a number for a contact it will probably
//	 crash
//	 */
//	ABMultiValueRef multi = ABRecordCopyValue(person, kABPersonPhoneProperty);
////	number.text = (NSString*)ABMultiValueCopyValueAtIndex(multi, 0);
//    
//	// remove the controller
//    [self dismissModalViewControllerAnimated:YES];
//    
//    return NO;
//}
//
//- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
//    return NO;
//}
//- (void)login {
//    
//    
//    NSLog(@"Login Press");
////    if(![_facebook isSessionValid])
////    [_facebook authorize:_permissions 
////                delegate:self];
////    else {
////        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
////                                       @"Come check out Live pic app.", @"message",
////                                       nil];
////        
////        [_facebook dialog:@"apprequests"
////                andParams:params
////              andDelegate:self];
////    }
//}
//


- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    //    [MBProgressHUD hideHUDForView:self.navigationController.view
    //                         animated:YES];
    //    
    //    [ModalController    showTheAlertWithMsg:@"Failed To Post" withTitle:@"Sorry" inController:self];
}

- (void)fbDidLogin {
    
    NSLog(@"fbLogin");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view 
                                              animated:YES];
    hud.labelText = @"Loading...";
//    
//    [_facebook requestWithGraphPath:@"me" 
//                        andDelegate:self];
    [_facebook requestWithGraphPath:@"me/friends" 
                          andParams:[ NSMutableDictionary dictionaryWithObjectsAndKeys:@"picture,id,name,link,gender,last_name,first_name,email",@"fields",nil]
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



- (void)request:(FBRequest *)request didLoad:(id)result
{
    [MBProgressHUD  hideHUDForView:self.navigationController.view 
                          animated:YES];
    
    InviteFriendViewControllerViewController *controller = [[InviteFriendViewControllerViewController  alloc] init];
    controller.inviteFriendDict = [NSMutableDictionary  dictionaryWithDictionary:(NSDictionary *)result];
    
    [self.navigationController  pushViewController:controller
                                          animated:YES];
    
    NSLog(@"~~~~~~~~~~~~%@",result);
}

//- (void)dialogDidNotCompleteWithUrl:(NSURL *)url
//{
//    NSLog(@"%@",url);
//}
//- (void) dialogCompleteWithUrl:(NSURL*) url
//{
//    NSLog(@"%@",url);
//    
//    if ([url.absoluteString rangeOfString:@"post_id="].location != NSNotFound) {
//        //alert user of successful post
//    } else {
//        //user pressed "cancel"
//    }
//}
/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
    NSLog(@"did not login");
}

- (void)viewWillAppear:(BOOL)animated
{
   
    [self  refresh];
}
-(void)refresh
{
    
    frameScrl = scrollEventImages.frame;
    
    [scrollEventImages removeFromSuperview];
     isdel = 0; 
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
