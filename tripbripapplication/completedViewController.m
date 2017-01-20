//
//  completedViewController.m
//  tripbripapplication
//
//  Created by mac on 11/13/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "completedViewController.h"
#import "LiveViewController.h"
#import "cancelViewController.h"
#import "BreakviewdetailsViewController.h"
@interface completedViewController ()

@end

@implementation completedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [_scrollview setShowsVerticalScrollIndicator:NO];
    self.navigationItem.title=[NSString stringWithFormat:@"Booking ID %@",_passbookid2];

    
    NSString *string1 = [NSString stringWithFormat:@"%@",_passservicelab];
    int value = [string1 intValue];
    
    NSString *string2 = [NSString stringWithFormat:@"%@",_passswatchh];
    float value1 = [string2 floatValue];
    
    NSString *string3 = [NSString stringWithFormat:@"%@",_passkrishtax];
    float value2 = [string3 floatValue];
    
    
    int totaltax = value+value1+value2;
    NSString *string4 = [NSString stringWithFormat:@"%d",totaltax];
    
    
    
     self.scrollview.contentSize =CGSizeMake(_scrollview.bounds.size.width, 900);
    self.titlelab.text=_passtittle2;
    self.labbookingid.text=_passbookid2;
    self.vehicallab.text=_passvehicalmodel2;
    self.pickupaddlab.text=_passaddress2;
    self.locatioinlab.text=_passlocation2;
    self.pincodelab.text=_passpincode2;
    self.pickdatelab.text=_passpickdate2;
    self.picktimelab.text=_passpicktime2;
    self.dropdatelab.text=_passdropdate2;
    self.droptimelab.text=_passdroptime2;
    self.Basefarelab.text=[NSString stringWithFormat:@"₹%@",_passbasefare];
    self.nighchargeslab.text=[NSString stringWithFormat:@"₹%@",_passnightcharges];
    self.servicetaxlab.text=[NSString stringWithFormat:@"₹%@",string4];

    self.totalfarelab.text=[NSString stringWithFormat:@"₹%@",_passtotalfare];
     self.labtripmoney.text=[NSString stringWithFormat:@"₹%@",_passstrip];
     self.labdiscount.text=[NSString stringWithFormat:@"₹%@",_passdiscount];
    self.labrefulcharges.text=[NSString stringWithFormat:@"₹%@",_passrefullcharge];
    
    NSString *datestring2=_passpickdate2;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
    NSDate *date = [formatter dateFromString:datestring2];
    [formatter setDateFormat:@"dd'-'MM'-'yyyy'"];
    NSString *newDate = [formatter stringFromDate:date];
    _formatstring = [NSString stringWithFormat:@"%@",newDate];
    
    NSString *datestring3=_passpickdate2;
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
    NSDate *date1 = [formatter1 dateFromString:datestring3];
    [formatter setDateFormat:@"dd'-'MM'-'yyyy'"];
    NSString *newDate1 = [formatter1 stringFromDate:date1];
    _formatstring = [NSString stringWithFormat:@"%@",newDate1];
    // Do any additional setup after loading the view.
    
   // _basefare.text=_passbookbasefare;
    _advancepaid.text=[NSString stringWithFormat:@"₹%@",_passbookadvancpaid];
    //_minkm.text=_passbookminkm;
    //_duepayment.text=_passbookduepayment;
    _discount.text=[NSString stringWithFormat:@"₹%@",_passbookdiscount];
    _totalreading.text=[NSString stringWithFormat:@"%@Km",_passbooktotalreading];
    _latecharges.text=[NSString stringWithFormat:@"₹%@",_passbooklatecharges];
    _totaltax.text=[NSString stringWithFormat:@"₹%@",string4];

    
    if([_passbooktype isEqualToString:@"0"])
    {
        _view1.hidden=NO;
        _night.hidden=YES;
        _nighchargeslab.hidden=YES;
        
    }else if([_passbooktype isEqualToString:@"1"])
    {
        _view1.hidden=YES;
        
    }
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

- (IBAction)segmentctrlclick:(id)sender {
   
}
- (IBAction)breaktaxamountclick:(id)sender {
    
    BreakviewdetailsViewController *destViewController= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BreakviewdetailsViewController"];
    destViewController.passservietax=_passservicelab;
    destViewController.passswacctax=_passswatchh;
    destViewController.passkrishitax=_passkrishtax;
    
      [self.navigationController pushViewController:destViewController animated:YES];
}
- (IBAction)paymentbuttonclick:(id)sender {
}
@end
