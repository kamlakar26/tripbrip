//
//  LocationshowViewController.m
//  tripbripapplication
//
//  Created by mac on 12/3/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "LocationshowViewController.h"
#import "FillupDetailsViewController.h"
#import "DBManager.h"
@interface LocationshowViewController ()
{
    CLLocationManager *locationManager;
}
@property(nonatomic,retain)NSString *str1;
@property(nonatomic,retain)NSString *str2;
@property(nonatomic,retain)NSString *str3;
@property(nonatomic,retain)NSString *userid;
@property(nonatomic,retain)NSString *Address;
@property(nonatomic,retain)NSArray *userarray;
@property (nonatomic, strong) DBManager *dbManager;
@property(nonatomic,retain)NSArray *addressarray;
@property(nonatomic,retain)NSDictionary *addressdictionary;

@end

@implementation LocationshowViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.mkmapview addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    _view1.hidden=YES;
    [self selectUserID];
    self.navigationItem.title=@"Location";

    UITapGestureRecognizer *tapGesture= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
    [self.view addGestureRecognizer:tapGesture];
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    locationManager.delegate = self;
    self.mkmapview.settings.myLocationButton = YES;
    _mkmapview.myLocationEnabled=YES;
    
    _mkmapview.delegate = self;
    

   
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = newBackButton;

   
   // self.mymap=mapview;
       // Do any additional setup after loading the view.
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"myLocation"]) {
        // Animate map to current location (This will run every time user location updates!
        [self.mkmapview animateToLocation: self.mkmapview.myLocation.coordinate];
        // You can remove self from observing 'myLocation' to only animate once
        [self.mkmapview removeObserver:self forKeyPath:@"myLocation"];
    }
}
-(void)selectUserID
{
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"trip.sqlite"];
    
    NSString *query26;
    //if (self.recordIDToEdit == -1) {
    query26=@"SELECT Satus2,fullname from Logintable1";
    //}
    [self.dbManager executeQuery:query26];
    
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    // Get the results.
    if (self.userarray != nil) {
        self.userarray = nil;
    }
    self.userarray=[[NSMutableArray alloc]init];
    
    self.userarray = [[NSMutableArray alloc]initWithArray:[self.dbManager loadDataFromDB:query26]];
    NSLog(@"total......%@",self.userarray);
    _userid = [[self.userarray objectAtIndex:0] objectAtIndex:0];
    //_username = [[self.userarray objectAtIndex:0] objectAtIndex:1];
    
}

-(void)updateaddressuser{
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"trip.sqlite"];

    NSString *home=[NSString stringWithFormat:@"%@",_str2];
  //  NSString *office=[NSString stringWithFormat:@"%@",_str2];
    NSString *state=[NSString stringWithFormat:@"%@",_str3];

    
    NSString *queryName;
    queryName = [NSString stringWithFormat:@"update AddressSave set Homeaddress=('%@'),Satus1=('%@')",home,state];
    [self.dbManager executeQuery:queryName];
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    
}
-(void)updateaddressuser1{
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"trip.sqlite"];
   // NSString *home=[NSString stringWithFormat:@"%@",_str2];
    NSString *office=[NSString stringWithFormat:@"%@",_str2];
    NSString *state=[NSString stringWithFormat:@"%@",_str3];
    
    NSString *queryName;
    queryName = [NSString stringWithFormat:@"update AddressSave set Officeaddress=('%@'),Satus2=('%@')",office,state];
    [self.dbManager executeQuery:queryName];
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
    }
    else{
        NSLog(@"Could not execute the query.");
    }
}

