//
//  ViewController.m
//  tripbripapplication
//
//  Created by mac on 10/14/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "ViewController.h"
#import "LoginScreenViewController.h"
#import "DBManager.h"
#import "DashbordViewController.h"
#import "PageContentViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
@interface ViewController ()
@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSString *statusFromBuyerDB;
@property(nonatomic,retain)NSMutableArray *statusArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello"
                                                            message:@"There IS NO internet connection !!"
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil, nil];
        //alertView.tag = tag;
        [alertView show];
        NSLog(@"There IS NO internet connection");
    } else {
        NSLog(@"There IS internet connection");
    }
    //[self knowStatusForuser];
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//    
//    
//    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            _statusArray=[[NSMutableArray alloc]init];
//            
//            if([_statusFromBuyerDB isEqualToString:@"1"])
//            {
//                DashbordViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DashbordViewController"];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//            [hud hideAnimated:YES];
//        });
//        
//    });

    
   
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor greenColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    pageControl.backgroundColor = [UIColor whiteColor];

    _pageTitles = @[@"Outing On Demand", @"RIDE For Every Trip", @"All In One"];
    _pageImages = @[@"1.city.png", @"2.cars.png", @"3.app.png"];
    _pagetextviewtittle=@[@"Need an Adventure, want to enjoy your vacation, Then let's go..!!",@"Travel with Family or Friends. Do not worry about space. Choose from variety of cars.",@"Don't worry about anything in Trip. We are with you in every moment of Trip. Book your Trip NOW."];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    // Do any additional setup after loading the view, typically from a nib.
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







- (IBAction)startWalkthrough:(id)sender {
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.tittletextview=self.pagetextviewtittle[index];
    pageContentViewController.buttonstring=_string;
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        NSLog(@"oooo%lu",(unsigned long)index);
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        
        
        
        NSLog(@"jojoi%lu",(unsigned long)index);
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
