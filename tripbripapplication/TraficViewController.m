//
//  TraficViewController.m
//  tripbripapplication
//
//  Created by mac on 10/17/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "TraficViewController.h"
#import "TrafficTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
@interface TraficViewController ()
{
    NSMutableArray *journals;
}
@end

@implementation TraficViewController
@synthesize segmentcontrol;
- (void)viewDidLoad {
    [super viewDidLoad];
    journals=[[NSMutableArray alloc]init];
    self.navigationItem.title=@"Tariff Details";
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 49, 320, 50)];
    self.segmentcontrol.frame = CGRectMake(0, 0, 640, 65);
    
    scrollView.contentSize = CGSizeMake(self.segmentcontrol.frame.size.width, self.segmentcontrol.frame.size.height -1);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.scrollEnabled=YES;
    scrollView.bounces=NO;
    
    self.segmentcontrol.selectedSegmentIndex = 0;
    
    [scrollView addSubview:self.segmentcontrol];
    [self.view addSubview:scrollView];

    UIColor *selectedColor = [UIColor colorWithRed: 98/255.0 green:156/255.0 blue:247/255.0 alpha:1.0];
    UIColor *deselectedColor = [UIColor colorWithRed: 54/255.0 green:52/255.0 blue:48/255.0 alpha:1.0];
    
    for (UIControl *subview in [segmentcontrol subviews]) {
        if ([subview isSelected])
            [subview setTintColor:selectedColor];
        else
            [subview setTintColor:deselectedColor];
    }

    
    
    
    
    
    NSURL *websiteUrl = [NSURL URLWithString:@"https://www.tripbrip.com/website_api/tariff_details.php"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [_webview loadRequest:urlRequest];
    
   self.scrollview.contentSize =CGSizeMake(_scrollview.bounds.size.width, 700);
    _imag1.hidden=NO;
    _imag2.hidden=YES;
    _imag3.hidden=YES;
    _imag4.hidden=YES;
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello"
                                                            message:@"There IS NO internet connection !!"
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil, nil];
        //alertView.tag = tag;
        [alertView show];
        NSLog(@"There IS NO internet connection");
    } else {
        NSLog(@"There IS internet connection");
    }
    UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    [segmentcontrol setTitleTextAttributes:attributes
                                    forState:UIControlStateNormal];
    
    _trafficdictionary=[[NSDictionary alloc]init];
    _emonomicalarrya=[[NSMutableArray alloc]init];
    _sedanarray=[[NSMutableArray alloc]init];
    _largearrya=[[NSMutableArray alloc]init];
    _luxaryarrya=[[NSMutableArray alloc]init];
    _travellers=[[NSMutableArray alloc]init];
    _bus=[[NSMutableArray alloc]init];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self economicalwebservices];
            [self sedanwebservices];
            [self largewebservices];
            [self luxarywebservices];
            [self treverwebservices];
            [self buswebservices];
            [self.tableview reloadData];
            [hud hideAnimated:YES];
        });
        
    });

    _tableview.delegate=self;
    _tableview.dataSource=self;
    // Do any additional setup after loading the view.
}
-(void)fillJournals
{
    [journals removeAllObjects];
    
    NSString *segmentName = [self.segmentcontrol titleForSegmentAtIndex:self.segmentcontrol.selectedSegmentIndex];
    
    for (int i=0; i<4; i++) {
        [journals addObject:[NSString stringWithFormat:@"%@ %d",segmentName,i+1]];
    }
}
-(void)treverwebservices
{
    NSInteger success = 0;
    @try {
        
        NSString *tag=@"vehical_id";
        NSString *vehicalid=@"5";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&vehicle_category_id=%@",tag,vehicalid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi_test/car_model_ios.php"];
        
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
            _trafficdictionary = [NSJSONSerialization
                                  JSONObjectWithData:urlData
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
            _travellers = [_trafficdictionary objectForKey:@"result"];
            
            
            
            
            
            success = [_trafficdictionary[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 0)
            {
                
                
                NSLog(@" SUCCESS");
                
            } else {
                
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
-(void)buswebservices
{
    NSInteger success = 0;
    @try {
        
        NSString *tag=@"vehical_id";
        NSString *vehicalid=@"6";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&vehicle_category_id=%@",tag,vehicalid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi_test/car_model_ios.php"];
        
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
            _trafficdictionary = [NSJSONSerialization
                                  JSONObjectWithData:urlData
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
            _bus = [_trafficdictionary objectForKey:@"result"];
            
            
            
            
            
            success = [_trafficdictionary[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 0)
            {
                
                
                NSLog(@" SUCCESS");
                
            } else {
                
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
-(void)economicalwebservices{
    NSInteger success = 0;
    @try {
        
        NSString *tag=@"vehical_id";
        NSString *vehicalid=@"1";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&vehicle_category_id=%@",tag,vehicalid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi_test/car_model_ios.php"];
        
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
            _trafficdictionary = [NSJSONSerialization
                         JSONObjectWithData:urlData
                         options:NSJSONReadingMutableContainers
                         error:&error];
            _emonomicalarrya = [_trafficdictionary objectForKey:@"result"];
            
            
           
            
            
            success = [_trafficdictionary[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 0)
            {
                
                
                NSLog(@" SUCCESS");
                
            } else {
                
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
-(void)sedanwebservices{
    NSInteger success = 0;
    @try {
        
        NSString *tag=@"vehical_id";
        NSString *vehicalid=@"2";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&vehicle_category_id=%@",tag,vehicalid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi_test/car_model_ios.php"];
        
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
            _trafficdictionary = [NSJSONSerialization
                                  JSONObjectWithData:urlData
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
            _sedanarray = [_trafficdictionary objectForKey:@"result"];
            
            
            
            
            
            success = [_trafficdictionary[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 0)
            {
                
                
                NSLog(@" SUCCESS");
                
            } else {
                
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
-(void)largewebservices{
    NSInteger success = 0;
    @try {
        
        NSString *tag=@"vehical_id";
        NSString *vehicalid=@"3";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&vehicle_category_id=%@",tag,vehicalid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi_test/car_model_ios.php"];
        
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
            _trafficdictionary = [NSJSONSerialization
                                  JSONObjectWithData:urlData
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
            _largearrya = [_trafficdictionary objectForKey:@"result"];
            
            
            
            
            
            success = [_trafficdictionary[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 0)
            {
                
                
                NSLog(@" SUCCESS");
                
            } else {
                
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
-(void)luxarywebservices{
    NSInteger success = 0;
    @try {
        
        NSString *tag=@"vehical_id";
        NSString *vehicalid=@"4";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&vehicle_category_id=%@",tag,vehicalid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi_test/car_model_ios.php"];
        
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
            _trafficdictionary = [NSJSONSerialization
                                  JSONObjectWithData:urlData
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
            _luxaryarrya = [_trafficdictionary objectForKey:@"result"];
            
            
            
            
            
            success = [_trafficdictionary[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 0)
            {
                
                
                NSLog(@" SUCCESS");
                
            } else {
                
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





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberofSections = 0;
    
    switch (self.segmentcontrol.selectedSegmentIndex) {
        case 0:
            
            return _emonomicalarrya.count;
            break;
        case 1:
            
            return _sedanarray.count;
            break;
        case 2:
           
            return _largearrya.count;
            break;
        case 3:
            
            return _luxaryarrya.count;
            break;
        case 4:
            
            return _travellers.count;
            break;

        case 5:
            
            return _bus.count;
            break;

        default:
            break;
    }
    
    
    return 0;
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cellid";
    
    
    TrafficTableViewCell *cell = (TrafficTableViewCell *)[_tableview dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"historydetails" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    switch (self.segmentcontrol.selectedSegmentIndex)
    {
        case 0:
        {
            
            NSDictionary *dict = [_emonomicalarrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString = [dict objectForKey:@"vehicle_image"];
            
            NSURL *imageURL = [NSURL URLWithString:jsonImageUrlString];
            
            [cell.trafficimage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"sedan_car.png"]];
            
            NSDictionary *dict1 = [_emonomicalarrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString1 = [dict1 objectForKey:@"vehicle_modle_Name"];
            
            cell.trafficname.text=jsonImageUrlString1;
            NSDictionary *dict11 = [_emonomicalarrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString11= [dict11 objectForKey:@"Per_Km_Rate"];
            
            cell.perkilometer.text=[NSString stringWithFormat:@"₹%@ / per km",jsonImageUrlString11];
            
            NSDictionary *dict111 = [_emonomicalarrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString111= [dict111 objectForKey:@"sen_one"];
            
            cell.trafficvehicleseater.text=jsonImageUrlString111;
            
            NSDictionary *dict1111 = [_emonomicalarrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString1111= [dict1111 objectForKey:@"sen_three"];
            
            cell.typeacornonac.text=jsonImageUrlString1111;
            
            NSDictionary *dict11111 = [_emonomicalarrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString11111= [dict11111 objectForKey:@"sen_five"];
            
            cell.minkmvehicales.text=jsonImageUrlString11111;
            
            NSDictionary *dict111111 = [_emonomicalarrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString111111= [dict111111 objectForKey:@"sen_two"];
            
            cell.includedrivers.text=jsonImageUrlString111111;
            
            NSDictionary *dict1111111= [_emonomicalarrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString1111111= [dict1111111 objectForKey:@"sen_four"];
            
            cell.wellmaintained.text=jsonImageUrlString1111111;
            NSDictionary *dict2 = [_emonomicalarrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString2= [dict2 objectForKey:@"Per_Km_Rate1"];
            
            cell.nonacperrate.text=[NSString stringWithFormat:@"₹%@ / per km",jsonImageUrlString2];
            cell.labnonac.hidden=NO;
            cell.nonacperrate.hidden=NO;
            
            if([jsonImageUrlString2 isEqualToString:@"0"])
            {
                cell.labnonac.hidden=YES;
                cell.nonacperrate.hidden=YES;
            }
            

            
            break;
        }
        case 1:
        {
            NSDictionary *dict = [_sedanarray objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString = [dict objectForKey:@"vehicle_image"];
            
            NSURL *imageURL = [NSURL URLWithString:jsonImageUrlString];
            
            [cell.trafficimage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"sedan_car.png"]];
            
            NSDictionary *dict1 = [_sedanarray objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString1 = [dict1 objectForKey:@"vehicle_modle_Name"];
            
            cell.trafficname.text=jsonImageUrlString1;
            NSDictionary *dict11 = [_sedanarray objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString11= [dict11 objectForKey:@"Per_Km_Rate"];
            
            cell.perkilometer.text=[NSString stringWithFormat:@"₹%@ / per km",jsonImageUrlString11];
            
            NSDictionary *dict111 = [_sedanarray objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString111= [dict111 objectForKey:@"sen_one"];
            
            cell.trafficvehicleseater.text=jsonImageUrlString111;
            
            NSDictionary *dict1111 = [_sedanarray objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString1111= [dict1111 objectForKey:@"sen_three"];
            
            cell.typeacornonac.text=jsonImageUrlString1111;
            
            NSDictionary *dict11111 = [_sedanarray objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString11111= [dict11111 objectForKey:@"sen_five"];
            
            cell.minkmvehicales.text=jsonImageUrlString11111;
            
            NSDictionary *dict111111 = [_sedanarray objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString111111= [dict111111 objectForKey:@"sen_two"];
            
            cell.includedrivers.text=jsonImageUrlString111111;
            
            NSDictionary *dict1111111= [_sedanarray objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString1111111= [dict1111111 objectForKey:@"sen_four"];
            
            cell.wellmaintained.text=jsonImageUrlString1111111;
            
            NSDictionary *dict2 = [_sedanarray objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString2= [dict2 objectForKey:@"Per_Km_Rate1"];
            
            cell.nonacperrate.text=[NSString stringWithFormat:@"₹%@ / per km",jsonImageUrlString2];
            cell.labnonac.hidden=NO;
            cell.nonacperrate.hidden=NO;
            
            if([jsonImageUrlString2 isEqualToString:@"0"])
            {
                cell.labnonac.hidden=YES;
                cell.nonacperrate.hidden=YES;
            }
            


            break;
        }
        case 2:
        {
            
            NSDictionary *dict = [_largearrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString = [dict objectForKey:@"vehicle_image"];
            
            NSURL *imageURL = [NSURL URLWithString:jsonImageUrlString];
            
            [cell.trafficimage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"sedan_car.png"]];
            
            NSDictionary *dict1 = [_largearrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString1 = [dict1 objectForKey:@"vehicle_modle_Name"];
            
            cell.trafficname.text=jsonImageUrlString1;
            NSDictionary *dict11 = [_largearrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString11= [dict11 objectForKey:@"Per_Km_Rate"];
            
            cell.perkilometer.text=[NSString stringWithFormat:@"₹%@ / per km",jsonImageUrlString11];
            
            NSDictionary *dict111 = [_largearrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString111= [dict111 objectForKey:@"sen_one"];
            
            cell.trafficvehicleseater.text=jsonImageUrlString111;
            
            NSDictionary *dict1111 = [_largearrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString1111= [dict1111 objectForKey:@"sen_three"];
            
            cell.typeacornonac.text=jsonImageUrlString1111;
            
            NSDictionary *dict11111 = [_largearrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString11111= [dict11111 objectForKey:@"sen_five"];
            
            cell.minkmvehicales.text=jsonImageUrlString11111;
            
            NSDictionary *dict111111 = [_largearrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString111111= [dict111111 objectForKey:@"sen_two"];
            
            cell.includedrivers.text=jsonImageUrlString111111;
            
            NSDictionary *dict1111111= [_largearrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString1111111= [dict1111111 objectForKey:@"sen_four"];
            
            cell.wellmaintained.text=jsonImageUrlString1111111;
            NSDictionary *dict2 = [_largearrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString2= [dict2 objectForKey:@"Per_Km_Rate1"];
            
            cell.nonacperrate.text=[NSString stringWithFormat:@"₹%@ / per km",jsonImageUrlString2];
            cell.labnonac.hidden=NO;
            cell.nonacperrate.hidden=NO;
            
            if([jsonImageUrlString2 isEqualToString:@"0"])
            {
                cell.labnonac.hidden=YES;
                cell.nonacperrate.hidden=YES;
            }
            

            break;
        }
        case 3:
        {
            
            NSDictionary *dict = [_luxaryarrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString = [dict objectForKey:@"vehicle_image"];
            
            NSURL *imageURL = [NSURL URLWithString:jsonImageUrlString];
            
            [cell.trafficimage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"sedan_car.png"]];
            
            NSDictionary *dict1 = [_luxaryarrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString1 = [dict1 objectForKey:@"vehicle_modle_Name"];
            
            cell.trafficname.text=jsonImageUrlString1;
            NSDictionary *dict11 = [_luxaryarrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString11= [dict11 objectForKey:@"Per_Km_Rate"];
            
            cell.perkilometer.text=[NSString stringWithFormat:@"₹%@ / per km",jsonImageUrlString11];
            
            NSDictionary *dict111 = [_luxaryarrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString111= [dict111 objectForKey:@"sen_one"];
            
            cell.trafficvehicleseater.text=jsonImageUrlString111;
            
            NSDictionary *dict1111 = [_luxaryarrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString1111= [dict1111 objectForKey:@"sen_three"];
            
            cell.typeacornonac.text=jsonImageUrlString1111;
            
            NSDictionary *dict11111 = [_luxaryarrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString11111= [dict11111 objectForKey:@"sen_five"];
            
            cell.minkmvehicales.text=jsonImageUrlString11111;
            
            NSDictionary *dict111111 = [_luxaryarrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString111111= [dict111111 objectForKey:@"sen_two"];
            
            cell.includedrivers.text=jsonImageUrlString111111;
            
            NSDictionary *dict1111111= [_luxaryarrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString1111111= [dict1111111 objectForKey:@"sen_four"];
            
            cell.wellmaintained.text=jsonImageUrlString1111111;
            
            NSDictionary *dict2 = [_luxaryarrya objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString2= [dict2 objectForKey:@"Per_Km_Rate1"];
            
            cell.nonacperrate.text=[NSString stringWithFormat:@"₹%@ / per km",jsonImageUrlString2];
            cell.labnonac.hidden=NO;
            cell.nonacperrate.hidden=NO;
            
            if([jsonImageUrlString2 isEqualToString:@"0"])
            {
                cell.labnonac.hidden=YES;
                cell.nonacperrate.hidden=YES;
            }
            

            
            break;
            
        }
        case 4:
        {
            NSDictionary *dict = [_travellers objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString = [dict objectForKey:@"vehicle_image"];
            
            NSURL *imageURL = [NSURL URLWithString:jsonImageUrlString];
            
            [cell.trafficimage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"sedan_car.png"]];
            
            NSDictionary *dict1 = [_travellers objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString1 = [dict1 objectForKey:@"vehicle_modle_Name"];
            
            cell.trafficname.text=jsonImageUrlString1;
            NSDictionary *dict11 = [_travellers objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString11= [dict11 objectForKey:@"Per_Km_Rate"];
            
            cell.perkilometer.text=[NSString stringWithFormat:@"₹%@ / per km",jsonImageUrlString11];
            
            NSDictionary *dict111 = [_travellers objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString111= [dict111 objectForKey:@"sen_one"];
            
            cell.trafficvehicleseater.text=jsonImageUrlString111;
            
            NSDictionary *dict1111 = [_travellers objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString1111= [dict1111 objectForKey:@"sen_three"];
            
            cell.typeacornonac.text=jsonImageUrlString1111;
            
            NSDictionary *dict11111 = [_travellers objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString11111= [dict11111 objectForKey:@"sen_five"];
            
            cell.minkmvehicales.text=jsonImageUrlString11111;
            
            NSDictionary *dict111111 = [_travellers objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString111111= [dict111111 objectForKey:@"sen_two"];
            
            cell.includedrivers.text=jsonImageUrlString111111;
            
            NSDictionary *dict1111111= [_travellers objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString1111111= [dict1111111 objectForKey:@"sen_four"];
            
            cell.wellmaintained.text=jsonImageUrlString1111111;

            NSDictionary *dict2 = [_travellers objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString2= [dict2 objectForKey:@"Per_Km_Rate1"];
            
            cell.nonacperrate.text=[NSString stringWithFormat:@"₹%@ / per km",jsonImageUrlString2];
            cell.labnonac.hidden=NO;
            cell.nonacperrate.hidden=NO;
            
            if([jsonImageUrlString2 isEqualToString:@"0"])
            {
                cell.labnonac.hidden=YES;
                cell.nonacperrate.hidden=YES;
            }
            
            
            break;
            
        }

        case 5:
        {
            NSDictionary *dict = [_bus objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString = [dict objectForKey:@"vehicle_image"];
            
            NSURL *imageURL = [NSURL URLWithString:jsonImageUrlString];
            
            [cell.trafficimage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"sedan_car.png"]];
            
            NSDictionary *dict1 = [_bus objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString1 = [dict1 objectForKey:@"vehicle_modle_Name"];
            
            cell.trafficname.text=jsonImageUrlString1;
            NSDictionary *dict11 = [_bus objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString11= [dict11 objectForKey:@"Per_Km_Rate"];
            
            cell.perkilometer.text=[NSString stringWithFormat:@"₹%@ / per km",jsonImageUrlString11];
            
            NSDictionary *dict111 = [_bus objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString111= [dict111 objectForKey:@"sen_one"];
            
            cell.trafficvehicleseater.text=jsonImageUrlString111;
            
            NSDictionary *dict1111 = [_bus objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString1111= [dict1111 objectForKey:@"sen_three"];
            
            cell.typeacornonac.text=jsonImageUrlString1111;
            
            NSDictionary *dict11111 = [_bus objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString11111= [dict11111 objectForKey:@"sen_five"];
            
            cell.minkmvehicales.text=jsonImageUrlString11111;
            
            NSDictionary *dict111111 = [_bus objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString111111= [dict111111 objectForKey:@"sen_two"];
            
            cell.includedrivers.text=jsonImageUrlString111111;
            
            NSDictionary *dict1111111= [_bus objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString1111111= [dict1111111 objectForKey:@"sen_four"];
            
            cell.wellmaintained.text=jsonImageUrlString1111111;
            
            NSDictionary *dict2 = [_bus objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString2= [dict2 objectForKey:@"Per_Km_Rate1"];
            
            cell.nonacperrate.text=[NSString stringWithFormat:@"₹%@ / per km",jsonImageUrlString2];
            
            cell.labnonac.hidden=NO;
            cell.nonacperrate.hidden=NO;

            if([jsonImageUrlString2 isEqualToString:@"0"])
            {
                cell.labnonac.hidden=YES;
                cell.nonacperrate.hidden=YES;
            }
            

            
            
            
         break;
            
        }

            
        default:
            break;
            
    }
    
    
    
    
    
    return cell;
    
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

- (IBAction)segmentbuttonclick:(id)sender {
    if(segmentcontrol.selectedSegmentIndex == 0)
    {
        _imag1.hidden=NO;
        _imag2.hidden=YES;
        _imag3.hidden=YES;
        _imag4.hidden=YES;
        //[self upcomingwebservices];
        UIColor *selectedColor = [UIColor colorWithRed: 98/255.0 green:156/255.0 blue:247/255.0 alpha:1.0];
        UIColor *deselectedColor = [UIColor colorWithRed: 54/255.0 green:52/255.0 blue:48/255.0 alpha:1.0];
        
        for (UIControl *subview in [segmentcontrol subviews]) {
            if ([subview isSelected])
                [subview setTintColor:selectedColor];
            else
                [subview setTintColor:deselectedColor];
        }
        
       
        [self.tableview reloadData];

        
    }
    else if(segmentcontrol.selectedSegmentIndex == 1)
    {
        _imag2.hidden=NO;
        _imag1.hidden=YES;
        _imag3.hidden=YES;
        _imag4.hidden=YES;
        UIColor *selectedColor = [UIColor colorWithRed: 98/255.0 green:156/255.0 blue:247/255.0 alpha:1.0];
        UIColor *deselectedColor = [UIColor colorWithRed: 54/255.0 green:52/255.0 blue:48/255.0 alpha:1.0];
        
        for (UIControl *subview in [segmentcontrol subviews]) {
            if ([subview isSelected])
                [subview setTintColor:selectedColor];
            else
                [subview setTintColor:deselectedColor];
        }
    
        [self.tableview reloadData];
        
    }
    else if(segmentcontrol.selectedSegmentIndex == 2)
    {
        _imag3.hidden=NO;
        _imag1.hidden=YES;
        _imag2.hidden=YES;
        _imag4.hidden=YES;
        UIColor *selectedColor = [UIColor colorWithRed: 98/255.0 green:156/255.0 blue:247/255.0 alpha:1.0];
        UIColor *deselectedColor = [UIColor colorWithRed: 54/255.0 green:52/255.0 blue:48/255.0 alpha:1.0];
        
        for (UIControl *subview in [segmentcontrol subviews]) {
            if ([subview isSelected])
                [subview setTintColor:selectedColor];
            else
                [subview setTintColor:deselectedColor];
        }
        [self.tableview reloadData];
        
    }
    else if(segmentcontrol.selectedSegmentIndex == 3)
    {
        _imag4.hidden=NO;
        _imag1.hidden=YES;
        _imag2.hidden=YES;
        _imag3.hidden=YES;
        UIColor *selectedColor = [UIColor colorWithRed: 98/255.0 green:156/255.0 blue:247/255.0 alpha:1.0];
        UIColor *deselectedColor = [UIColor colorWithRed: 54/255.0 green:52/255.0 blue:48/255.0 alpha:1.0];
        
        for (UIControl *subview in [segmentcontrol subviews]) {
            if ([subview isSelected])
                [subview setTintColor:selectedColor];
            else
                [subview setTintColor:deselectedColor];
        }

        [self.tableview reloadData];
        
    }else if(segmentcontrol.selectedSegmentIndex == 4)
    {
        UIColor *selectedColor = [UIColor colorWithRed: 98/255.0 green:156/255.0 blue:247/255.0 alpha:1.0];
        UIColor *deselectedColor = [UIColor colorWithRed: 54/255.0 green:52/255.0 blue:48/255.0 alpha:1.0];
        
        for (UIControl *subview in [segmentcontrol subviews]) {
            if ([subview isSelected])
                [subview setTintColor:selectedColor];
            else
                [subview setTintColor:deselectedColor];
        }
        [self.tableview reloadData];
        
    }

    else if(segmentcontrol.selectedSegmentIndex == 5)
    {
        UIColor *selectedColor = [UIColor colorWithRed: 98/255.0 green:156/255.0 blue:247/255.0 alpha:1.0];
        UIColor *deselectedColor = [UIColor colorWithRed: 54/255.0 green:52/255.0 blue:48/255.0 alpha:1.0];
        
        for (UIControl *subview in [segmentcontrol subviews]) {
            if ([subview isSelected])
                [subview setTintColor:selectedColor];
            else
                [subview setTintColor:deselectedColor];
        }

        [self.tableview reloadData];
        
    }


}
@end
