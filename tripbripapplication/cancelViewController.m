//
//  cancelViewController.m
//  tripbripapplication
//
//  Created by mac on 11/13/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "cancelViewController.h"
#import "LiveViewController.h"
#import "completedViewController.h"
#import "UILabel+UILabel_dynamicSizeMe.h"
@interface cancelViewController ()

@end

@implementation cancelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=[NSString stringWithFormat:@"Booking ID %@",_passbookid];
    [self.pickupaddlab resizeToFit];
    self.titlelab.text=_passtittle;
    self.labbookingid.text=_passbookid;
    self.vehicallab.text=_passvehicalmodel;
    self.pickupaddlab.text=_passaddress;
    self.locatioinlab.text=_passlocation;
    self.pincodelab.text=_passpincode;
    self.pickdatelab.text=_passpickdate;
    self.picktimelab.text=_passpicktime;
    self.dropdatelab.text=_passdropdate;
    self.droptimelab.text=_passdroptime;
    
    NSString *datestring2=_passpickdate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
    NSDate *date = [formatter dateFromString:datestring2];
    [formatter setDateFormat:@"dd'-'MM'-'yyyy'"];
    NSString *newDate = [formatter stringFromDate:date];
    _formatstring = [NSString stringWithFormat:@"%@",newDate];
    
    NSString *datestring3=_passpickdate;
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
    NSDate *date1 = [formatter1 dateFromString:datestring3];
    [formatter setDateFormat:@"dd'-'MM'-'yyyy'"];
    NSString *newDate1 = [formatter1 stringFromDate:date1];
    _formatstring = [NSString stringWithFormat:@"%@",newDate1];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
