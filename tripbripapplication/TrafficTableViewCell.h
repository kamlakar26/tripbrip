//
//  TrafficTableViewCell.h
//  tripbripapplication
//
//  Created by mac on 1/3/17.
//  Copyright © 2017 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrafficTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *trafficimage;
@property (strong, nonatomic) IBOutlet UILabel *trafficname;

@property (strong, nonatomic) IBOutlet UILabel *perkilometer;

@property (strong, nonatomic) IBOutlet UILabel *trafficvehicleseater;
@property (strong, nonatomic) IBOutlet UILabel *totalseaters;
@property (strong, nonatomic) IBOutlet UILabel *typeacornonac;
@property (strong, nonatomic) IBOutlet UILabel *minkmvehicales;
@property (strong, nonatomic) IBOutlet UILabel *includedrivers;
@property (strong, nonatomic) IBOutlet UILabel *wellmaintained;
@property (strong, nonatomic) IBOutlet UILabel *labnonac;
@property (strong, nonatomic) IBOutlet UILabel *labac;
@property (strong, nonatomic) IBOutlet UILabel *nonacperrate;

@end
