//
//  NearPlacePuneViewController.h
//  tripbripapplication
//
//  Created by mac on 10/20/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearPlacePuneViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,retain)NSArray *imagearray;
@property(nonatomic,retain)NSMutableArray *imagearray1;
@property(nonatomic,retain)NSMutableArray *profileArray;
@property(nonatomic,retain)NSMutableArray *SearchArray;
@property(nonatomic,retain)NSDictionary *mainArray;
@property(nonatomic,retain)NSURL *str1;
@property(nonatomic,retain)NSString *globalstring;
@property(nonatomic,retain)UILabel *descrip;


@property(nonatomic,retain)NSString *passbutton1;






@end
