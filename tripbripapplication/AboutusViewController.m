//
//  AboutusViewController.m
//  tripbripapplication
//
//  Created by mac on 12/8/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "AboutusViewController.h"

@interface AboutusViewController ()

@end

@implementation AboutusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"About us";
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"book" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.webview loadHTMLString:htmlString baseURL:nil];
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
