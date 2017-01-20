//
//  PageContentViewController.m
//  tripbripapplication
//
//  Created by mac on 10/14/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "PageContentViewController.h"
#import "LoginScreenViewController.h"
#import "DBManager.h"
#import "DashbordViewController.h"
@interface PageContentViewController ()
{
    NSArray *array1;
}

@end

@implementation PageContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    array1=[[NSArray alloc]init];
  //  [self knowStatusForuser];
    
//    _statusArray=[[NSMutableArray alloc]init];
//    
//    if([_statusFromBuyerDB isEqualToString:@"1"])
//    {
//        DashbordViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DashbordViewController"];
//        [self.navigationController pushViewController:vc animated:YES];
   // }

   // _textviewtittle.textAlignment = NSTextAlignmentCenter;
     _gostartbutton.hidden=YES;
    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    self.titleLabel.text = self.titleText;
    self.textviewtittle.text= self.tittletextview;
    self.gostartbutton.titleLabel.text=self.buttonstring;
    [self pageindexmethod];
   }
//-(void)knowStatusForuser{
//    
//    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"trip.sqlite"];
//    
//    // Check if should load specific record for editing.
//    
//    NSString *queryav=[NSString stringWithFormat:@"SELECT Satus1,mobileno from Logintable1"];
//    [self.dbManager executeQuery:queryav];
//    if (self.dbManager.affectedRows != 0) {
//        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
//    }
//    else{
//        NSLog(@"Could not execute the query.");
//    }
//    self.statusArray = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:queryav]];
//    _statusFromBuyerDB = [[self.statusArray objectAtIndex:0]objectAtIndex:0];
//    NSLog(@"%@",_statusArray);
//    NSLog(@"id%@",_statusFromBuyerDB);
//}
-(void)pageindexmethod
{
    if(_pageIndex == 0)
    {
        _gostartbutton.hidden=YES;
        
    }
    if(_pageIndex == 1)
    {
        _gostartbutton.hidden=YES;
        
    }
    if(_pageIndex == 2)
    {
        _gostartbutton.hidden=NO;
        
    }

}
- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([array1 count] == 0) || (index >= [array1 count])) {
        
    }
    if (([array1 count] == 1) || (index >= [array1 count])) {
        
    }
    if (([array1 count] == 3) || (index >= [array1 count])) {
         _gostartbutton.hidden=NO;
    }
    return nil;
    // Create a new view controller and pass suitable data.
   
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

- (IBAction)goapplicationstart:(id)sender {
//       LoginScreenViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginScreenViewController"];
//    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
