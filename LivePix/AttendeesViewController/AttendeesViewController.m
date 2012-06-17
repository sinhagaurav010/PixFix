//
//  AttendeesViewController.m
//  LivePix
//
//  Created by Apple on 18/06/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
//

#import "AttendeesViewController.h"

@interface AttendeesViewController ()

@end

@implementation AttendeesViewController

@synthesize tableAttendees;
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
    [self.navigationItem setTitle:@"Attendess"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view 
                                              animated:YES];
    hud.labelText = @"Loading...";

    modal = [[ModalController  alloc] init];
    modal.delegate = self;
    
    NSLog(@"%@",[NSString stringWithFormat:KsURLINVITEDATTEND,[ModalController  getContforKey:KsSELEVENT]]);
    [modal  sendTheRequestWithPostString:nil 
                           withURLString:[NSString stringWithFormat:KsURLINVITEDATTEND,[ModalController  getContforKey:KsSELEVENT]]];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)getdata
{
    [MBProgressHUD  hideHUDForView:self.navigationController.view
                      animated:YES];
    
    NSLog(@"~~~~~~~~~%@",modal.stringRx);
    
    NSDictionary *dictionaryData = [NSDictionary  dictionaryWithDictionary:[XMLReader  dictionaryForXMLData:modal.dataXml
                                                                                                      error:nil]];
    NSLog(@"~~~~~~~~~%@",dictionaryData);

    
    if(![dictionaryData  objectForKey:@"user-events"])
    {
        [ModalController  FuncAlertMsg:@"No one is invited!!!" inController:self];
    }
    else {
        if([[[dictionaryData  objectForKey:@"user-events"] objectForKey:@"events"] isKindOfClass:[NSArray class]])
        {
        arrayAttendees = [[NSMutableArray alloc] initWithArray:[[dictionaryData  objectForKey:@"user-events"] objectForKey:@"events"]];
        }
        else {
            arrayAttendees = [[NSMutableArray alloc]init];
            [arrayAttendees  addObject:[[dictionaryData  objectForKey:@"user-events"] objectForKey:@"events"]];
        }
    }
    [tableAttendees  reloadData];
}

#pragma mark -tableview delegate-

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// The number of sections is based on the number of items in the data property list.
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [arrayAttendees count];	
	
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
        cell.delegate = self;
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
    
//    cell.lableName.text = [[arrayAttendees  objectAtIndex:indexPath.row] objectForKey:@"event-name"];
    cell.lableName.text = [[arrayAttendees  objectAtIndex:indexPath.row] objectForKey:@"event-invite_user"];
    [cell.lableTime  removeFromSuperview];
    [cell.lableCreater  removeFromSuperview];
    [cell.btnDel   removeFromSuperview];
    cell.imageMain.image = [UIImage imageNamed:@"icon-placeholder.png"];
//    cell.lableTime.text = [[arrayEvent  objectAtIndex:indexPath.row] objectForKey:@"event-date"];
//    if([[arrayEvent  objectAtIndex:indexPath.row] objectForKey:@"event-image-path"])
//        cell.imageMain.imageURL = [NSURL URLWithString:[[arrayEvent  objectAtIndex:indexPath.row] objectForKey:@"event-image-path"]];
    
    
    cell.lableCreater.backgroundColor = [UIColor  clearColor];
    cell.lableName.backgroundColor = [UIColor  clearColor];
//    if(![[[arrayEvent  objectAtIndex:indexPath.row] objectForKey:@"event-user"] isEqualToString:[ModalController  getContforKey:KsSAVEDLOGGEDIN]])
//    {   
//        [cell.btnDel  removeFromSuperview];
//    }
//    else {
//        cell.btnDel.tag = indexPath.row;
//    }
    //    cell.backgroundColor = COLORCELL
	cell.accessoryView = nil;
//    cell.accessoryType = UITableViewCellAccessoryNone;
    return (EventViewCell  *)cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
//    [ModalController  saveTheContent:[[arrayEvent  objectAtIndex:indexPath.row ] objectForKey:@"event-id"] 
//                             withKey:KsSELEVENT];
//    //    tabBarcont = [[UITabBarController alloc] init];
//    //    
//    //    UINavigationController *navigation
//    //    EventViewController *controllerEvent = [[EventViewController  alloc] init];
//    //    UploadViewController *controlllerUpload = [[UploadViewController   alloc] init];
//    //    
//    //    [tabBarcont setViewControllers:
//    //     [NSArray arrayWithObjects:controllerEvent, controlllerUpload, nil]];
//    
//    //    tabBarcont.selectedIndex = 0;
//    //    [self.navigationController pushViewController:tabBarcont
//    //                                         animated:YES];
//    //    
//    
//    EventViewController *controller = [[EventViewController  alloc] init];
//    controller.stringTitle = [[arrayEvent  objectAtIndex:indexPath.row] objectForKey:@"event-name"];
//    [self.navigationController  pushViewController:controller
//                                          animated:YES];
//    [controller  release];
}


-(void)getError
{
    [MBProgressHUD  hideHUDForView:self.navigationController.view
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
