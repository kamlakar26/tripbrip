//
//  LiveDetailsViewController.h
//  tripbripapplication
//
//  Created by mac on 11/13/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *tittlelab;
@property (weak, nonatomic) IBOutlet UILabel *bookidlab;

@property (weak, nonatomic) IBOutlet UILabel *vehiclelab;
@property (weak, nonatomic) IBOutlet UILabel *drivenamelab;
@property (weak, nonatomic) IBOutlet UILabel *contactlab;

@property (weak, nonatomic) IBOutlet UILabel *pickaddlab;
@property (weak, nonatomic) IBOutlet UILabel *pincodelab;
@property (weak, nonatomic) IBOutlet UILabel *pickdatelab;

@property (weak, nonatomic) IBOutlet UILabel *picktimelab;
@property (weak, nonatomic) IBOutlet UILabel *dropdatelab;
@property (weak, nonatomic) IBOutlet UILabel *droptimelab;

@property(nonatomic,retain)NSString *passtittle1;
@property(nonatomic,retain)NSString *passbookid1;
@property(nonatomic,retain)NSString *passvehicalmodel1;
@property(nonatomic,retain)NSString *passaddress1;
@property(nonatomic,retain)NSString *passlocation1;
@property(nonatomic,retain)NSString *passpincode1;
@property(nonatomic,retain)NSString *passpickdate1;
@property(nonatomic,retain)NSString *passpicktime1;
@property(nonatomic,retain)NSString *passdropdate1;
@property(nonatomic,retain)NSString *passdroptime1;
@property(nonatomic,retain)NSString *passdrivername1;
@property(nonatomic,retain)NSString *passdrivercontact1;

@property(nonatomic,retain)NSString *formatstring;
@property(nonatomic,retain)NSString *formatstring1;

@property(nonatomic,retain)NSString *passbooktype;
@property(nonatomic,retain)NSString *passbookbasefare;
@property(nonatomic,retain)NSString *passbookadvancpaid;
@property(nonatomic,retain)NSString *passbookminkm;
@property(nonatomic,retain)NSString *passbookduepayment;
@property(nonatomic,retain)NSString *passbookdiscount;

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
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

- (IBAction)phonecall:(id)sender;



@end
