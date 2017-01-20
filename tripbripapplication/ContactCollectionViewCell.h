//
//  ContactCollectionViewCell.h
//  tripbripapplication
//
//  Created by mac on 1/5/17.
//  Copyright © 2017 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *citycell;
@property (strong, nonatomic) IBOutlet UIImageView *carimage;
@property (strong, nonatomic) IBOutlet UILabel *pickdate;
@property (strong, nonatomic) IBOutlet UILabel *picktime;
@property (strong, nonatomic) IBOutlet UILabel *dropdate;
@property (strong, nonatomic) IBOutlet UILabel *droptime;
@property (strong, nonatomic) IBOutlet UILabel *satus;
@property (strong, nonatomic) IBOutlet UITextView *placevitisit;

@property (strong, nonatomic) IBOutlet UILabel *bookid;
@end
