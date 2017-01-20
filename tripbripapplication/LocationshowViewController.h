//
//  LocationshowViewController.h
//  tripbripapplication
//
//  Created by mac on 12/3/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
//#import <GooglePlaces/GooglePlaces.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@protocol tutorialDelegate
-(void)delegatesDescribedWithDescription:(NSString *)description address:(NSString *)description2;
@end

@interface LocationshowViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,GMSMapViewDelegate>



@property (weak, nonatomic) id tutorialDelegate;

@property (weak, nonatomic) IBOutlet GMSMapView *mkmapview;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITextView *address;
@property (weak, nonatomic) IBOutlet UIImageView *pinimageview;
- (IBAction)Locationpickbuttonclick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *view1;

- (IBAction)NOButtonclick:(id)sender;
- (IBAction)HomeButtonclick:(id)sender;
- (IBAction)OfficeButtonclick:(id)sender;


@end
