//
//  BreakupViewController.m
//  tripbripapplication
//
//  Created by mac on 11/10/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "BreakupViewController.h"
#import "CarBookViewController.h"
@interface BreakupViewController ()
{
    int totalsub;
}
@end

@implementation BreakupViewController
@synthesize basefare,servicestax,swachhtax,krishitax,nighchargelab;
- (void)viewDidLoad {
    [super viewDidLoad];
   
if([_passdiscount isEqualToString:@"0"])
    {
        if([_labdic.text isEqualToString:@"₹(null)"])
        {
                  }
        
        NSString *string = [NSString stringWithFormat:@"%@",_passbasefare];
        int value = [string intValue];
        
        NSString *str4=[NSString stringWithFormat:@"%@",_passnumberofdayssss];
        int noofdays=[str4 intValue];
        
        
        NSString *string1=[NSString stringWithFormat:@"%@",_perkm];
        
        int value1 = [string1 intValue];
        
        int value3 = value1 * noofdays;
        
        int value33 = value3 * value;
        
        
        NSString *string3=[NSString stringWithFormat:@"₹%d * %dKms = %d",value,value3,value33];
        
        NSString *string11=@"583";
        int value11 = [string11 intValue];
        
        int allowances = value11 *noofdays;
        nighchargelab.text=[NSString stringWithFormat:@"₹%d",allowances];
        
        
        NSString *str=[NSString stringWithFormat:@"%@",_passnightchargess];
        int nighvalue=[str intValue];
        NSLog(@"%@ddd",str);
        NSString *dic=[NSString stringWithFormat:@"%@",_passdiscount];
        int dicmin=[dic intValue];
        
        NSString *str1=[NSString stringWithFormat:@"%@",_passtripmoney];
        int tripmoney=[str1 intValue];
        
        if(tripmoney == 0)
        {
            totalsub= value33 + allowances - tripmoney-dicmin;
        }
        else if (tripmoney >= 1500)
        {
            totalsub= value33 + allowances - 1500-dicmin;
        }
        else{
            totalsub= value33 + allowances - tripmoney-dicmin;
            
        }
        
        NSString *night=[NSString stringWithFormat:@"%@",_passnightchargess];
        int value5 = [night intValue];
        NSString *driver=@"333";
        int value6 = [driver intValue];
        
        
        int finaldayallo=value11-value6;
        
        
        int dayallo = finaldayallo * noofdays;
        
        int allocation=value6 * noofdays;
        
        _dayallowance.text=[NSString stringWithFormat:@"₹%d",dayallo];
        NSLog(@"%ddayyy",dayallo);
        
        _allowancecharges.text=[NSString stringWithFormat:@"₹%d",allocation];
        NSLog(@"%ddayyy",allocation);
        
        if([_vehicleidcheck isEqualToString:@"5"]||[_vehicleidcheck isEqualToString:@"6"])
        {
            
            NSString *string11=@"633";
            int value11 = [string11 intValue];
            
            int allowances = value11 *noofdays;
            nighchargelab.text=[NSString stringWithFormat:@"₹%d",allowances];
            
            
            
            NSString *driver=@"300";
            int value7 = [driver intValue];
            int dayallo = value7 * noofdays;
            
            int allocation=value6 * noofdays;
            
            _dayallowance.text=[NSString stringWithFormat:@"₹%d",dayallo];
            NSLog(@"%ddayyy",dayallo);
            
            _allowancecharges.text=[NSString stringWithFormat:@"₹%d",allocation];
            NSLog(@"%ddayyy",allocation);
            
        }
        
        float services= totalsub * 5.6/100;
        float swatch = totalsub * 0.20/100;
        float krich = totalsub * 0.20/100;
        NSString *servicestax1=[NSString stringWithFormat:@"₹%.02f",services];
        NSString *swatchstring=[NSString stringWithFormat:@"₹%.02f",swatch];
        NSString *krichstring=[NSString stringWithFormat:@"₹%.02f",krich];
        
        
        
        //nighchargelab.text=[NSString stringWithFormat:@"₹%@",_passnightchargess];;
        basefare.text=string3;
        servicestax.text=servicestax1;
        swachhtax.text=swatchstring;
        krishitax.text=krichstring;
        _labdic.text=[NSString stringWithFormat:@"%@",_passdiscount];
        _labtripmone.text=[NSString stringWithFormat:@"₹%@",_passtripmoney];

    }else
    {
        
        
        
        
        NSString *string = [NSString stringWithFormat:@"%@",_passbasefare];
        int value = [string intValue];
       
        NSString *str4=[NSString stringWithFormat:@"%@",_passnumberofdayssss];
        int noofdays=[str4 intValue];

        
        NSString *string1=[NSString stringWithFormat:@"%@",_perkm];
        
        int value1 = [string1 intValue];
        
        int value3 = value1 * noofdays;
        
        int value33 = value3 * value;
        
        
        NSString *string3=[NSString stringWithFormat:@"₹%d * %dKms = %d",value,value3,value33];
        
        NSString *string11=@"583";
        int value11 = [string11 intValue];
        
        int allowances = value11 *noofdays;
        nighchargelab.text=[NSString stringWithFormat:@"₹%d",allowances];
        
        
        NSString *str=[NSString stringWithFormat:@"%@",_passnightchargess];
        int nighvalue=[str intValue];
        NSLog(@"%@ddd",str);
        NSString *dic=[NSString stringWithFormat:@"%@",_passdiscount];
        int dicmin=[dic intValue];
        
        NSString *str1=[NSString stringWithFormat:@"%@",_passtripmoney];
        int tripmoney=[str1 intValue];
        
        if(tripmoney == 0)
        {
            totalsub= value33 + allowances - tripmoney-dicmin;
        }
        else if (tripmoney >= 1500)
        {
            totalsub= value33 + allowances - 1500-dicmin;
        }
        else{
            totalsub= value33 + allowances - tripmoney-dicmin;
            
        }
        
        NSString *night=[NSString stringWithFormat:@"%@",_passnightchargess];
        int value5 = [night intValue];
        NSString *driver=@"333";
        int value6 = [driver intValue];
        
        
        int finaldayallo=value11-value6;
        
        
        int dayallo = finaldayallo * noofdays;
        
        int allocation=value6 * noofdays;
        
        _dayallowance.text=[NSString stringWithFormat:@"₹%d",dayallo];
        NSLog(@"%ddayyy",dayallo);

        _allowancecharges.text=[NSString stringWithFormat:@"₹%d",allocation];
        NSLog(@"%ddayyy",allocation);
       
        if([_vehicleidcheck isEqualToString:@"5"]||[_vehicleidcheck isEqualToString:@"6"])
        {
            
            NSString *string11=@"633";
            int value11 = [string11 intValue];
            
            int allowances = value11 *noofdays;
            nighchargelab.text=[NSString stringWithFormat:@"₹%d",allowances];
            
            
            
            NSString *driver=@"300";
            int value7 = [driver intValue];
            int dayallo = value7 * noofdays;
            
            int allocation=value6 * noofdays;
            
            _dayallowance.text=[NSString stringWithFormat:@"₹%d",dayallo];
            NSLog(@"%ddayyy",dayallo);
            
            _allowancecharges.text=[NSString stringWithFormat:@"₹%d",allocation];
            NSLog(@"%ddayyy",allocation);
            
        }

        float services= totalsub * 5.6/100;
        float swatch = totalsub * 0.20/100;
        float krich = totalsub * 0.20/100;
        NSString *servicestax1=[NSString stringWithFormat:@"₹%.02f",services];
        NSString *swatchstring=[NSString stringWithFormat:@"₹%.02f",swatch];
        NSString *krichstring=[NSString stringWithFormat:@"₹%.02f",krich];
        
        
        
//nighchargelab.text=[NSString stringWithFormat:@"₹%@",_passnightchargess];;
        basefare.text=string3;
        servicestax.text=servicestax1;
        swachhtax.text=swatchstring;
        krishitax.text=krichstring;
        _labdic.text=[NSString stringWithFormat:@"%@",_passdiscount];
        _labtripmone.text=[NSString stringWithFormat:@"₹%@",_passtripmoney];
        
        
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

@end
