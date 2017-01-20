//
//  UpcomingViewController.h
//  tripbripapplication
//
//  Created by mac on 11/12/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpcomingViewController : UIViewController
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

@property (strong, nonatomic) IBOutlet UILabel *basefare;
@property (strong, nonatomic) IBOutlet UILabel *basefarelab;
@property (strong, nonatomic) IBOutlet UILabel *advancelab;
@property (strong, nonatomic) IBOutlet UILabel *advancepaid;
@property (strong, nonatomic) IBOutlet UILabel *minkmlab;
@property (strong, nonatomic) IBOutlet UILabel *minkm;
@property (strong, nonatomic) IBOutlet UILabel *duepaymentlab;
@property (strong, nonatomic) IBOutlet UILabel *duepayment;
@property (strong, nonatomic) IBOutlet UILabel *dicountlab;
@property (strong, nonatomic) IBOutlet UILabel *discount;
@property (strong, nonatomic) IBOutlet UIView *view1;

@property(nonatomic,retain)NSString *passtittle;
@property(nonatomic,retain)NSString *passbookid;
@property(nonatomic,retain)NSString *passvehicalmodel;
@property(nonatomic,retain)NSString *passaddress;
@property(nonatomic,retain)NSString *passlocation;
@property(nonatomic,retain)NSString *passpincode;
@property(nonatomic,retain)NSString *passpickdate;
@property(nonatomic,retain)NSString *passpicktime;
@property(nonatomic,retain)NSString *passdropdate;
@property(nonatomic,retain)NSString *passdroptime;

@property(nonatomic,retain)NSString *passbooktype;
@property(nonatomic,retain)NSString *passbookbasefare;
@property(nonatomic,retain)NSString *passbookadvancpaid;
@property(nonatomic,retain)NSString *passbookminkm;
@property(nonatomic,retain)NSString *passbookduepayment;
@property(nonatomic,retain)NSString *passbookdiscount;

@property(nonatomic,retain)NSString *formatstring;
@property(nonatomic,retain)NSString *formatstring1;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

//@property(nonatomic,retain)NSString *passbookid;
//@property(nonatomic,retain)NSString *passbookid;
//@property(nonatomic,retain)NSString *passbookid;
//@property(nonatomic,retain)NSString *passbookid;
//@property(nonatomic,retain)NSString *passbookid;


@property(nonatomic,retain)NSMutableArray *dataArray;
- (IBAction)phonecall:(id)sender;
- (IBAction)cancelbookbuttonclick:(id)sender;
- (IBAction)backbuttonclick:(id)sender;












@end
