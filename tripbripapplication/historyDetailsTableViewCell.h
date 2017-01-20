//
//  historyDetailsTableViewCell.h
//  tripbripapplication
//
//  Created by mac on 10/24/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface historyDetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *historylab;
@property (weak, nonatomic) IBOutlet UILabel *stuslab;

@property (weak, nonatomic) IBOutlet UILabel *placecell;
@property (weak, nonatomic) IBOutlet UIImageView *imagecell;
@property (weak, nonatomic) IBOutlet UILabel *bookidcell;
@property (weak, nonatomic) IBOutlet UILabel *tripcell;
@property (weak, nonatomic) IBOutlet UILabel *totaldaycell;
@property (weak, nonatomic) IBOutlet UILabel *enddatecell;
@property (weak, nonatomic) IBOutlet UILabel *picktimecell;

@property (weak, nonatomic) IBOutlet UILabel *droptimecell;

@property (weak, nonatomic) IBOutlet UILabel *basefarecell;
@property (weak, nonatomic) IBOutlet UILabel *nighcell;

@property (weak, nonatomic) IBOutlet UILabel *servicecell;
@property (weak, nonatomic) IBOutlet UILabel *totalamontcell;
@property (weak, nonatomic) IBOutlet UILabel *swachhcell;
@property (weak, nonatomic) IBOutlet UILabel *krichcell;

@property (strong, nonatomic) IBOutlet UILabel *sepecialreqlab;
@property (strong, nonatomic) IBOutlet UILabel *specialbookid;

@property (strong, nonatomic) IBOutlet UILabel *advancepaymetlab;
@property (strong, nonatomic) IBOutlet UILabel *paymentstutslab;

@property (strong, nonatomic) IBOutlet UILabel *booklab;
@property (strong, nonatomic) IBOutlet UILabel *totaldaylab;



@end
