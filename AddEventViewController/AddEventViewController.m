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

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    //  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tableEvent];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
    
    [self  getEvents];
    //	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark - View lifecycle



-(void)AddEvent
{
    
    NewEventViewController *controller = [[NewEventViewController  alloc] init];
    [self.navigationController  pushViewController:controller
                                          animated:YES];
    [controller  release];
//   UIAlertView  *myAlertView = [[UIAlertView alloc] initWithTitle:@"Add Event \n" message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//    myAlertView.tag = 199;
//    myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
//    [myTextField setBackgroundColor:[UIColor whiteColor]];
//    [myAlertView addSubview:myTextField];
//    if(TARGET_IPHONE_SIMULATOR)
//    {
//        myTextField.text=@"";    //f508f9f7227c
//    }
//    [myAlertView show];
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
    
    
    tableEvent.backgroundView  = nil;
    tableEvent.backgroundColor = [UIColor  clearColor];
    
    [self.navigationController.navigationBar  setTintColor:[UIColor  blackColor]];
    [self.navigationItem setTitle:@"Events"];
    
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - tableEvent.bounds.size.height, self.view.frame.size.width, tableEvent.bounds.size.height)];
        view.backgroundColor = [UIColor clearColor];
		view.delegate = self;
		[tableEvent addSubview:view];
		_refreshHeaderView = view;
		[view release];
	}
    
    [self.navigationController setNavigationBarHidden:NO];
    
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Add Event" 
                                                                           style:UIBarButtonItemStyleBordered 
                                                                          target:self
                                                                          action:@selector(AddEvent)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"LogOut" 
                                                                           style:UIBarButtonItemStyleBordered 
                                                                          target:self
                                                                          action:@selector(LogOut)];
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view 
                                              animated:YES];
    hud.labelText = @"Loading...";

    [self getEvents];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)getEvents
{
    isGet = 1;
       
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

      [self doneLoadingTableViewData];
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
        [self doneLoadingTableViewData];
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
    
    EventViewCell *cell = (EventViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BaseCell"];
	if(cell == nil) 
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EventCellView" owner:self options:nil];
        
        cell = (EventViewCell *)[nib objectAtIndex:0];
    }
    
    
    if(indexPath.row%2 == 0)
    cell.contentView.backgroundColor = [UIColor  colorWithRed:(float)33/256 green:(float)33/256  blue:(float)33/256  alpha:1.0];
    else {
        cell.contentView.backgroundColor = [UIColor  colorWithRed:(float)102/256 green:(float)102/256  blue:(float)102/256  alpha:1.0];

    }
    cell.backgroundView = nil;
    
//    cell.textLabel.text = [[arrayEvent  objectAtIndex:indexPath.row] objectForKey:@"event-name"];
//    cell.detailTextLabel.text = [[arrayEvent  objectAtIndex:indexPath.row] objectForKey:@"event-user-name"];
//    cell.textLabel.backgroundColor =[UIColor  clearColor ];
//    cell.detailTextLabel.backgroundColor = [UIColor  clearColor];
//    cell.detailTextLabel.textColor = [UIColor whiteColor];
//    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.lableName.text = [[arrayEvent  objectAtIndex:indexPath.row] objectForKey:@"event-name"];
    cell.lableCreater.text = [[arrayEvent  objectAtIndex:indexPath.row] objectForKey:@"event-user-name"];
    
    cell.imageMain.image = [UIImage imageNamed:@"icon-placeholder.png"];
   
    if([[arrayEvent  objectAtIndex:indexPath.row] objectForKey:@"event-image-path"])
    cell.imageMain.imageURL = [NSURL URLWithString:[[arrayEvent  objectAtIndex:indexPath.row] objectForKey:@"event-image-path"]];
   
    
    cell.lableCreater.backgroundColor = [UIColor  clearColor];
    cell.lableName.backgroundColor = [UIColor  clearColor];

    //    cell.backgroundColor = COLORCELL
	cell.accessoryView = nil;
    cell.accessoryType = UITableViewCellAccessoryNone;
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
    
//    tabBarcont.selectedIndex = 0;
//    [self.navigationController pushViewController:tabBarcont
//                                         animated:YES];
//    

    EventViewController *controller = [[EventViewController  alloc] init];
    controller.stringTitle = [[arrayEvent  objectAtIndex:indexPath.row] objectForKey:@"event-name"];
    [self.navigationController  pushViewController:controller
                                          animated:YES];
    [controller  release];
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
