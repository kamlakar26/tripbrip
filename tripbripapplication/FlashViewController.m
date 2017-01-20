//
//  FlashViewController.m
//  tripbripapplication
//
//  Created by mac on 11/16/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "FlashViewController.h"
#import "DBManager.h"
#import "MBProgressHUD.h"
#import "LoginScreenViewController.h"
#import "ViewController.h"
#import "PageContentViewController.h"
#import "DashbordViewController.h"
#import "ViewController.h"
@interface FlashViewController ()
@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSString *statusFromBuyerDB;
@property(nonatomic,retain)NSMutableArray *statusArray;
@end

@implementation FlashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationController.navigationBar setTranslucent:YES];
//    self.navigationController.view.backgroundColor = [UIColor clearColor];
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//    
   // [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self knowStatusForuser];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _statusArray=[[NSMutableArray alloc]init];
            
            if([_statusFromBuyerDB isEqualToString:@"1"])
            {
                DashbordViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DashbordViewController"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([_statusFromBuyerDB isEqualToString:@"0"])
            {
                ViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
                [self.navigationController pushViewController:vc animated:YES];
            }

            [hud hideAnimated:YES];
        });
        
    });


       // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
-(void)knowStatusForuser{
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"trip.sqlite"];
    
    // Check if should load specific record for editing.
    
    NSString *queryav=[NSString stringWithFormat:@"SELECT Satus1,mobileno from Logintable1"];
    [self.dbManager executeQuery:queryav];
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    self.statusArray = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:queryav]];
    _statusFromBuyerDB = [[self.statusArray objectAtIndex:0]objectAtIndex:0];
    NSLog(@"%@",_statusArray);
    NSLog(@"id%@",_statusFromBuyerDB);
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
