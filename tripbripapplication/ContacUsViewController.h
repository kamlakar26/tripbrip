//
//  ContacUsViewController.h
//  tripbripapplication
//
//  Created by mac on 10/17/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContacUsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    int selectindex;
}
@property (weak, nonatomic) IBOutlet UIWebView *webview1;

- (IBAction)safetybuttonclick:(id)sender;
- (IBAction)billingbuttonclick:(id)sender;
- (IBAction)billinginfobuttonclick:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,retain)NSMutableArray *array1;
@property(nonatomic,retain)NSMutableArray *array2;
@property(nonatomic,retain)NSMutableArray *array3;
@property(nonatomic,retain)NSDictionary *contdictinary;
@end
