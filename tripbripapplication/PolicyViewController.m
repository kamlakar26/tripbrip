//
//  PolicyViewController.m
//  tripbripapplication
//
//  Created by mac on 10/17/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "PolicyViewController.h"
#import "PolicyTableViewCell.h"
#import "FacepolicyViewController.h"
#import "PrivacyPolicyViewController.h"
@interface PolicyViewController ()

@end

@implementation PolicyViewController
@synthesize policyarray;
- (void)viewDidLoad {
    [super viewDidLoad];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    _tablview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    policyarray=[[NSArray alloc]initWithObjects:@"Fare Policy",@"Privacy Policy", nil];
    self.tablview.delegate=self;
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [policyarray count];
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"policycell";
    
    
    PolicyTableViewCell *cell = (PolicyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"policycell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    cell.policylab.text=[policyarray objectAtIndex:indexPath.row];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *selectedIndexPath = [tableView indexPathForSelectedRow];
    
    if(selectedIndexPath.row == 0)
    {
        FacepolicyViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FacepolicyViewController"];
        [self.navigationController pushViewController:vc animated:YES];

        
    }
    if(selectedIndexPath.row == 1)
    {
        PrivacyPolicyViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PrivacyPolicyViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        
        
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

@end
