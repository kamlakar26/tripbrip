//
//  BreakviewdetailsViewController.m
//  tripbripapplication
//
//  Created by mac on 11/14/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "BreakviewdetailsViewController.h"

@interface BreakviewdetailsViewController ()

@end

@implementation BreakviewdetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.servicetaxlab.text=[NSString stringWithFormat:@"₹%@",_passservietax];
     self.swachhtaxlab.text=[NSString stringWithFormat:@"₹%@",_passswacctax];
     self.krishitaxlab.text=[NSString stringWithFormat:@"₹%@",_passkrishitax];
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
