//
//  completedViewController.h
//  tripbripapplication
//
//  Created by mac on 11/13/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface completedViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titlelab;

@property (weak, nonatomic) IBOutlet UILabel *labbookingid;
@property (weak, nonatomic) IBOutlet UILabel *vehicallab;
@property (weak, nonatomic) IBOutlet UILabel *pickupaddlab;
@property (weak, nonatomic) IBOutlet UITextView *locatioinlab;
@property (weak, nonatomic) IBOutlet UILabel *pincodelab;
@property (weak, nonatomic) IBOutlet UILabel *pickdatelab;
@property (weak, nonatomic) IBOutlet UILabel *picktimelab;
@property (weak, nonatomic) IBOutlet UILabel *dropdatelab;
@property (weak, nonatomic) IBOutlet UILabel *droptimelab;
@property (weak, nonatomic) IBOutlet UILabel *Basefarelab;
@property (weak, nonatomic) IBOutlet UILabel *nighchargeslab;
@property (weak, nonatomic) IBOutlet UILabel *servicetaxlab;
@property (weak, nonatomic) IBOutlet UILabel *labtripmoney;
@property (weak, nonatomic) IBOutlet UILabel *labdiscount;

@property (weak, nonatomic) IBOutlet UILabel *totalfarelab;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UILabel *labrefulcharges;
@property (strong, nonatomic) IBOutlet UILabel *night;



@property(nonatomic,retain)NSString *passtittle2;
@property(nonatomic,retain)NSString *passbookid2;
@property(nonatomic,retain)NSString *passvehicalmodel2;
@property(nonatomic,retain)NSString *passaddress2;
@property(nonatomic,retain)NSString *passlocation2;
@property(nonatomic,retain)NSString *passpincode2;
@property(nonatomic,retain)NSString *passpickdate2;
@property(nonatomic,retain)NSString *passpicktime2;
@property(nonatomic,retain)NSString *passdropdate2;
@property(nonatomic,retain)NSString *passdroptime2;
@property(nonatomic,retain)NSString *passbasefare;
@property(nonatomic,retain)NSString *passnightcharges;
@property(nonatomic,retain)NSString *passservicelab;
@property(nonatomic,retain)NSString *passtotalfare;
@property(nonatomic,retain)NSString *passswatchh;
@property(nonatomic,retain)NSString *passkrishtax;
@property(nonatomic,retain)NSString *passstrip;
@property(nonatomic,retain)NSString *passdiscount;
@property(nonatomic,retain)NSString *passrefullcharge;


@property(nonatomic,retain)NSString *formatstring;
@property(nonatomic,retain)NSString *formatstring1;

@property(nonatomic,retain)NSString *passbooktype;
@property(nonatomic,retain)NSString *passbookbasefare;
@property(nonatomic,retain)NSString *passbookadvancpaid;
@property(nonatomic,retain)NSString *passbookminkm;
@property(nonatomic,retain)NSString *passbookduepayment;
@property(nonatomic,retain)NSString *passbookdiscount;
@property(nonatomic,retain)NSString *passbooklatecharges;
@property(nonatomic,retain)NSString *passbooktotalreading;


@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UILabel *totalreadinglab;
@property (strong, nonatomic) IBOutlet UILabel *totalreading;
@property (strong, nonatomic) IBOutlet UILabel *advancepaidlab;
@property (strong, nonatomic) IBOutlet UILabel *advancepaid;
@property (strong, nonatomic) IBOutlet UILabel *latechargeslab;
@property (strong, nonatomic) IBOutlet UILabel *latecharges;
@property (strong, nonatomic) IBOutlet UILabel *discountamountlab;
@property (strong, nonatomic) IBOutlet UILabel *discount;
@property (strong, nonatomic) IBOutlet UILabel *totaltaxlab;

@property (strong, nonatomic) IBOutlet UILabel *totaltax;



- (IBAction)breaktaxamountclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *phonecallbuttonclick;
- (IBAction)paymentbuttonclick:(id)sender;




@end
