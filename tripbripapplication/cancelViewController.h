//
//  cancelViewController.h
//  tripbripapplication
//
//  Created by mac on 11/13/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cancelViewController : UIViewController
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

@property(nonatomic,retain)NSString *formatstring;
@property(nonatomic,retain)NSString *formatstring1;

@end
