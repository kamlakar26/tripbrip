//
//  LiveDetailsViewController.m
//  tripbripapplication
//
//  Created by mac on 11/13/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "LiveDetailsViewController.h"
#import "UILabel+UILabel_dynamicSizeMe.h"
@interface LiveDetailsViewController ()

@end

@implementation LiveDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_scrollview setShowsVerticalScrollIndicator:NO];
//    CGRect contentRect = CGRectZero;
//    for (UIView *view in self.scrollview.subviews) {
//        contentRect = CGRectUnion(contentRect, view.frame);
//    }
//    self.scrollview.contentSize = contentRect.size;
     self.scrollview.contentSize =CGSizeMake(_scrollview.bounds.size.width, 700);
    self.navigationItem.title=[NSString stringWithFormat:@"Booking ID %@",_passbookid1];
    [self.pickaddlab resizeToFit];
    self.tittlelab.text=_passtittle1;
    self.bookidlab.text=_passbookid1;
    self.vehiclelab.text=_passvehicalmodel1;
    self.pickaddlab.text=_passaddress1;
    
    self.pincodelab.text=_passpincode1;
    self.pickdatelab.text=_passpickdate1;
    self.picktimelab.text=_passpicktime1;
    self.dropdatelab.text=_passdropdate1;
    self.droptimelab.text=_passdroptime1;
    self.drivenamelab.text=_passdrivername1;
    self.contactlab.text=_passdrivercontact1;
    
    
    NSString *datestring2=_passpickdate1;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
    NSDate *date = [formatter dateFromString:datestring2];
    [formatter setDateFormat:@"dd'-'MM'-'yyyy'"];
    NSString *newDate = [formatter stringFromDate:date];
    _formatstring = [NSString stringWithFormat:@"%@",newDate];
    
    NSString *datestring3=_passpickdate1;
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
    NSDate *date1 = [formatter1 dateFromString:datestring3];
    [formatter setDateFormat:@"dd'-'MM'-'yyyy'"];
    NSString *newDate1 = [formatter1 stringFromDate:date1];
    _formatstring = [NSString stringWithFormat:@"%@",newDate1];
    
    
    _basefare.text=_passbookbasefare;
    _advancepaid.text=_passbookadvancpaid;
    _minkm.text=_passbookminkm;
    _duepayment.text=_passbookduepayment;
    _discount.text=_passbookdiscount;
    if([_basefare.text isEqualToString:@"0"])
    {
        _basefare.hidden=YES;
        _basefarelab.hidden=YES;
    }
    if([_advancepaid.text isEqualToString:@"0"])
    {
        _advancepaid.hidden=YES;
        _advancelab.hidden=YES;
    }
    if([_minkm.text isEqualToString:@"0"])
    {
        _minkm.hidden=YES;
        _minkmlab.hidden=YES;
    }
    if([_duepayment.text isEqualToString:@"0"])
    {
        _duepayment.hidden=YES;
        _duepaymentlab.hidden=YES;
    }
    if([_discount.text isEqualToString:@"0"])
    {
        _discount.hidden=YES;
        _dicountlab.hidden=YES;
    }

    
    if([_passbooktype isEqualToString:@"0"])
    {
        _view1.hidden=NO;
        
    }else if([_passbooktype isEqualToString:@"1"])
    {
        _view1.hidden=YES;
        
    }

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

- (IBAction)phonecall:(id)sender {
}
@end
