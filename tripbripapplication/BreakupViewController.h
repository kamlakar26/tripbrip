//
//  BreakupViewController.h
//  tripbripapplication
//
//  Created by mac on 11/10/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BreakupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *basefare;
@property (weak, nonatomic) IBOutlet UILabel *servicestax;
@property (weak, nonatomic) IBOutlet UILabel *swachhtax;
@property (weak, nonatomic) IBOutlet UILabel *krishitax;
@property (weak, nonatomic) IBOutlet UILabel *nighchargelab;
@property (weak, nonatomic) IBOutlet UILabel *labdic;
@property (weak, nonatomic) IBOutlet UILabel *labtripmone;

@property(nonatomic,retain)NSString *passnightchargess;
@property(nonatomic,retain)NSString *passbasefare;
@property(nonatomic,retain)NSString *passdiscount;
@property(nonatomic,retain)NSString *passzero;
@property(nonatomic,retain)NSString *passtripmoney;
@property(nonatomic,retain)NSString *passnumberofdayssss;
@property(nonatomic,retain)NSString *perkm;
@property(nonatomic,retain)NSString *vehicleidcheck;

@property (strong, nonatomic) IBOutlet UILabel *dayallowance;
@property (strong, nonatomic) IBOutlet UILabel *allowancecharges;

@end
