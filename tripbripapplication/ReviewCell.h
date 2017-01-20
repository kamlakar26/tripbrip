//
//  ReviewCell.h
//  tripbripapplication
//
//  Created by mac on 11/28/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernamecell;
@property (weak, nonatomic) IBOutlet UITextView *reviewcell;
@property (weak, nonatomic) IBOutlet UIButton *buttonreview;

@end
