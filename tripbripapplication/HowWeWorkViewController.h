//
//  HowWeWorkViewController.h
//  tripbripapplication
//
//  Created by mac on 10/17/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HowWeWorkViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tablview;
@property(nonatomic,retain)NSArray *policyarray;

@end
