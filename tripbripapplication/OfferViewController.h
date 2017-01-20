//
//  OfferViewController.h
//  tripbripapplication
//
//  Created by mac on 10/17/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)NSDictionary *offerdictionary;
@property(nonatomic,retain)NSArray *offerarray;

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@end
