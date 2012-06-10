//
//  AddEventViewController.m
//  LivePix
//
//  Created by preet dhillon on 10/06/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
//

#import "AddEventViewController.h"

@implementation AddEventViewController
@synthesize arrayEvent;

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

#pragma mark - View lifecycle


-(void)AddEvent
{
    
 
    
   UIAlertView  *myAlertView = [[UIAlertView alloc] initWithTitle:@"Add Event \n" message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    myAlertView.tag = 199;
    myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    [myTextField setBackgroundColor:[UIColor whiteColor]];
    [myAlertView addSubview:myTextField];
    if(TARGET_IPHONE_SIMULATOR)
    {
        myTextField.text=@"";    //f508f9f7227c
    }
    [myAlertView show];
//    [modal sendTheRequestWithPostString:nil withURLString:[NSString stringWithFormat:@"%@%@&email=%@",KsURLSIGNUP,[result  objectForKey:@"name"],[result  objectForKey:@"email"]]];
//
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag ==  199)
    if(buttonIndex ==1)
    {
        isGet  = 0;
        
        
        if([myTextField.text length]>0)
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.labelText = @"Loading...";

            [modal  sendTheRequestWithPostString:nil 
                                   withURLString:[NSString stringWithFormat:@"%@%@&user_email=%@",KsURLADDEVENT,myTextField.text,[ModalController   getContforKey:KsSAVEDLOGGEDIN]]];
        }
        else
            [ModalController  FuncAlertMsg:@"Please Enter Name" 
                              inController:self];
    }   
}

-(void)LogOut
{
    SplashScreenController *controller = [[SplashScreenController     alloc] init];
    [self.navigationController  pushViewController:controller
                                          animated:YES];
    [ModalController  removeContentForKey:KsSAVEDLOGGEDIN];
    [controller  release];
    


}


- (void)viewDidLoad
{
    [self.navigationController.navigationBar  setTintColor:[UIColor  blackColor]];
    
    
    [self.navigationController setNavigationBarHidden:NO];
    
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Add Event" 
                                                                           style:UIBarButtonItemStyleBordered 
                                                                          target:self
                                                                          action:@selector(AddEvent)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"LogOut" 
                                                                           style:UIBarButtonItemStyleBordered 
                                                                          target:self
                                                                          action:@selector(LogOut)];

    
   
    [self getEvents];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)getEvents
{
    isGet = 1;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"Loading...";
    
    modal = [[ModalController  alloc] init];
    modal.delegate = self;
    [modal  sendTheRequestWithPostString:nil withURLString:KsALLEVENT];
}
-(void)getdata
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
//    [ModalController  saveTheContent:self.loginUser
//                             withKey:KsSAVEDLOGGEDIN];
//    AddEventViewController *controller = [[AddEventViewController  alloc] init];
//    [self.navigationController  pushViewController:controller
//                                          animated:YES];

    
    NSLog(@"%@",modal.stringRx);
    
    if(isGet == 1)
    {
    NSDictionary *_xmlDictionaryData = [[XMLReader dictionaryForXMLData:[modal dataXml] 
                                                                  error:nil] retain];
    NSLog(@"%@",_xmlDictionaryData);
    
    if([[[_xmlDictionaryData objectForKey:@"user-events"] objectForKey:@"events"] isKindOfClass:[NSArray  class]])
    {
        arrayEvent = [[NSMutableArray  alloc] initWithArray:[[_xmlDictionaryData objectForKey:@"user-events"] objectForKey:@"events"]];
    
    }
    else
    {
        arrayEvent = [[NSMutableArray  alloc] init];
        [arrayEvent addObject:[[_xmlDictionaryData objectForKey:@"user-events"] objectForKey:@"events"] ];
    }

    [tableEvent  reloadData];
    }
    else
    {
        NSLog(@"%@",modal.stringRx);
    
        [self getEvents];
    }
}

-(void)getError
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    [ModalController FuncAlertMsg:@"Error in network!!!"
                     inController:self];
}

#pragma mark -tableview delegate-

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// The number of sections is based on the number of items in the data property list.
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [arrayEvent count];	
	
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	
	// Retrieve or create a cell
	/*UITableViewCellStyle style =  UITableViewCellStyleDefault;
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseCell"];
     if (!cell)
     {
     cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"] autorelease];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     }
	 
	 */
	
    //	ListCell *cell = (ListCell *)[tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    //	if (!cell) 
    //	{
    //        NSLog(@"heres");
    //        //cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListCell"];
    //		cell = [[[NSBundle mainBundle] loadNibNamed:@"ListCell" owner:self options:nil] lastObject] ;
    //		cell.backgroundColor=[UIColor whiteColor];
    //		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //        
    //        
    //        cell.costLabel.text = [NSString stringWithFormat:@"$%@",[[arrayList objectAtIndex:indexPath.row] objectForKey:FIELDCOST]];
    //        cell.venueNameLabel.text = [[arrayList objectAtIndex:indexPath.row] objectForKey:FIELDNAME];
    //        cell.dealLabel.text = [[arrayList objectAtIndex:indexPath.row] objectForKey:FIELDDEAL];
    //        cell.distanceLabel.text = [NSString stringWithFormat:@"%.3fKm",[ModalController  calDistancebetWithLat:[locationUser.strUserLat doubleValue] with:[locationUser.strUserLong doubleValue] with:[[[arrayList objectAtIndex:indexPath.row ]objectForKey:@"Lat"]doubleValue] with:[[[arrayList objectAtIndex:indexPath.row ]objectForKey:@"Long"]doubleValue]]];
    ////        
    //       cell.imageMain.imageURL = [NSURL URLWithString:[[[[arrayList objectAtIndex:indexPath.row]objectForKey:FIELDIMAGES]objectForKey:FIELDIMAGE]objectAtIndex:0]];
    //	}
    //	
    
    //    CustomTableCell *cell = (CustomTableCell *)[tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BaseCell"];
	if(cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"BaseCell"] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [[arrayEvent  objectAtIndex:indexPath.row] objectForKey:@"event-name"];
    cell.detailTextLabel.text = [[arrayEvent  objectAtIndex:indexPath.row] objectForKey:@"event-user"];
    //    cell.backgroundColor = COLORCELL
	
    return (UITableViewCell *)cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    [ModalController  saveTheContent:[[arrayEvent  objectAtIndex:indexPath.row ] objectForKey:@"event-id"] 
                             withKey:KsSELEVENT];
//    tabBarcont = [[UITabBarController alloc] init];
//    
//    UINavigationController *navigation
//    EventViewController *controllerEvent = [[EventViewController  alloc] init];
//    UploadViewController *controlllerUpload = [[UploadViewController   alloc] init];
//    
//    [tabBarcont setViewControllers:
//     [NSArray arrayWithObjects:controllerEvent, controlllerUpload, nil]];
    
    tabBarcont.selectedIndex = 0;
    [self.navigationController pushViewController:tabBarcont
                                         animated:YES];
    
    
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
