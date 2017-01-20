//
//  FillupDetailsViewController.h
//  tripbripapplication
//
//  Created by mac on 10/27/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPGTextField.h"
@interface FillupDetailsViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UISearchDisplayDelegate,UITextFieldDelegate,MPGTextFieldDelegate>
{
     UIPickerView *Unipicker;
    NSMutableArray *data;
     NSMutableArray *data1;
    NSMutableArray *companyData;
     NSMutableArray *companyData1;

}


@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;


@property (weak, nonatomic) IBOutlet MPGTextField *name;

@property (weak, nonatomic) IBOutlet UITextField *useraddress;
@property (weak, nonatomic) IBOutlet UITextField *userpincode;
@property (weak, nonatomic) IBOutlet MPGTextField *placevisite;
@property (weak, nonatomic) IBOutlet UIButton *locationbutton;
@property (weak, nonatomic) IBOutlet UIImageView *locationimage;

@property (weak, nonatomic) IBOutlet UITextField *date;
@property(nonatomic,retain)UIDatePicker *datepicker;
@property(nonatomic,retain)UIDatePicker *datepicker1;
@property (weak, nonatomic) IBOutlet UITextField *timeshow;

@property(nonatomic,retain)NSString *passmodelstring;
@property(nonatomic,retain)NSString *concanatestring;
@property(nonatomic,retain)NSString *passperkms;
@property(nonatomic,retain)NSString *passnightcharges;
@property(nonatomic,retain)NSString *passmodelid;
@property(nonatomic,retain)NSString *passnearpleaces;
@property(nonatomic,retain)NSString *passsperkilomer;
@property(nonatomic,retain)NSString *passsvehicalid;
@property(nonatomic,retain)NSString *passscartype1;



@property(nonatomic,retain)NSString *dropdate;
@property(nonatomic,retain)NSString *time2hours;
@property(nonatomic,retain)NSString *selectdate;


@property(nonatomic,retain)NSString *address1;
@property(nonatomic,retain)NSString *address2;

- (IBAction)BookACarbuttonclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *locationbuttonclick;

- (IBAction)chooseDate:(id)sender;
- (IBAction)choosetime:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *numberofday;
- (IBAction)numberofdayclicks:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *homebutton;
@property (strong, nonatomic) IBOutlet UIButton *officebutton;
- (IBAction)homebuttonclick:(id)sender;
- (IBAction)officebuttonclick:(id)sender;

- (IBAction)tapclick:(id)sender;
@end
