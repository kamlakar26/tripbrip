//
//  TraficViewController.h
//  tripbripapplication
//
//  Created by mac on 10/17/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TraficViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentcontrol;
@property (weak, nonatomic) IBOutlet UIImageView *imag1;
@property (weak, nonatomic) IBOutlet UIImageView *imag2;
@property (weak, nonatomic) IBOutlet UIImageView *imag3;
@property (weak, nonatomic) IBOutlet UIImageView *imag4;
@property (strong, nonatomic) IBOutlet UIWebView *webview;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,retain)NSDictionary *trafficdictionary;
@property(nonatomic,retain)NSMutableArray *emonomicalarrya;
@property(nonatomic,retain)NSMutableArray *sedanarray;
@property(nonatomic,retain)NSMutableArray *largearrya;
@property(nonatomic,retain)NSMutableArray *luxaryarrya;
@property(nonatomic,retain)NSMutableArray *travellers;

@property(nonatomic,retain)NSMutableArray *bus;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollview1;

- (IBAction)segmentbuttonclick:(id)sender;



@end
