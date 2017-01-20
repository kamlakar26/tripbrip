//
//  HowWeWorkViewController.m
//  tripbripapplication
//
//  Created by mac on 10/17/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "HowWeWorkViewController.h"
#import "PolicyTableViewCell.h"
#import "HowDetailsViewController.h"
#import "TraficViewController.h"
#import "ContacUsViewController.h"
#import "AboutusViewController.h"
#import "OfferViewController.h"
@interface HowWeWorkViewController ()

@end

@implementation HowWeWorkViewController
@synthesize policyarray,tablview;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.title=@"ABOUT US";
    tablview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    policyarray=[[NSArray alloc]initWithObjects:@"HOW WE WORK",@"TARIFF DETAILS",@"CONTACT US",@"ABOUT US",@"OFFERS", nil];
    self.tablview.delegate=self;
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [policyarray count];
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"contactcell";
    
    
    PolicyTableViewCell *cell = (PolicyTableViewCell *)[tablview dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"contactcell" owner:self options:nil];
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
        HowDetailsViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HowDetailsViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    if(selectedIndexPath.row == 1)
    {
        TraficViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TraficViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    if(selectedIndexPath.row == 2)
    {
                ContacUsViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ContacUsViewController"];
                [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    if(selectedIndexPath.row == 3)
    {
        ContacUsViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutusViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    if(selectedIndexPath.row == 4)
    {
        OfferViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OfferViewController"];
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