-(void)Homeaddresswebservices{
    NSInteger success = 0;
    @try {
        
        NSString *Home=[NSString stringWithFormat:@"%@,%@",_str2,_str3];

        NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@&home_address=%@",_userid,Home];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/office_address_ios.php"];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        NSError *error =nil;
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        if (!urlData) {
            
            NSLog(@"Error: %@", [error localizedDescription]);
            // return NO;
        }
        NSLog(@"response%@",response);
        NSLog(@"Response code: %ld", (long)[response statusCode]);
        
        if ([response statusCode] >= 200 && [response statusCode] < 300)
        {
            NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            NSLog(@"Response ==> %@", responseData);
            
            NSError *error = nil;
            _addressdictionary = [NSJSONSerialization
                               JSONObjectWithData:urlData
                               options:NSJSONReadingMutableContainers
                               error:&error];
            NSDictionary *req=[_addressdictionary objectForKey:@"result"];
            
            
            
            success = [_addressdictionary[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            if(success == 1)
            {
                [self updateaddressuser];
                 NSLog(@"success");
            }
            if(success == 0)
            {
                //promocodetext.text=@"";
                NSLog(@"Failuare");
                
            }
            else {
                
                //NSString *error_msg = (NSString *) jsonData[@"error_message"];
                // [self alertStatus:error_msg :@"Sign in Failed!" :0];
            }
            
        }
        else {
            //if (error) NSLog(@"Error: %@", error);
            // [self alertStatus:@"Connection Failed" :@"Sorry!" :0];
        }
        
        //}
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        //[self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
    if (success) {
        NSLog(@"login succeess");
    }
}

-(void)Officeaddresswebservices{
    NSInteger success = 0;
    @try {
        NSString *Office=[NSString stringWithFormat:@"%@,%@",_str2,_str3];

        
        NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@&office_address=%@",_userid,Office];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/office_address_ios.php"];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        NSError *error =nil;
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        if (!urlData) {
            
            NSLog(@"Error: %@", [error localizedDescription]);
            // return NO;
        }
        NSLog(@"response%@",response);
        NSLog(@"Response code: %ld", (long)[response statusCode]);
        
        if ([response statusCode] >= 200 && [response statusCode] < 300)
        {
            NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            NSLog(@"Response ==> %@", responseData);
            
            NSError *error = nil;
            _addressdictionary = [NSJSONSerialization
                                  JSONObjectWithData:urlData
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
            NSDictionary *req=[_addressdictionary objectForKey:@"result"];
            success = [_addressdictionary[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            if(success == 1)
            {
                [self updateaddressuser1];
                NSLog(@"success");
            }
            if(success == 0)
            {
                //promocodetext.text=@"";
                NSLog(@"Failuare");
                
            }
            else {
                
                //NSString *error_msg = (NSString *) jsonData[@"error_message"];
                // [self alertStatus:error_msg :@"Sign in Failed!" :0];
            }
            
        }
        
        else {
            //if (error) NSLog(@"Error: %@", error);
            // [self alertStatus:@"Connection Failed" :@"Sorry!" :0];
        }
        
        //}
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        //[self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
    if (success) {
        NSLog(@"login succeess");
    }
}

- (void) back:(UIBarButtonItem *)sender {
    [self.tutorialDelegate delegatesDescribedWithDescription:
     _str2 address:_str3];
    [self.navigationController popViewControllerAnimated:YES];
    
//[self.navigationController popViewControllerAnimated:YES];
}

- (void)backgroundTapped:(UITapGestureRecognizer *)gesture
{
    CGPoint touchPoint = [gesture locationInView:_mkmapview];
     //CLLocationCoordinate2D location1 =[_mkmapview convertPoint:touchPoint toCoordinateSpace:_mkmapview];
}
-(void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position
{   NSLog(@"didChangeCameraPosition");
    mapView.delegate = self;
    double lat=mapView.camera.target.latitude;
    double longitude= mapView.camera.target.longitude;
    CLLocationCoordinate2D addressCoordinates = CLLocationCoordinate2DMake(lat,longitude);
    GMSGeocoder* coder = [[GMSGeocoder alloc] init];
    [coder reverseGeocodeCoordinate:addressCoordinates completionHandler:^(GMSReverseGeocodeResponse *results, NSError *error) {
        if (error) {
            // NSLog(@"Error %@", error.description);
        } else {
            GMSAddress* address = [results firstResult];
            NSLog(@"%@addreshh",[address locality]);
            if([[address locality]isEqualToString:@"Pune"])
            {
                NSArray *arr = [address valueForKey:@"lines"];
                NSString *str1 = [NSString stringWithFormat:@"%lu",(unsigned long)[arr count]];
                if ([str1 isEqualToString:@"0"]) {
                    self.address.text = @"";
                }
                else if ([str1 isEqualToString:@"1"]) {
                    NSString *str2 = [arr objectAtIndex:0];
                    self.address.text = str2;
                }
                else if ([str1 isEqualToString:@"2"]) {
                    _str2 = [arr objectAtIndex:0];
                    _str3 = [arr objectAtIndex:1];
                    self.address.text = [NSString stringWithFormat:@"%@,%@",_str2,_str3];
                    NSLog(@"11%@ 22%@ 33%@ addresssss",str1,_str2,_str3);
                    NSLog(@"%@eee",_str2);
                }
        }
            else{
                
                BOOL didRunBefore = [[NSUserDefaults standardUserDefaults] boolForKey:@"didRunBefore"];
                
                if (!didRunBefore) {
                    // show alert;
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"Please Select Location in Pune" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
                    [alertView show];
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"didRunBefore"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
                
           }
        }
    }];
    NSLog(@"%fdff,%f ggggg",lat, longitude);
}
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(mapView.centerCoordinate.latitude, mapView.centerCoordinate.longitude);
    CGFloat txtLatitude = coord.latitude;
    CGFloat txtLongitude = coord.longitude;
    NSLog(@"Latitude is===>>>%f %f",txtLongitude);
    NSLog(@"Longitude is===>>>%f %f",txtLongitude);
}

//- (void)viewWillAppear:(BOOL)animated {
//    [self.mkmapview addObserver:self forKeyPath:@"myLocation" options:0 context:nil];
//}
//- (void)dealloc {
//    [self.mkmapview removeObserver:self forKeyPath:@"myLocation"];
//}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//    if([keyPath isEqualToString:@"myLocation"]) {
//        CLLocation *location = [object myLocation];
//        //...
//        NSLog(@"Location, %@,", location);
//        
//        CLLocationCoordinate2D target =
//        CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
//        
//        [self.mkmapview animateToLocation:target];
//        [self.mkmapview animateToZoom:15];
//    }
//}
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status == kCLAuthorizationStatusAuthorizedWhenInUse )
    {
        
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *loction=[locations lastObject];
    CLLocationCoordinate2D user = loction.coordinate;
   GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:CLLocationCoordinate2DMake(user.latitude, user.longitude) zoom: 12];
    
    

    _mkmapview = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
      [self.view addSubview:_mkmapview];
    [self.locationManager stopUpdatingLocation];
    
    

    
    // some code...
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    if([segue.identifier isEqualToString:@"location"])
//    {
//        FillupDetailsViewController *destViewController = segue.destinationViewController;
//        destViewController.address1 =_str2;
//        //destViewController.address2 =_str3;
//
//        //some data
//    }
//     [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Locationpickbuttonclick:(id)sender {

    [self.tutorialDelegate delegatesDescribedWithDescription:
     _str2 address:_str3];
    [self.navigationController popViewControllerAnimated:YES];
    //_view1.hidden=NO;

}
- (IBAction)NOButtonclick:(id)sender {
    [self.tutorialDelegate delegatesDescribedWithDescription:
     _str2 address:_str3];
    
    // close modal view
    [self.navigationController popViewControllerAnimated:YES];

    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)HomeButtonclick:(id)sender {
    
    [self Homeaddresswebservices];
    [self.tutorialDelegate delegatesDescribedWithDescription:
     _str2 address:_str3];
    
    // close modal view
    [self.navigationController popViewControllerAnimated:YES];
    
  
}

- (IBAction)OfficeButtonclick:(id)sender {
    
    [self Officeaddresswebservices];
    [self.tutorialDelegate delegatesDescribedWithDescription:
     _str2 address:_str3];
    // close modal view
    [self.navigationController popViewControllerAnimated:YES];

}
@end
