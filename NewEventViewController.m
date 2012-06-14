//
//  NewEventViewController.m
//  LivePix
//
//  Created by Apple on 12/06/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
//

#import "NewEventViewController.h"

@interface NewEventViewController ()

@end

@implementation NewEventViewController
@synthesize labelDate,fieldName,viewDesc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)backKEypad:(id)sender
{
    [fieldName  resignFirstResponder];
    [viewDesc  resignFirstResponder];
}

-(void)AddEvent
{ 
    NSLog(@"%@",modal.stringRx);
    if([fieldName.text length]>0)
    {
        [fieldName  resignFirstResponder];
        [viewDesc  resignFirstResponder];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.labelText = @"Loading...";
        modal = [[ModalController  alloc] init];
        modal.delegate = self;
        [modal  sendTheRequestWithPostString:nil 
                               withURLString:[NSString stringWithFormat:KsURLADDEVENT,fieldName.text,[ModalController  getContforKey:KsSAVEDLOGGEDIN],viewDesc.text,buttonDate.titleLabel.text]];
    }
    else 
    {
        [ModalController  FuncAlertMsg:@"Event Name is mandatory" inController:self];
    }
}
-(void)getError
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    [ModalController FuncAlertMsg:@"Error in network!!!"
                     inController:self];
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
    
    NSDictionary *_xmlDictionaryData = [[XMLReader dictionaryForXMLData:[modal dataXml] 
                                                                  error:nil] retain];
    
    [self.navigationController  popViewControllerAnimated:YES];
    NSLog(@"%@",_xmlDictionaryData);
    
}

-(void)pressDone:(NSString *)dateString
{
    buttonDate.titleLabel.text = dateString;
    datePicker.hidden = YES;
}
-(IBAction)clickForDate:(id)sender
{
    datePicker.hidden = NO;
}

- (void)viewDidLoad
{
    datePicker = [[CustomDatePickerView alloc] initWithFrame:CGRectMake(0, 120, 320, 194)];
    //datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.client = self;
    
    [self.view addSubview:datePicker];
    
    //    [datePicker addTarget:self 
    //                   action:@selector(DateOfBirth) 
    //         forControlEvents:UIControlEventValueChanged];
    datePicker.hidden = YES;
    
    
    self.navigationItem.title = @"Add Event";
    NSDateFormatter *weekday = [[NSDateFormatter alloc] init];
    
    
    [weekday setDateFormat: @"yyyy-MM-dd"];
    
//    labelDate.text = [NSString stringWithFormat:@"%@",[NSString  stringWithFormat:@"%@",[weekday  stringFromDate:[NSDate date]]]];

    
    buttonDate.titleLabel.text =  [NSString stringWithFormat:@"%@",[NSString  stringWithFormat:@"%@",[weekday  stringFromDate:[NSDate date]]]];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Add Event" 
                                                                           style:UIBarButtonItemStyleBordered 
                                                                          target:self
                                                                          action:@selector(AddEvent)];
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
