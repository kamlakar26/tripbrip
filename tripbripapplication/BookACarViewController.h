//
//  BookACarViewController.h
//  tripbripapplication
//
//  Created by mac on 10/20/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookACarViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tablview;
@property(nonatomic,retain)NSMutableArray *bookaryya;
@property(nonatomic,retain)NSMutableArray *getidarray;
@property(nonatomic,retain)NSMutableArray *profileArray;
@property(nonatomic,retain)NSDictionary *mainarray;
@property(nonatomic,retain)NSString *passstring;
@end
