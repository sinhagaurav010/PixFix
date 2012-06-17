//
//  InviteFriendViewControllerViewController.m
//  LivePix
//
//  Created by Apple on 16/06/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
//

#import "InviteFriendViewControllerViewController.h"

static UINib *cellNib;

@interface InviteFriendViewControllerViewController ()

@end


@implementation InviteFriendViewControllerViewController
@synthesize inviteFriendDict,stringEventId,tableView,arrayContacts,cellinvited;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



//+ (void)initialize
//{
//    if(self == [ImageManager class]) {
//        cellNib = [UINib nibWithNibName:@"ImageManagerCell" bundle:nil];
//        assert(cellNib);
//    }
//}

-(void)Invite
{

    NSMutableArray *arryEmai  =  [[NSMutableArray  alloc] init] ;
    for(int i=0;i<[arrayContacts  count];i++)
    {
        if([[[arrayContacts  objectAtIndex:i] objectForKey:@"status"] isEqualToString:@"y"])
        {
            [arryEmai addObject:[[arrayContacts  objectAtIndex:i] objectForKey:@"Email"]];
        }
    }
    arrayRec = [NSArray arrayWithArray:arryEmai];
    MFMailComposeViewController *mcvc = [[[MFMailComposeViewController alloc] init] autorelease];
    mcvc.mailComposeDelegate = self;
    [mcvc setSubject:@"invited for PixLive"];
    [mcvc setToRecipients:arrayRec];
    
    [self presentModalViewController:mcvc animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    if(result == MFMailComposeResultSent)
    {
        NSLog(@"~~~~~~~~~%@",[NSString  stringWithFormat:KsURLINVITATION,[ModalController getContforKey:KsSELEVENT],[ModalController  getContforKey:KsSAVEDLOGGEDIN ],[arrayRec  componentsJoinedByString:@","]]);
        
        
        modal = [[ModalController  alloc] init];
        modal.delegate = self;
        [modal  sendTheRequestWithPostString:nil withURLString:[NSString  stringWithFormat:KsURLINVITATION,[ModalController getContforKey:KsSELEVENT],[ModalController  getContforKey:KsSAVEDLOGGEDIN ],[arrayRec  componentsJoinedByString:@","]]];
    }
	[self dismissModalViewControllerAnimated:YES];
}

-(void)getdata
{
    NSLog(@"~~~~~~%@",modal.stringRx);
    
    if([modal.stringRx  isEqualToString:@"Invited successfully"])
    {
        [ModalController  FuncAlertMsg:@"Invited successfully" inController:self];
    }
    else {
        [ModalController  FuncAlertMsg:@"Invited failed" inController:self];

    }
}

-(void)getError
{

}
- (void)viewDidLoad
{
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Invite" 
                                                                        style:UIBarButtonItemStyleBordered 
                                                                       target:self
                                                                       action:@selector(Invite)];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// The number of sections is based on the number of items in the data property list.
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [arrayContacts count];	
	
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	
	// Retrieve or create a cell
	
    
//    InviteTableViewCellCell *cell = (InviteTableViewCellCell *)[tableView dequeueReusableCellWithIdentifier:@"InviteTableViewCell"];
    
//    if (cell != nil)
//        return cell;
//    
//	if(cell == nil) 
//    {
//        UIViewController* c = [[UIViewController alloc] initWithNibName:@"InviteTableViewCell" bundle:nil];
//        cell = (InviteTableViewCellCell *)c.view;
//        
//        [cell setBttnWithTag:indexPath.row];
//
//    }
    
//    InviteTableViewCellCell *cell = (InviteTableViewCellCell*)[tableView dequeueReusableCellWithIdentifier:@"InviteTableViewCell"];
//    
//    if (!cell) {
//        
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InviteTableViewCell" 
//                                                     owner:self
//                                                   options:nil];        
//        cell = (InviteTableViewCellCell *)[nib objectAtIndex:0];
//        
//
//        [cell  setBttnWithTag:indexPath.row];
//    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseCell"];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:@"BaseCell"] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

//    if(indexPath.row%2 == 0)
//        cell.contentView.backgroundColor = [UIColor  colorWithRed:(float)33/256 green:(float)33/256  blue:(float)33/256  alpha:1.0];
//    else {
//        cell.contentView.backgroundColor = [UIColor  colorWithRed:(float)102/256 green:(float)102/256  blue:(float)102/256  alpha:1.0];
//    }
    cell.backgroundView = nil;
    
    //    cell.textLabel.text = [[arrayEvent  objectAtIndex:indexPath.row] objectForKey:@"event-name"];
    //    cell.detailTextLabel.text = [[arrayEvent  objectAtIndex:indexPath.row] objectForKey:@"event-user-name"];
    //    cell.textLabel.backgroundColor =[UIColor  clearColor ];
    //    cell.detailTextLabel.backgroundColor = [UIColor  clearColor];
    //    cell.detailTextLabel.textColor = [UIColor whiteColor];
    //    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.textLabel.text = [[arrayContacts  objectAtIndex:indexPath.row] objectForKey:@"FName"];
    cell.imageView.image = [UIImage imageNamed:@"icon-placeholder.png"];
    if([[arrayContacts  objectAtIndex:indexPath.row] objectForKey:@"Email"])
     cell.detailTextLabel.text = [[arrayContacts  objectAtIndex:indexPath.row] objectForKey:@"Email"];
    else {
        cell.detailTextLabel.text = @"N.A";
    }
    
    if([[arrayContacts  objectAtIndex:indexPath.row] objectForKey:@"image"])
    cell.imageView.image = [[arrayContacts  objectAtIndex:indexPath.row] objectForKey:@"image"];
    
    
//    if([[arrayEvent  objectAtIndex:indexPath.row] objectForKey:@"event-image-path"])
//        cell.imageMain.imageURL = [NSURL URLWithString:[[arrayEvent  objectAtIndex:indexPath.row] objectForKey:@"event-image-path"]];
//    
//    
//    cell.lableCreater.backgroundColor = [UIColor  clearColor];
//    cell.lableName.backgroundColor = [UIColor  clearColor];
//    if(![[[arrayEvent  objectAtIndex:indexPath.row] objectForKey:@"event-user"] isEqualToString:[ModalController  getContforKey:KsSAVEDLOGGEDIN]])
//    {   
//        [cell.btnDel  removeFromSuperview];
//    }
//    else {
//        cell.btnDel.tag = indexPath.row;
//    }
    //    cell.backgroundColor = COLORCELL
    
    
	cell.accessoryView = nil;
    
    if([[[arrayContacts  objectAtIndex:indexPath.row] objectForKey:@"status"] isEqualToString:@"n"])
    cell.accessoryType = UITableViewCellAccessoryNone;
    else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;

    }
    return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = [tableView  cellForRowAtIndexPath:indexPath];
    
    if([[[arrayContacts  objectAtIndex:indexPath.row] objectForKey:@"status"] isEqualToString:@"n"])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        NSMutableDictionary *dictCon = [arrayContacts  objectAtIndex:indexPath.row];
        [dictCon  setObject:@"y" forKey:@"status"];
        
        [arrayContacts  replaceObjectAtIndex:indexPath.row withObject:dictCon];
        
    
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        NSMutableDictionary *dictCon = [arrayContacts  objectAtIndex:indexPath.row];
        [dictCon  setObject:@"n" forKey:@"status"];
        
        [arrayContacts  replaceObjectAtIndex:indexPath.row withObject:dictCon];
        
    }
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
