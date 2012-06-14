//
//  UploadViewController.m
//  LivePix
//
//  Created by    on 08/06/12.
//  Copyright (c)  . All rights reserved.
//

#import "UploadViewController.h"

@implementation UploadViewController
@synthesize assetGroups,arrayAsset;
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
    [self.navigationController  setNavigationBarHidden:NO];
}
#pragma mark - View lifecycle
 
- (void)viewDidLoad
{
//    [self.view setHidden:YES];
    self.navigationItem.title = @"Upload";
    [self.navigationController.navigationBar  setTintColor:[UIColor blackColor]];
    
    picker = [[ELCAssetTablePicker alloc] init];
    picker.ELCTableDelegate=self;
    tblViewHome.delegate = picker;
    tblViewHome.dataSource = picker;
    [picker getImagesFromPhotoLibrary];
    [NSTimer scheduledTimerWithTimeInterval:1.0 
                                     target:self 
                                   selector:@selector(loadDataInTableView) 
                                   userInfo:nil 
                                    repeats:NO];
    
    
    [super viewDidLoad];
    
    
//    [self getImagesFromPhotoLibrary];
    // Do any additional setup after loading the view from its nib.
}

-(void)loadDataInTableView
{
    [tblViewHome reloadData];
    
}
#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
	NSLog(@"******info=%@",info);
	
}
//
//- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker {
//    
//	[self dismissModalViewControllerAnimated:YES];
//}


-(IBAction)ClickToshowBtn:(id)sender
{
    
    myQueue = [[ASINetworkQueue alloc] init];   
    [myQueue cancelAllOperations];
    [myQueue setDelegate:self];
    [myQueue setRequestDidFinishSelector:@selector(topSecretFetchComplete:)];
    [myQueue setRequestDidFailSelector:@selector(topSecretFetchFailed:)];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"Uploading...";
    
    int i;
    
    self.arrayAsset = [[NSMutableArray  alloc] initWithArray:[picker  selection]];
    
    totalHit = [self.arrayAsset count];
    
    if([self.arrayAsset count]>0)
        [self  hitUrl:0];
//    for (i=0; i<[self.arrayAsset count]; i++) 
//    { 
       //        [currentRequest setDidFinishSelector:@selector(topSecretFetchComplete:)];
//        [currentRequest setDidFailSelector:@selector(topSecretFetchFailed:)];
        
        //         [currentRequest startAsynchronous];
//        [myQueue addOperation:currentRequest];
//    }
//    [myQueue go];
}

-(void)hitUrl:(NSInteger)index
{
    ALAsset *assetImage = [self.arrayAsset objectAtIndex:index];
    NSLog(@"%@",assetImage.defaultRepresentation);
    NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:[[assetImage defaultRepresentation] fullResolutionImage]], 0.5);
    ASIFormDataRequest *currentRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@&user_email=%@",URLPOST,[ModalController  getContforKey:KsSELEVENT],[ModalController  getContforKey:KsSAVEDLOGGEDIN]]]];
    
    [currentRequest setPostFormat:ASIMultipartFormDataPostFormat];
    [currentRequest addRequestHeader:@"Content-Type" value:@"multipart/form-data"];
    [currentRequest setRequestMethod:@"POST"];
    
    NSString *encodedString = [imageData base64Encoding];
    
    [currentRequest setPostValue:encodedString forKey:@"file"];
    
    
    [currentRequest setDidFinishSelector:@selector(topSecretFetchComplete:)];
    [currentRequest setDidFailSelector:@selector(topSecretFetchFailed:)];

    //    [currentRequest  setData:imageData forKey:@"file"];
    currentRequest.delegate = self;    
    [currentRequest  startAsynchronous];
}
-(void)selectedImage:(NSArray *)arraySelImg
{

}


- (IBAction)topSecretFetchFailed:(ASIHTTPRequest *)theRequest
{
    NSLog(@"failed -%@",[theRequest responseString]);

    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];

    
    UIAlertView *alert = [[UIAlertView  alloc] initWithTitle:@"Info" 
                                                     message:@"Failed!"
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles: nil];
    [alert show];
    [alert  release];
    
    
//    NSLog(@"error%@",[theRequest  responseString]);    
//    UIAlertView *alert = [[UIAlertView  alloc] initWithTitle:@"Error" 
//                                                     message:[theRequest  responseString]
//                                                    delegate:self
//                                           cancelButtonTitle:@"OK"
//                                           otherButtonTitles: nil];
//    [alert show];
//    [alert  release];
}

