//
//  BreakviewdetailsViewController.h
//  tripbripapplication
//
//  Created by mac on 11/14/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BreakviewdetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *servicetaxlab;

@property (weak, nonatomic) IBOutlet UILabel *swachhtaxlab;

@property (weak, nonatomic) IBOutlet UILabel *krishitaxlab;

@property(nonatomic,retain)NSString *passservietax;
@property(nonatomic,retain)NSString *passswacctax;
@property(nonatomic,retain)NSString *passkrishitax;

@end
