//
//  FAQViewController.m
//  tripbripapplication
//
//  Created by mac on 10/24/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "FAQViewController.h"

@interface FAQViewController ()

@end

@implementation FAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imag1.hidden=NO;
    _imag2.hidden=YES;
    _imag3.hidden=YES;
    self.navigationItem.title=@"FAQ'S";
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"faq1-2" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.webview1 loadHTMLString:htmlString baseURL:nil];
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

- (IBAction)segmentctrlclick:(id)sender {
    if(_segmentcontrol.selectedSegmentIndex == 0)
    {
        NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"faq1-2" ofType:@"html"];
        NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
        [self.webview1 loadHTMLString:htmlString baseURL:nil];
        _imag1.hidden=NO;
        _imag2.hidden=YES;
        _imag3.hidden=YES;
        [self.view reloadInputViews];
        //[self upcomingwebservices];
       
        
    }
    else if(_segmentcontrol.selectedSegmentIndex == 1)
    {
        NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"faq2-2" ofType:@"html"];
        NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
        [self.webview1 loadHTMLString:htmlString baseURL:nil];
        _imag2.hidden=NO;
        _imag1.hidden=YES;
        _imag3.hidden=YES;
        [self.view reloadInputViews];

        
    }
    else if(_segmentcontrol.selectedSegmentIndex == 2)
    {
        NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"faq3-2" ofType:@"html"];
        NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
        [self.webview1 loadHTMLString:htmlString baseURL:nil];
        _imag3.hidden=NO;
        _imag1.hidden=YES;
        _imag2.hidden=YES;
        [self.view reloadInputViews];

        
    }

}
@end
