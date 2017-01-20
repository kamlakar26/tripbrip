//
//  PaymentWalletViewController.h
//  tripbripapplication
//
//  Created by mac on 12/26/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "PUUIBaseVC.h"

@interface PaymentWalletViewController : PUUIBaseVC

@property (strong, nonatomic) IBOutlet UILabel *currentbalances;
@property(nonatomic,retain)NSString *passuserid;
@property(nonatomic,retain)NSString *passwattet;
@property(nonatomic,retain)NSString *totalamout;
@end
