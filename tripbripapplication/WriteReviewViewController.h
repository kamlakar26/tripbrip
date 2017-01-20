//
//  WriteReviewViewController.h
//  tripbripapplication
//
//  Created by mac on 11/28/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDStarRating.h"
@interface WriteReviewViewController : UIViewController<EDStarRatingProtocol,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *placeimage;
@property (weak, nonatomic) IBOutlet UIButton *writereviewbuttonclick;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UILabel *aleartlab;
@property (weak, nonatomic) IBOutlet UILabel *aleartlab2;
@property (weak, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet EDStarRating *starRating;
@property (weak, nonatomic) IBOutlet UILabel *starRatingLabel;
@property (weak, nonatomic) IBOutlet UITextView *usertextreview;

@property(nonatomic,retain)NSString *passimagestring;
@property(nonatomic,retain)NSString *passimageid;

@property(nonatomic,retain)NSString *string1;
@property(nonatomic,retain)NSString *passplasestring;

- (IBAction)submitreviewbuttonclick:(id)sender;
- (IBAction)backtoratingbuttonclick:(id)sender;

- (IBAction)writereviewbuttonclick:(id)sender;
- (IBAction)tapclick:(id)sender;

- (IBAction)backbuttonclick:(id)sender;
- (IBAction)nextbuttonclick:(id)sender;


@end