- (IBAction)topSecretFetchComplete:(ASIHTTPRequest *)theRequest
{
    NSLog(@"complete -%@",[theRequest responseString]);
    
//    NSDictionary * dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:[theRequest  responseData] error:nil]; 
    
//    NSLog(@"%@",dictionary);
//    NSString *strMsg = [NSString stringWithFormat:@"Error = %@ \n pid = %@ \n Strength = %@ \n update = %@ \n errormsg = %@",[dictionary objectForKey:@"error"],[dictionary  objectForKey:@"pid"],[dictionary  objectForKey:@"strength"],[dictionary  objectForKey:@"updated"],[dictionary  objectForKey:@"errormsg"]];
    static NSInteger countimage = 0;
    countimage++;
    
    if(totalHit == countimage)
    {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];

        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self hitUrl:countimage];
    }
//    UIAlertView *alert = [[UIAlertView  alloc] initWithTitle:@"Info" 
//                                                     message:[theRequest responseString]
//                                                    delegate:self
//                                           cancelButtonTitle:@"OK"
//                                           otherButtonTitles: nil];
//    [alert show];
//    [alert  release];
}

-(IBAction)camera:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // Set source to the camera
    imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
    
    // Delegate is self
    imagePicker.delegate = self;
    
    // Allow editing of image ?
    //    imagePicker.allowsImageEditing = NO;
    
    // Show image picker
    [self.navigationController presentModalViewController:imagePicker animated:YES];
    
}
-(IBAction)clickTotakePhoto:(id)sender
{
    // Create image picker controller
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // Set source to the camera
    imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    // Delegate is self
    imagePicker.delegate = self;
    
    // Allow editing of image ?
    
    // Show image picker
    [self.navigationController presentModalViewController:imagePicker animated:YES];
}
+ (NSString*)base64forData:(NSData*)theData {
    
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease];
}
-(IBAction)upload:(id)sender
{
    
        
    
    
   
   
//    NSString *stringUrl ;
//    
////    if(TESTING)
//        stringUrl = URLPOST;
    
    
    
//    else
//        stringUrl = [NSString stringWithFormat:@"%@:%@/%@/image",[ModalController  getContforKey:SERVERHOST],[ModalController  getContforKey:SERVERPORT],[ModalController  getContforKey:SERVERVERSION]];
    
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:stringUrl]];
//    
//    request.timeOutSeconds = 50;
//    NSLog(@"%d",[imageData length]);
//    NSLog(@"%f  %f",[imageToUplaod size].width,[imageToUplaod size].height);
//    [request  setPostLength:[imageData  length]];
////    [request setData:imageData forKey:@"image_bstring"];
////    [request setPostValue:[[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding]  forKey:@"image_bstring"];
//    [request setRequestMethod:@"POST"];
//    [request setData:imageData withFileName:@"photo.jpeg" andContentType:@"image/jpg" forKey:@"file"];
//    [request setPostValue:[[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding]  forKey:@"file"]; 
//    
////    NSString *fileName = [NSString stringWithFormat:@"ipodfile%@.jpg",self.fileID];
////    [request addPostValue:fileName forKey:@"name"];
//    
//    // Upload an image
////    NSData *imageData = UIImageJPEGRepresentation([UIImage imageName:fileName])
////    [request setData:imageData withFileName:fileName andContentType:@"image/jpeg" forKey:@"userfile"];
//
//    
//    request.delegate = self;    
//    [request setDidFinishSelector:@selector(topSecretFetchComplete:)];
//    [request setDidFailSelector:@selector(topSecretFetchFailed:)];
//    
//    [request startAsynchronous];

//    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
//    [request setURL:[NSURL URLWithString:URLPOST]];
//    [request setHTTPMethod:@"POST"];
    
    /*
     add some header info now
     we always need a boundary when we post a file
     also we need to set the content type
     
     You might want to generate a random boundary.. this is just the same 
     as my output from wireshark on a valid html post
     */
