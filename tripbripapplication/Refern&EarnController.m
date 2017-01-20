//
//  Refern&EarnController.m
//  tripbripapplication
//
//  Created by mac on 11/23/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "Refern&EarnController.h"

@interface Refern_EarnController ()

@end

@implementation Refern_EarnController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"Refer & Earn";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)refernowbuttonclick:(id)sender {
    NSString *refstring=_Referalcodetest.text;
    NSString *textToShare = [NSString stringWithFormat:@"Hey, Here is my TripBrip Referral Code %@.Go on Trip and get Rs.300/-off on your First Trip using TripMoney. Download the TripBrip app Now!",refstring];
    NSURL *myWebsite = [NSURL URLWithString:@"https://play.google.com/store/apps/details?id=com.vincitmedia.tripbrip.app&hl=en"];
    NSLog(@"%@",textToShare);
    
    NSArray *objectsToShare = @[textToShare, myWebsite];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}
@end
