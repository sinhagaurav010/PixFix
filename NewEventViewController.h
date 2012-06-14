//
//  NewEventViewController.h
//  LivePix
//
//  Created by Apple on 12/06/12.
//  Copyright (c)  . All rights reserved.
//

#import <UIKit/UIKit.h>  
#import "MBProgressHUD.h"
#import "ModalController.h"
#import "XMLReader.h"
#import "CustomDatePickerView.h"
@interface NewEventViewController : UIViewController<ModalDelegate,cutomDelegate>
{
    CustomDatePickerView *datePicker;

    ModalController *modal;
     IBOutlet UIButton *buttonDate;
}
-(IBAction)clickForDate:(id)sender;
-(IBAction)backKEypad:(id)sender;

@property(retain)IBOutlet UILabel *labelDate;
@property(retain)IBOutlet UITextField *viewDesc;
@property(retain)IBOutlet UITextField *fieldName;
@end
