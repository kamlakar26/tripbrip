//
//  SafetyViewController.m
//  tripbripapplication
//
//  Created by mac on 10/24/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "SafetyViewController.h"

@interface SafetyViewController ()

@end

@implementation SafetyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"Safety";
    NSURL *websiteUrl = [NSURL URLWithString:@"https://www.tripbrip.com/website_api/safety.php"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [_webview1 loadRequest:urlRequest];
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
