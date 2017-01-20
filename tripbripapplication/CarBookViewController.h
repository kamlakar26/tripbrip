//
//  CarBookViewController.h
//  tripbripapplication
//
//  Created by mac on 11/10/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarBookViewController : UIViewController
@property(nonatomic,retain)NSString *modelstring;
@property(nonatomic,retain)NSString *registerTypeString;
@property(nonatomic,retain)NSString *registerTypeString1;
@property(nonatomic,retain)NSMutableArray *statusArray;
@property(nonatomic,retain)NSString *passjouneydate;
@property(nonatomic,retain)NSString *passDropdate;
@property(nonatomic,retain)NSString *passpickuptime;
@property(nonatomic,retain)NSString *passdroptime;
@property(nonatomic,retain)NSString *passnumdays;
@property(nonatomic,retain)NSString *passaddress;
@property(nonatomic,retain)NSString *passplacetovisit;
@property(nonatomic,retain)NSString *passfarevehicle;
@property(nonatomic,retain)NSString *passnight;
@property(nonatomic,retain)NSString *pperkimlomer;
@property(nonatomic,retain)NSString *vehicleid;

@property (weak, nonatomic) IBOutlet UIView *subview;
@property (weak, nonatomic) IBOutlet UILabel *labdiscout;
@property (weak, nonatomic) IBOutlet UIScrollView *scrllview;

@property (weak, nonatomic) IBOutlet UITextView *address;

@property (weak, nonatomic) IBOutlet UILabel *labmodel;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIButton *applypromobutton;

@property (weak, nonatomic) IBOutlet UILabel *usercontactno;
@property (weak, nonatomic) IBOutlet UILabel *journeydate;
@property (weak, nonatomic) IBOutlet UILabel *dropdate;
@property (weak, nonatomic) IBOutlet UILabel *pickuptime;
@property (weak, nonatomic) IBOutlet UILabel *droptime;
@property (weak, nonatomic) IBOutlet UILabel *numofdays;
@property (weak, nonatomic) IBOutlet UILabel *placetovisit;
@property (weak, nonatomic) IBOutlet UILabel *farevehicle;
@property (weak, nonatomic) IBOutlet UILabel *minkms;
@property (weak, nonatomic) IBOutlet UILabel *estimatedfare;

@property (weak, nonatomic) IBOutlet UILabel *estimate2;
@property (weak, nonatomic) IBOutlet UITextField *promocodetext;
@property (weak, nonatomic) IBOutlet UILabel *prolab;
@property (weak, nonatomic) IBOutlet UILabel *labtripmoney;
@property (weak, nonatomic) IBOutlet UILabel *labdic;
@property (weak, nonatomic) IBOutlet UILabel *labfare;
@property (weak, nonatomic) IBOutlet UILabel *labtrip;
@property (weak, nonatomic) IBOutlet UIButton *successsbutton;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UILabel *cartype;

- (IBAction)successbuttonclick:(id)sender;


@property(nonatomic,retain)NSDictionary *promodictionary;
@property(nonatomic,retain)NSMutableArray *promoarray;

@property(nonatomic,retain)NSMutableArray *userarray;
@property(nonatomic,retain)NSString *userid;
@property(nonatomic,retain)NSString *modelid;
@property(nonatomic,retain)NSString *passpincode;
@property(nonatomic,retain)NSString *passlocation;
@property(nonatomic,retain)NSString *passaddress1;
@property(nonatomic,retain)NSString *bookingid;
@property(nonatomic,retain)NSString *PCartype;


@property(nonatomic,retain)NSString *datestring;
@property(nonatomic,retain)NSString *datestring1;

- (IBAction)applypromocodebuttonclick:(id)sender;
- (IBAction)breakupamontclick:(id)sender;
- (IBAction)bookbuttonclick:(id)sender;

- (IBAction)tapclick:(id)sender;


@end
