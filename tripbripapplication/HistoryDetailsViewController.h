//
//  HistoryDetailsViewController.h
//  tripbripapplication
//
//  Created by mac on 10/24/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tablview;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentcontroller;
@property (weak, nonatomic) IBOutlet UIImageView *imag1;
@property (weak, nonatomic) IBOutlet UIImageView *imag2;
@property (weak, nonatomic) IBOutlet UIImageView *imag3;
@property (weak, nonatomic) IBOutlet UIImageView *imag4;




@property(nonatomic,retain)NSArray *historyarray;

@property(nonatomic,retain)NSDictionary *upcomingdictionary;
@property(nonatomic,retain)NSMutableArray *upcomingArray;
@property(nonatomic,retain)NSMutableArray *livearray;
@property(nonatomic,retain)NSMutableArray *completeArray;
@property(nonatomic,retain)NSMutableArray *cancelArray;

@property(nonatomic,retain)NSMutableArray *userarray;
@property(nonatomic,retain)NSString *userid;
@property(nonatomic,retain)NSString *bookid;
@property(nonatomic,retain)NSString *vehicleModelId;
@property(nonatomic,retain)NSString *noOfDays;
@property(nonatomic,retain)NSString *placeToVisit;
@property(nonatomic,retain)NSString *dateOfJourney;
@property(nonatomic,retain)NSString *endOfJourney;
@property(nonatomic,retain)NSString *pickupTime;
@property(nonatomic,retain)NSString *vehicleId;
@property(nonatomic,retain)NSString *pickupAddress;
@property(nonatomic,retain)NSString *location;
@property(nonatomic,retain)NSString *pincode;

@property(nonatomic,retain)NSMutableArray *profileArray;

@property(nonatomic,retain)NSString *datestring;
@property(nonatomic,retain)NSString *datestring1;
@property(nonatomic,retain)NSString *dropstring;
@property(nonatomic,retain)NSString *pickstring;

- (IBAction)segmentctrclick:(id)sender;

@end
