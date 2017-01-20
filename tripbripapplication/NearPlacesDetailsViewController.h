//
//  NearPlacesDetailsViewController.h
//  tripbripapplication
//
//  Created by mac on 10/22/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDStarRating.h"
@interface NearPlacesDetailsViewController : UIViewController<EDStarRatingProtocol>
@property (weak, nonatomic) IBOutlet UIButton *ratingbutton;

@property (weak, nonatomic) IBOutlet UIImageView *imageplaces;
@property (weak, nonatomic) IBOutlet UILabel *placelab;

@property (weak, nonatomic) IBOutlet UITextView *descriptionlab;
@property (weak, nonatomic) IBOutlet UILabel *alertlab;

@property (weak, nonatomic) IBOutlet UITextView *visitelab;
@property (weak, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;
@property (weak, nonatomic) IBOutlet UITextView *routelab;

@property(nonatomic,retain)NSDictionary *mainArray;
@property(nonatomic,retain)NSArray *imagearray1;

@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)NSString *recipeName;
@property (weak, nonatomic) IBOutlet UIButton *reviewbutton;
@property (weak, nonatomic) IBOutlet UIButton *booktripbutton;

@property(nonatomic,retain)NSString *string1;
@property(nonatomic,retain)NSString *imageid;

- (IBAction)Rating:(id)sender;
- (IBAction)okbuttonclick:(id)sender;
- (IBAction)reviewbuttonclick:(id)sender;
- (IBAction)booktripbuttonclick:(id)sender;

- (IBAction)asmelater:(id)sender;
@end