//    NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//    
//    /*
//     now lets create the body of the post
//     */
//    NSMutableData *body = [NSMutableData data];
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];    
//    [body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"ipodfile.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[NSData dataWithData:imageData]];
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    // setting the body of the post to the reqeust
//    [request setHTTPBody:body];
//    
//    // now lets make the connection to the web
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"%@",returnString);
//
//    NSString *urlString = URLPOST;
//    
//    // setting up the request object now
//    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
//    [request setURL:[NSURL URLWithString:urlString]];
//    [request setHTTPMethod:@"POST"];
//    
//    /*
//     add some header info now
//     we always need a boundary when we post a file
//     also we need to set the content type
//     
//     You might want to generate a random boundary.. this is just the same 
//     as my output from wireshark on a valid html post
//     */
//    NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//    
//    /*
//     now lets create the body of the post
//     */
//    NSMutableData *body = [NSMutableData data];
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];    
//    [body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"ipodfile.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[NSData dataWithData:imageData]];
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    // setting the body of the post to the reqeust
//    [request setHTTPBody:body];
//    
//    // now lets make the connection to the web
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",returnString);
}

//- (UIImage *) image: (UIImage *) image fitInSize: (CGSize) viewsize
//{
//	// calculate the fitted size
//	CGSize size = [TestViewController fitSize:image.size inSize:viewsize];
//	
//	UIGraphicsBeginImageContext(viewsize);
//    
//	float dwidth = (viewsize.width - size.width) / 2.0f;
//	float dheight = (viewsize.height - size.height) / 2.0f;
//	
//    
//	CGRect rect = CGRectMake(dwidth, dheight, size.width, size.height);
//	[image drawInRect:rect];
//	
//    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();  
//	
//    return newimg;  
//}
//
//+ (CGSize) fitSize: (CGSize)thisSize inSize: (CGSize) aSize
//{
//	CGFloat scale;
//	CGSize newsize = thisSize;
//	
//	if (newsize.height && (newsize.height > aSize.height))
//	{
//		scale = aSize.height / newsize.height;
//		newsize.width *= scale;
//		newsize.height *= scale;
//	}
//	
//	if (newsize.width && (newsize.width >= aSize.width))
//	{
//		scale = aSize.width / newsize.width;
//		newsize.width *= scale;
//		newsize.height *= scale;
//	}
//	
//	return newsize;
//}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    // Access the uncropped image from info dictionary
    //    imageViewPick.image  = [self image:image
    //                             fitInSize:CGSizeMake([[ModalController  getContforKey:IMAGEWIDTH]integerValue], [[ModalController  getContforKey:IMAGEHIEGHT]integerValue])];
    
    imageViewPick.image = image;
    
    
    
    [self dismissModalViewControllerAnimated:YES];
    // Save image
    
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

#pragma mark- user defined functions

-(void)getImagesFromPhotoLibrary
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.assetGroups = tempArray;
    [tempArray release];
    
    library = [[ALAssetsLibrary alloc] init];      
    
    // Load Albums into assetGroups
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
                       
                       // Group enumerator Block
                       void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop) 
                       {
                           if (group == nil) 
                           {
                               return;
                           }
                           
                           [self.assetGroups addObject:group];
                           NSLog(@"self.assetGroups =%@",self.assetGroups);
                           // Reload albums
                           [self performSelectorOnMainThread:@selector(goNextViewController) withObject:nil waitUntilDone:YES];
                       };
                       
                       // Group Enumerator Failure Block
                       void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
                           
                           UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Album Error: %@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                           [alert show];
                           [alert release];
                           
                           NSLog(@"A problem occured %@", [error description]);	                                 
                       };	
                       
                       // Enumerate Albums
                       [library enumerateGroupsWithTypes:ALAssetsGroupAll
                                              usingBlock:assetGroupEnumerator 
                                            failureBlock:assetGroupEnumberatorFailure];
                       
                       [pool release];
                   }); 
    
}
//-(void)goNextViewController
//{
//    ELCAssetTablePicker *picker = [[ELCAssetTablePicker alloc] initWithNibName:@"ELCAssetTablePicker" bundle:[NSBundle mainBundle]];
//	picker.parent = self;
//    
//    // Move me    
//    picker.assetGroup = [assetGroups objectAtIndex:0];
//    [picker.assetGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
//
//    [picker getImagesFromPhotoLibrary];
//
//    [self.view  addSubview:picker.view];
//    
////	[self.navigationController pushViewController:picker animated:YES];
////	[picker release];
//}

#pragma mark ELCImagePickerControllerDelegate Methods

//- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
//	NSLog(@"******info=%@",info);
//	
//}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker {
    
	[self dismissModalViewControllerAnimated:YES];
}

@end
