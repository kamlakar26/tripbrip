//
//  ModalTableViewCell.h
//  tripbripapplication
//
//  Created by mac on 10/27/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModalTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *modelnamelab;

@property (weak, nonatomic) IBOutlet UIImageView *modelimage;

@property (strong, nonatomic) IBOutlet UILabel *modelperkm;
@property (strong, nonatomic) IBOutlet UIButton *acbutton;

@property (strong, nonatomic) IBOutlet UIButton *nonacbutton;
@property (strong, nonatomic) IBOutlet UIButton *acperrate;
@property (strong, nonatomic) IBOutlet UIButton *nonacperrate;
@property (strong, nonatomic) IBOutlet UIButton *ACBUTTON;
@property (strong, nonatomic) IBOutlet UILabel *labac;

@end
