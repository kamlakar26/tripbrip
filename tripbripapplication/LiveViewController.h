//
//  LiveViewController.h
//  tripbripapplication
//
//  Created by mac on 11/13/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentctrl;
- (IBAction)segmentctrlclick:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property(nonatomic,retain)NSArray *historyarray;

@property(nonatomic,retain)NSDictionary *upcomingdictionary;
@property(nonatomic,retain)NSMutableArray *upcomingArray;

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





@end
