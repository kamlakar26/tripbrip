//
//  HowDetailsViewController.m
//  tripbripapplication
//
//  Created by mac on 10/24/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "HowDetailsViewController.h"
#import "PolicyTableViewCell.h"
#import "HowDetailsTableViewCell.h"
#import "BookWebViewController.h"
#import "SafetyViewController.h"
#import "FAQViewController.h"
@interface HowDetailsViewController ()

@end

@implementation HowDetailsViewController
@synthesize policyarray,tablview;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    self.navigationItem.title=@"How We Work";
    tablview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    policyarray=[[NSArray alloc]initWithObjects:@"Book",@"Safety", nil];
    self.tablview.delegate=self;
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [policyarray count];
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"howdetails";
    
    
    HowDetailsTableViewCell *cell = (HowDetailsTableViewCell *)[tablview dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"howdetails" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    cell.detailslab.text=[policyarray objectAtIndex:indexPath.row];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *selectedIndexPath = [tableView indexPathForSelectedRow];
    
    if(selectedIndexPath.row == 0)
    {
                BookWebViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BookWebViewController"];
                [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    if(selectedIndexPath.row == 1)
    {
                SafetyViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SafetyViewController"];
                [self.navigationController pushViewController:vc animated:YES];
        
        
    }
//    if(selectedIndexPath.row == 2)
//    {
//                FAQViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FAQViewController"];
//                [self.navigationController pushViewController:vc animated:YES];
//        
//        
//    }

    
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
