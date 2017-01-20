//
//  HistoryDetailsViewController.m
//  tripbripapplication
//
//  Created by mac on 10/24/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "HistoryDetailsViewController.h"
#import "historyDetailsTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DBManager.h"
#import "UpcomingViewController.h"
#import "LiveViewController.h"
#import "completedViewController1.h"
#import "cancelViewController.h"
#import "LiveDetailsViewController.h"
#import "completedViewController.h"
#import "cancelViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "UILabel+UILabel_dynamicSizeMe.h"
@interface HistoryDetailsViewController ()
{
    NSDictionary *dic11;
    NSDictionary *dic1;
    NSDictionary *dic2;
    NSDictionary *dic3;
    NSDictionary *dic4;
    NSDictionary *dic5;
    NSDictionary *dic6;
    NSDictionary *dic7;
     NSDictionary *dic8;

}
@property (nonatomic, strong) DBManager *dbManager;
@property(nonatomic,retain)NSMutableArray *array1;
@end

@implementation HistoryDetailsViewController
@synthesize historyarray,tablview,upcomingArray,upcomingdictionary,profileArray,livearray,completeArray,cancelArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    

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
    
    
    
     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    _imag1.hidden=NO;
    _imag2.hidden=YES;
    _imag3.hidden=YES;
    _imag4.hidden=YES;
    tablview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.navigationItem.title=@"Booking History";
  
    //_array1=[[NSMutableArray alloc]init];
   upcomingArray=[[NSMutableArray alloc]init];
    
    profileArray=[[NSMutableArray alloc]init];
    livearray=[[NSMutableArray alloc]init];
    completeArray=[[NSMutableArray alloc]init];
    cancelArray=[[NSMutableArray alloc]init];
   
    
    
    [self selectUserID];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self upcomingwebservices];
            [self livewebservices];
            [self completedwebservices];
            [self Cancelwebservices];
            [self.tablview reloadData];
            [hud hideAnimated:YES];
        });
        
    });
    
 self.tablview.delegate=self;
    // Do any additional setup after loading the view.
}
-(void)Cancelwebservices{
    NSInteger success = 0;
    @try {
        
        NSString *tag=@"cancel";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&user_id=%@",tag,_userid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi_test/user_cancel_booking_show_ios.php"];
        
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
            upcomingdictionary = [NSJSONSerialization
                                  JSONObjectWithData:urlData
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
            NSMutableArray *reultsArray = [NSMutableArray new];
          
            
            if ([upcomingdictionary objectForKey:@"result"]) {
                reultsArray=[upcomingdictionary objectForKey:@"result"];
            }
            
            
            for (NSDictionary *dic in reultsArray) {
                
                  NSMutableDictionary *reultsDict = [NSMutableDictionary new];
                if ([dic objectForKey:@"booking_id"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"booking_id"] forKey:@"booking_id"];
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"Vehicle_Model_id"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"Vehicle_Model_id"] forKey:@"Vehicle_Model_id"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"no_of_days"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"no_of_days"] forKey:@"no_of_days"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"vehicle_image"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"vehicle_image"] forKey:@"vehicle_image"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                
                if ([dic objectForKey:@"place_to_visit"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"place_to_visit"] forKey:@"place_to_visit"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"date_of_journey"] != nil) {
                    NSDictionary *date_of_journey = [dic objectForKey:@"date_of_journey"];
                    if (date_of_journey[@"date"] != nil) {
                        
                        [reultsDict setObject:[date_of_journey objectForKey:@"date"] forKey:@"date_of_journey"];
                        
                        
                        
                    } else {
                        //NO NEED TO IMPLEMENT
                    }
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"end_of_journey"] != nil) {
                    NSDictionary *end_of_journey = [dic objectForKey:@"end_of_journey"];
                    if (end_of_journey[@"date"] != nil) {
                        
                        [reultsDict setObject:[end_of_journey objectForKey:@"date"] forKey:@"end_of_journey"];
                        
                    } else {
                        //NO NEED TO IMPLEMENT
                    }
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"pickup_time"] != nil) {
                    NSDictionary *pickup_time = [dic objectForKey:@"pickup_time"];
                    if (pickup_time[@"date"] != nil) {
                        
                        [reultsDict setObject:[pickup_time objectForKey:@"date"] forKey:@"pickup_time"];
                        
                    } else {
                        //NO NEED TO IMPLEMENT
                    }
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                
                if ([dic objectForKey:@"vehicle_id"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"vehicle_id"] forKey:@"vehicle_id"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"pickup_address"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"pickup_address"] forKey:@"pickup_address"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"location"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"location"] forKey:@"location"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"pincode"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"pincode"] forKey:@"pincode"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"vehicle_modle_Name"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"vehicle_modle_Name"] forKey:@"vehicle_modle_Name"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"booking_type"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"booking_type"] forKey:@"booking_type"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"sp_status"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"sp_status"] forKey:@"sp_status"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }

                
                if ([[reultsDict allKeys] count] > 0) {
                    [cancelArray addObject:reultsDict];
                }
                
            }
            
            success = [upcomingdictionary[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 0)
            {
                
//                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_booking.png"]];
//               
//                self.tablview.backgroundView = imageView;
            }
            if(success == 1)
            {
                NSLog(@"login sucess");
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
-(void)completedwebservices{
    NSInteger success = 0;
    @try {
        
        NSString *tag=@"completed";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&user_id=%@",tag,_userid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi_test/user_complated_ios.php"];
        
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
            upcomingdictionary = [NSJSONSerialization
                                  JSONObjectWithData:urlData
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
            NSMutableArray *reultsArray = [NSMutableArray new];
           
            
            if ([upcomingdictionary objectForKey:@"result"]) {
                reultsArray=[upcomingdictionary objectForKey:@"result"];
            }
            
            
            for (NSDictionary *dic in reultsArray) {
                 NSMutableDictionary *reultsDict = [NSMutableDictionary new];
                
                if ([dic objectForKey:@"booking_id"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"booking_id"] forKey:@"booking_id"];
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"Vehicle_Model_id"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"Vehicle_Model_id"] forKey:@"Vehicle_Model_id"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"no_of_days"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"no_of_days"] forKey:@"no_of_days"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"vehicle_image"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"vehicle_image"] forKey:@"vehicle_image"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                
                if ([dic objectForKey:@"place_to_visit"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"place_to_visit"] forKey:@"place_to_visit"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"date_of_journey"] != nil) {
                    NSDictionary *date_of_journey = [dic objectForKey:@"date_of_journey"];
                    if (date_of_journey[@"date"] != nil) {
                        
                        [reultsDict setObject:[date_of_journey objectForKey:@"date"] forKey:@"date_of_journey"];
                        
                        
                        
                    } else {
                        //NO NEED TO IMPLEMENT
                    }
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"end_of_journey"] != nil) {
                    NSDictionary *end_of_journey = [dic objectForKey:@"end_of_journey"];
                    if (end_of_journey[@"date"] != nil) {
                        
                        [reultsDict setObject:[end_of_journey objectForKey:@"date"] forKey:@"end_of_journey"];
                        
                    } else {
                        //NO NEED TO IMPLEMENT
                    }
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"pickup_time"] != nil) {
                    NSDictionary *pickup_time = [dic objectForKey:@"pickup_time"];
                    if (pickup_time[@"date"] != nil) {
                        
                        [reultsDict setObject:[pickup_time objectForKey:@"date"] forKey:@"pickup_time"];
                        
                    } else {
                        //NO NEED TO IMPLEMENT
                    }
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                
                if ([dic objectForKey:@"vehicle_id"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"vehicle_id"] forKey:@"vehicle_id"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"pickup_address"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"pickup_address"] forKey:@"pickup_address"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"location"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"location"] forKey:@"location"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"pincode"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"pincode"] forKey:@"pincode"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"vehicle_modle_Name"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"vehicle_modle_Name"] forKey:@"vehicle_modle_Name"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"Base_Fare"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"Base_Fare"] forKey:@"Base_Fare"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"Night_Charges"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"Night_Charges"] forKey:@"Night_Charges"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"service_tax"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"service_tax"] forKey:@"service_tax"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"final_Amount"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"final_Amount"] forKey:@"final_Amount"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"swachh_bharat"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"swachh_bharat"] forKey:@"swachh_bharat"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"krishi_kalyan"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"krishi_kalyan"] forKey:@"krishi_kalyan"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"discount"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"discount"] forKey:@"discount"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"refral_discount"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"refral_discount"] forKey:@"refral_discount"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"Start_Time"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"Start_Time"] forKey:@"Start_Time"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"End_Time"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"End_Time"] forKey:@"End_Time"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"Refuel_Charges"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"Refuel_Charges"] forKey:@"Refuel_Charges"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([[reultsDict allKeys] count] > 0) {
                    [completeArray addObject:reultsDict];
                }
                if ([dic objectForKey:@"booking_type"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"booking_type"] forKey:@"booking_type"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"s_basefair"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"s_basefair"] forKey:@"s_basefair"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"s_advanced_payment"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"s_advanced_payment"] forKey:@"s_advanced_payment"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"s_minkm"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"s_minkm"] forKey:@"s_minkm"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"s_duepayment"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"s_duepayment"] forKey:@"s_duepayment"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"s_discount"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"s_discount"] forKey:@"s_discount"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"Late_Charges"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"Late_Charges"] forKey:@"Late_Charges"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"Total_Reading"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"Total_Reading"] forKey:@"Total_Reading"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"sp_status"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"sp_status"] forKey:@"sp_status"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"payment_mode"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"payment_mode"] forKey:@"payment_mode"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"cal_wallet"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"cal_wallet"] forKey:@"cal_wallet"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }


                
            }
            
            success = [upcomingdictionary[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            if(success == 0)
            {
                
//                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_booking.png"]];
//                
//                self.tablview.backgroundView = imageView;
            }
            if(success == 1)
            {
                NSLog(@"login sucess");
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

-(void)livewebservices{
    NSInteger success = 0;
    @try {
        
        NSString *tag=@"live";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&user_id=%@",tag,_userid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi_test/user_live_booking_ios.php"];
        
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
            upcomingdictionary = [NSJSONSerialization
                                  JSONObjectWithData:urlData
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
            NSMutableArray *reultsArray = [NSMutableArray new];
            
            if ([upcomingdictionary objectForKey:@"result"]) {
                reultsArray=[upcomingdictionary objectForKey:@"result"];
            }
            
            
            for (NSDictionary *dic in reultsArray) {
                NSMutableDictionary *reultsDict = [NSMutableDictionary new];

                
                if ([dic objectForKey:@"booking_id"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"booking_id"] forKey:@"booking_id"];
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"Vehicle_Model_id"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"Vehicle_Model_id"] forKey:@"Vehicle_Model_id"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"no_of_days"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"no_of_days"] forKey:@"no_of_days"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"vehicle_image"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"vehicle_image"] forKey:@"vehicle_image"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                
                if ([dic objectForKey:@"place_to_visit"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"place_to_visit"] forKey:@"place_to_visit"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"date_of_journey"] != nil) {
                    NSDictionary *date_of_journey = [dic objectForKey:@"date_of_journey"];
                    if (date_of_journey[@"date"] != nil) {
                        
                        [reultsDict setObject:[date_of_journey objectForKey:@"date"] forKey:@"date_of_journey"];
                        
                        
                        
                    } else {
                        //NO NEED TO IMPLEMENT
                    }
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"end_of_journey"] != nil) {
                    NSDictionary *end_of_journey = [dic objectForKey:@"end_of_journey"];
                    if (end_of_journey[@"date"] != nil) {
                        
                        [reultsDict setObject:[end_of_journey objectForKey:@"date"] forKey:@"end_of_journey"];
                        
                    } else {
                        //NO NEED TO IMPLEMENT
                    }
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"pickup_time"] != nil) {
                    NSDictionary *pickup_time = [dic objectForKey:@"pickup_time"];
                    if (pickup_time[@"date"] != nil) {
                        
                        [reultsDict setObject:[pickup_time objectForKey:@"date"] forKey:@"pickup_time"];
                        
                    } else {
                        //NO NEED TO IMPLEMENT
                    }
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                
                if ([dic objectForKey:@"vehicle_id"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"vehicle_id"] forKey:@"vehicle_id"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"pickup_address"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"pickup_address"] forKey:@"pickup_address"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"location"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"location"] forKey:@"location"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"pincode"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"pincode"] forKey:@"pincode"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"vehicle_modle_Name"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"vehicle_modle_Name"] forKey:@"vehicle_modle_Name"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"driver_mobile"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"driver_mobile"] forKey:@"driver_mobile"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"driver_name"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"driver_name"] forKey:@"driver_name"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"booking_type"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"booking_type"] forKey:@"booking_type"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"s_basefair"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"s_basefair"] forKey:@"s_basefair"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"s_advanced_payment"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"s_advanced_payment"] forKey:@"s_advanced_payment"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"s_minkm"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"s_minkm"] forKey:@"s_minkm"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"s_duepayment"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"s_duepayment"] forKey:@"s_duepayment"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"s_discount"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"s_discount"] forKey:@"s_discount"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }

                if ([dic objectForKey:@"sp_status"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"sp_status"] forKey:@"sp_status"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }

                
                
                
                if ([[reultsDict allKeys] count] > 0) {
                    [livearray addObject:reultsDict];
                }
                
            }
            
            success = [upcomingdictionary[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 0)
            {
                
//                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_booking.png"]];
//                
//                self.tablview.backgroundView = imageView;
            }
           
            if(success ==1)
            {
                NSLog(@"login sucess");
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

-(void)upcomingwebservices{
    NSInteger success = 0;
    @try {
        
        NSString *tag=@"upcoming";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&user_id=%@",tag,_userid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi_test/user_upcoming_ios.php"];
        
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
            upcomingdictionary = [NSJSONSerialization
                         JSONObjectWithData:urlData
                         options:NSJSONReadingMutableContainers
                         error:&error];
            NSMutableArray *reultsArray = [[NSMutableArray alloc]init];
           
            if ([upcomingdictionary objectForKey:@"result"]) {
                reultsArray=[upcomingdictionary objectForKey:@"result"];
            }
            
            
            for (NSDictionary *dic in reultsArray) {
               
                NSMutableDictionary *reultsDict = [[NSMutableDictionary alloc]init];

                if ([dic objectForKey:@"booking_id"] != nil) {

                    [reultsDict setObject:[dic objectForKey:@"booking_id"] forKey:@"booking_id"];
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"vehicle_id"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"vehicle_id"] forKey:@"vehicle_id"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"Vehicle_Model_id"] != nil) {

                    [reultsDict setObject:[dic objectForKey:@"Vehicle_Model_id"] forKey:@"Vehicle_Model_id"];

                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"date_of_journey"] != nil) {
                    NSDictionary *date_of_journey = [dic objectForKey:@"date_of_journey"];
                    if (date_of_journey[@"date"] != nil) {
                        
                        [reultsDict setObject:[date_of_journey objectForKey:@"date"] forKey:@"date_of_journey"];
                        
                        
                        
                    } else {
                        //NO NEED TO IMPLEMENT
                    }
                } else {
                    //NO NEED TO IMPLEMENT
                }
  
                if ([dic objectForKey:@"end_of_journey"] != nil) {
                    NSDictionary *end_of_journey = [dic objectForKey:@"end_of_journey"];
                    if (end_of_journey[@"date"] != nil) {
                        
                        [reultsDict setObject:[end_of_journey objectForKey:@"date"] forKey:@"end_of_journey"];
                        
                    } else {
                        //NO NEED TO IMPLEMENT
                    }
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"pickup_time"] != nil) {
                    NSDictionary *pickup_time = [dic objectForKey:@"pickup_time"];
                    if (pickup_time[@"date"] != nil) {
                        
                        [reultsDict setObject:[pickup_time objectForKey:@"date"] forKey:@"pickup_time"];
                        
                    } else {
                        //NO NEED TO IMPLEMENT
                    }
                } else {
                    //NO NEED TO IMPLEMENT
                }

                
                if ([dic objectForKey:@"no_of_days"] != nil) {

                    [reultsDict setObject:[dic objectForKey:@"no_of_days"] forKey:@"no_of_days"];

                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"pickup_address"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"pickup_address"] forKey:@"pickup_address"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"place_to_visit"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"place_to_visit"] forKey:@"place_to_visit"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
               

                if ([dic objectForKey:@"pincode"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"pincode"] forKey:@"pincode"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"vehicle_modle_Name"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"vehicle_modle_Name"] forKey:@"vehicle_modle_Name"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                if ([dic objectForKey:@"location"] != nil) {

                    [reultsDict setObject:[dic objectForKey:@"location"] forKey:@"location"];

                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"vehicle_image"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"vehicle_image"] forKey:@"vehicle_image"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"booking_type"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"booking_type"] forKey:@"booking_type"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"s_basefair"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"s_basefair"] forKey:@"s_basefair"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"s_advanced_payment"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"s_advanced_payment"] forKey:@"s_advanced_payment"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"s_minkm"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"s_minkm"] forKey:@"s_minkm"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"s_duepayment"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"s_duepayment"] forKey:@"s_duepayment"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"s_discount"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"s_discount"] forKey:@"s_discount"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"sp_status"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"sp_status"] forKey:@"sp_status"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                if ([dic objectForKey:@"refral_discount"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"refral_discount"] forKey:@"refral_discount"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }

                if ([[reultsDict allKeys] count] > 0)
                {
                    NSLog(@"resultdic%@",reultsDict);
                    
        
                  // upcomingArray =[[NSMutableArray alloc]init];
                     [upcomingArray addObject:reultsDict];
                    //[upcomingArray insertObject:reultsDict atIndex:i];
//                    for(int i=0; i<[upcomingArray count];i++)
//{
    
//                    [[upcomingArray objectAtIndex:i]  objectForKey:@"booking_id"];
//                    [[upcomingArray objectAtIndex:i]  objectForKey:@"date_of_journey"];
//                    [[upcomingArray objectAtIndex:i] objectForKey:@"end_of_journey"];
//
//                    [[upcomingArray objectAtIndex:i]  objectForKey:@"no_of_days"];
//
//                    [[upcomingArray objectAtIndex:i]  objectForKey:@"place_to_visit"];
//                    [[upcomingArray objectAtIndex:i]  objectForKey:@"vehicle_image"];
//    [upcomingArray setValue:[[reultsDict objectForKey:@"booking_id"] objectAtIndex:i] forKey:@"booking_id"];
//    [upcomingArray setValue:[[reultsDict objectForKey:@"date_of_journey"] objectAtIndex:i] forKey:@"date_of_journey"];
//    [upcomingArray setValue:[[reultsDict objectForKey:@"end_of_journey"] objectAtIndex:i] forKey:@"end_of_journey"];
//    [upcomingArray setValue:[[reultsDict objectForKey:@"no_of_days"] objectAtIndex:i] forKey:@"no_of_days"];
//    [upcomingArray setValue:[[reultsDict objectForKey:@"vehicle_image"] objectAtIndex:i] forKey:@"vehicle_image"];
    


   
  NSLog(@"upppcomingarray%@",upcomingArray);
                        // [upcomingArray setObject:reultsDict atIndexedSubscript:0];
                  //  [upcomingArray insertObject:reultsDict atIndex:1];
                //}
                }
                
            }
            
            
            success = [upcomingdictionary[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 0)
            {
                
               
            }
            if(success ==1)
               {
                  
                   NSLog(@"login sucess");
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

-(void)selectUserID
{
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"trip.sqlite"];
    
    NSString *query26;
    //if (self.recordIDToEdit == -1) {
    query26=@"SELECT Satus2 from Logintable1 ";
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
    
}
- (CGSize)getSizeForText:(NSString *)text maxWidth:(CGFloat)width font:(NSString *)fontName fontSize:(float)fontSize {
    
    /*! Returns the size of the label to display the text provided
     @param text
     The string to be displayed
     @param width
     The width required for displaying the string
     @param fontName
     The font name for the label
     @param fontSize
     The font size for the label
     */
    
    CGSize constraintSize;
    constraintSize.height = MAXFLOAT;
    constraintSize.width = width;
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont fontWithName:fontName size:fontSize], NSFontAttributeName,
                                          nil];
    
    CGRect frame = [text boundingRectWithSize:constraintSize
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:attributesDictionary
                                      context:nil];
    
    CGSize stringSize = frame.size;
    
    return stringSize;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberofSections = 0;
   
    switch (self.segmentcontroller.selectedSegmentIndex) {
        case 0:
            
          
            if ([self.upcomingArray count] > 0)
            {
                self.tablview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                numberofSections = 1;
                //yourTableView.backgroundView   = nil;
                self.tablview.backgroundView = nil;
               

            }
            else
            {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_booking.png"]];
                
                self.tablview.backgroundView = imageView;
            }
             return upcomingArray.count;
            break;
        case 1:
            if ([self.livearray count] > 0)
            {
                self.tablview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                numberofSections = 1;
                //yourTableView.backgroundView   = nil;
                self.tablview.backgroundView = nil;
            }
            else
            {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_booking.png"]];
                
                self.tablview.backgroundView = imageView;
            }

            return livearray.count;
            break;
        case 2:
            if ([self.completeArray count] > 0)
            {
                self.tablview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                numberofSections = 1;
                //yourTableView.backgroundView   = nil;
                self.tablview.backgroundView = nil;
            }
            else
            {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_booking.png"]];
                
                self.tablview.backgroundView = imageView;
            }

            return completeArray.count;
            break;
        case 3:
            if ([self.cancelArray count] > 0)
            {
                self.tablview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                numberofSections = 1;
                //yourTableView.backgroundView   = nil;
                self.tablview.backgroundView = nil;
            }
            else
            {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_booking.png"]];
                
                self.tablview.backgroundView = imageView;
            }

            return cancelArray.count;
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
       static NSString *simpleTableIdentifier = @"historydetails";
    
    
    historyDetailsTableViewCell *cell = (historyDetailsTableViewCell *)[tablview dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"historydetails" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    switch (self.segmentcontroller.selectedSegmentIndex)
    {
        case 0:
        {
            
            
            NSString *stu1=@"UPCOMING";
            
            
            
            
            cell.stuslab.text=stu1;
            cell.stuslab.textColor =[UIColor colorWithRed:(27/255.0) green:(8/255.0) blue:(111/255.0) alpha:1];
            dic11 = [upcomingArray objectAtIndex:indexPath.row];
            NSString *jsonImageUrlString = [dic11 objectForKey:@"vehicle_image"];
            NSURL *imageURL = [NSURL URLWithString:jsonImageUrlString];
            [cell.imagecell sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"sedan_car.png"]];
            NSDictionary *reg=[upcomingArray objectAtIndex:indexPath.row];
            NSLog(@"%@", reg [@"booking_id"]);
            NSString *bookstring=[NSString stringWithFormat:@"%d", [reg [@"booking_id"] intValue]];
            cell.bookidcell.text =bookstring;
            
            NSDictionary *reg1=[upcomingArray objectAtIndex:indexPath.row];
            NSLog(@"%@", reg1 [@"place_to_visit"]);
            NSString *placestring=[reg1 objectForKey:@"place_to_visit"];
            cell.placecell.text =placestring;
            [cell.placecell resizeToFit];
            
            NSDictionary *reg2=[upcomingArray objectAtIndex:indexPath.row];
            NSLog(@"%@", reg2 [@"date_of_journey"]);
            NSString *datestring2=[reg2 objectForKey:@"date_of_journey"];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
            NSDate *date = [formatter dateFromString:datestring2];
            [formatter setDateFormat:@"dd'-'MM'-'yyyy'"];
            NSString *newDate = [formatter stringFromDate:date];
            _datestring = [NSString stringWithFormat:@"%@",newDate];
            
            cell.tripcell.text =_datestring;
            
            NSDictionary *reg3=[upcomingArray objectAtIndex:indexPath.row];
            NSLog(@"%@", reg3 [@"no_of_days"]);
            NSString *nodaystring=[reg3 objectForKey:@"no_of_days"];
            cell.totaldaycell.text =nodaystring;
            
            
            NSDictionary *reg4=[upcomingArray objectAtIndex:indexPath.row];
            NSLog(@"%@", reg4 [@"end_of_journey"]);
            NSString *datestring3=[reg4 objectForKey:@"end_of_journey"];
            
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            [formatter1 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
            NSDate *date1 = [formatter1 dateFromString:datestring3];
            [formatter1 setDateFormat:@"dd'-'MM'-'yyyy'"];
            NSString *newDate1 = [formatter stringFromDate:date1];
            _datestring1 = [NSString stringWithFormat:@"%@",newDate1];
            
            cell.enddatecell.text =_datestring1;
            cell.enddatecell.hidden=YES;
            
            NSDictionary *reg5=[upcomingArray objectAtIndex:indexPath.row];
            NSLog(@"%@", reg5 [@"pickup_time"]);
            NSString *datestring4=[reg5 objectForKey:@"pickup_time"];
            
            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
            [formatter2 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
            NSDate *date2 = [formatter2 dateFromString:datestring4];
            [formatter2 setDateFormat:@"HH:mm"];
            NSString *newDate2 = [formatter2 stringFromDate:date2];
            _pickstring = [NSString stringWithFormat:@"%@",newDate2];
            
            cell.picktimecell.text =_pickstring;
            cell.picktimecell.hidden=YES;
            
            NSDictionary *reg6=[upcomingArray objectAtIndex:indexPath.row];
            NSLog(@"%@", reg6 [@"pickup_time"]);
            NSString *datestring5=[reg6 objectForKey:@"pickup_time"];
            
            NSDateFormatter *formatter3 = [[NSDateFormatter alloc] init];
            [formatter3 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
            NSDate *date3 = [formatter3 dateFromString:datestring5];
            [formatter3 setDateFormat:@"HH:mm"];
            NSString *newDate3 = [formatter3 stringFromDate:date3];
            _dropstring = [NSString stringWithFormat:@"%@",newDate3];
            
            cell.droptimecell.text =_pickstring;
            cell.droptimecell.hidden=YES;
            
            NSDictionary *special=[upcomingArray objectAtIndex:indexPath.row];
            NSLog(@"%@", special [@"booking_type"]);
            NSString *spclstring=[special objectForKey:@"booking_type"];
            NSString *bookstring1=[NSString stringWithFormat:@"%d", [special [@"booking_id"] intValue]];
            
            if([spclstring isEqualToString:@"0"])
            {
                cell.specialbookid.text=bookstring1;
                cell.bookidcell.hidden=YES;
                cell.totaldaycell.hidden=YES;
                cell.booklab.hidden=YES;
                cell.totaldaylab.hidden=YES;
                cell.sepecialreqlab.hidden=NO;
                cell.specialbookid.hidden=NO;
                cell.paymentstutslab.hidden=NO;
                cell.advancepaymetlab.hidden=NO;
            }else if([spclstring isEqualToString:@"1"])
            {
                cell.sepecialreqlab.hidden=YES;
                cell.specialbookid.hidden=YES;
                cell.paymentstutslab.hidden=YES;
                cell.advancepaymetlab.hidden=YES;
                cell.bookidcell.hidden=NO;
                cell.totaldaycell.hidden=NO;
                cell.booklab.hidden=NO;
                cell.totaldaylab.hidden=NO;
            }
            
            NSDictionary *special1=[upcomingArray objectAtIndex:indexPath.row];
            NSLog(@"%@", special1 [@"sp_status"]);
            NSString *spclstring1=[special1 objectForKey:@"sp_status"];
            NSLog(@"%@spstatus", spclstring1);

            
            
            
            if([spclstring1 isEqualToString:@"0"])
            {
                cell.paymentstutslab.text=@"Completed";
                
            }else if ([spclstring1 isEqualToString:@"1"])
            {
                cell.paymentstutslab.text=@"Pending";
                cell.paymentstutslab.textColor=[UIColor redColor];
            }
            
        }
            
        break;
        case 1:
        {
            NSString *stu1=@"LIVE";
            cell.stuslab.text=stu1;
            cell.stuslab.textColor =[UIColor colorWithRed:(2/255.0) green:(190/255.0) blue:(6/255.0) alpha:1];
            
            dic11 = [livearray objectAtIndex:indexPath.row];
            
            NSString *ImageUrlString = [dic11 objectForKey:@"vehicle_image"];
            
            NSURL *imageup = [NSURL URLWithString:ImageUrlString];
            
            [cell.imagecell sd_setImageWithURL:imageup placeholderImage:[UIImage imageNamed:@"sedan_car.png"]];
            
            dic1=[livearray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic1 [@"booking_id"]);
            NSString *bookstring11=[NSString stringWithFormat:@"%d", [dic1 [@"booking_id"] intValue]];
            cell.bookidcell.text =bookstring11;
            
            dic2=[livearray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic2 [@"place_to_visit"]);
            NSString *placestring11=[dic2 objectForKey:@"place_to_visit"];
            
            cell.placecell.text =placestring11;
             [cell.placecell resizeToFit];
            
            dic3=[livearray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic3 [@"date_of_journey"]);
            NSString *datestring22=[dic3 objectForKey:@"date_of_journey"];
            
            NSDateFormatter *formatter11 = [[NSDateFormatter alloc] init];
            [formatter11 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
            NSDate *date11 = [formatter11 dateFromString:datestring22];
            [formatter11 setDateFormat:@"dd'-'MM'-'yyyy'"];
            NSString *newDate11 = [formatter11 stringFromDate:date11];
            _datestring = [NSString stringWithFormat:@"%@",newDate11];
            
            cell.tripcell.text =_datestring;
            
            dic4=[livearray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic4 [@"no_of_days"]);
            NSString *nodaystring11=[dic4 objectForKey:@"no_of_days"];
            cell.totaldaycell.text =nodaystring11;
            
            
            dic5=[livearray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic5 [@"end_of_journey"]);
            NSString *datestring33=[dic5 objectForKey:@"end_of_journey"];
            
            NSDateFormatter *formatter22 = [[NSDateFormatter alloc] init];
            [formatter22 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
            NSDate *date22 = [formatter22 dateFromString:datestring33];
            [formatter22 setDateFormat:@"dd'-'MM'-'yyyy'"];
            NSString *newDate22 = [formatter22 stringFromDate:date22];
            _datestring1 = [NSString stringWithFormat:@"%@",newDate22];
            
            cell.enddatecell.text =_datestring1;
            cell.enddatecell.hidden=YES;
            
            dic6=[livearray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic6 [@"pickup_time"]);
            NSString *datestring66=[dic6 objectForKey:@"pickup_time"];
            
            NSDateFormatter *formatter33 = [[NSDateFormatter alloc] init];
            [formatter33 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
            NSDate *date33 = [formatter33 dateFromString:datestring66];
            [formatter33 setDateFormat:@"HH:mm"];
            NSString *newDate33 = [formatter33 stringFromDate:date33];
            _pickstring = [NSString stringWithFormat:@"%@",newDate33];
            
            cell.picktimecell.text =_pickstring;
            cell.picktimecell.hidden=YES;
            
            dic7=[livearray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic7 [@"pickup_time"]);
            NSString *datestring44=[dic7 objectForKey:@"pickup_time"];
            
            NSDateFormatter *formatter44 = [[NSDateFormatter alloc] init];
            [formatter44 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
            NSDate *date44 = [formatter44 dateFromString:datestring44];
            [formatter44 setDateFormat:@"HH:mm"];
            NSString *newDate44 = [formatter44 stringFromDate:date44];
            _dropstring = [NSString stringWithFormat:@"%@",newDate44];
            
            cell.droptimecell.text =_pickstring;
            cell.droptimecell.hidden=YES;
            
            
            dic8=[livearray objectAtIndex:indexPath.row];
            NSLog(@"%@booktype", dic8 [@"booking_type"]);
            NSString *spclstring1=[dic8 objectForKey:@"booking_type"];
            NSString *bookstring=[NSString stringWithFormat:@"%d", [dic8 [@"booking_id"] intValue]];
            
            if([spclstring1 isEqualToString:@"0"])
            {
                cell.specialbookid.text=bookstring;
                cell.bookidcell.hidden=YES;
                cell.totaldaycell.hidden=YES;
                cell.booklab.hidden=YES;
                cell.totaldaylab.hidden=YES;
                cell.sepecialreqlab.hidden=NO;
                cell.specialbookid.hidden=NO;
                cell.paymentstutslab.hidden=NO;
                cell.advancepaymetlab.hidden=NO;

            }else if([spclstring1 isEqualToString:@"1"])
            {
                cell.sepecialreqlab.hidden=YES;
                cell.specialbookid.hidden=YES;
                cell.paymentstutslab.hidden=YES;
                cell.advancepaymetlab.hidden=YES;
                cell.bookidcell.hidden=NO;
                cell.totaldaycell.hidden=NO;
                cell.booklab.hidden=NO;
                cell.totaldaylab.hidden=NO;
            }
            NSDictionary *special1=[livearray objectAtIndex:indexPath.row];
            NSLog(@"%@", special1 [@"sp_status"]);
            NSString *spclstring2=[special1 objectForKey:@"sp_status"];
            
            if([spclstring2 isEqualToString:@"0"])
            {
                cell.paymentstutslab.text=@"Completed";
                
            }else if ([spclstring2 isEqualToString:@"1"])
            {
                cell.paymentstutslab.text=@"Pending";
                cell.paymentstutslab.textColor=[UIColor redColor];
            }

            break;
        }
        case 2:
        {
            NSString *stu1=@"COMPLETED";
            cell.stuslab.text=stu1;
            cell.stuslab.textColor = [UIColor colorWithRed:(7/255.0) green:(129/255.0) blue:(236/255.0) alpha:1];
            

            
            NSDictionary *dic111 = [completeArray objectAtIndex:indexPath.row];
            
            NSString *ImageUrlString = [dic111 objectForKey:@"vehicle_image"];
            
            NSURL *imageup = [NSURL URLWithString:ImageUrlString];
            
            [cell.imagecell sd_setImageWithURL:imageup placeholderImage:[UIImage imageNamed:@"sedan_car.png"]];
            
            NSDictionary *dic222=[completeArray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic222 [@"booking_id"]);
            NSString *bookstring11=[NSString stringWithFormat:@"%d", [dic222 [@"booking_id"] intValue]];
            cell.bookidcell.text =bookstring11;
            
            NSDictionary *dic333=[completeArray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic2 [@"place_to_visit"]);
            NSString *placestring11=[dic333 objectForKey:@"place_to_visit"];
            
            cell.placecell.text =placestring11;
             [cell.placecell resizeToFit];
            
            NSDictionary *dic444=[completeArray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic3 [@"date_of_journey"]);
            NSString *datestring22=[dic444 objectForKey:@"date_of_journey"];
            
            NSDateFormatter *formatter11 = [[NSDateFormatter alloc] init];
            [formatter11 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
            NSDate *date11 = [formatter11 dateFromString:datestring22];
            [formatter11 setDateFormat:@"dd'-'MM'-'yyyy'"];
            NSString *newDate11 = [formatter11 stringFromDate:date11];
            _datestring = [NSString stringWithFormat:@"%@",newDate11];
            
            cell.tripcell.text =_datestring;
            
            NSDictionary *dic555=[completeArray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic4 [@"no_of_days"]);
            NSString *nodaystring11=[dic555 objectForKey:@"no_of_days"];
            cell.totaldaycell.text =nodaystring11;
            
            
            NSDictionary *dic666=[completeArray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic5 [@"end_of_journey"]);
            NSString *datestring33=[dic666 objectForKey:@"end_of_journey"];
            
            NSDateFormatter *formatter22 = [[NSDateFormatter alloc] init];
            [formatter22 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
            NSDate *date22 = [formatter22 dateFromString:datestring33];
            [formatter22 setDateFormat:@"dd'-'MM'-'yyyy'"];
            NSString *newDate22 = [formatter22 stringFromDate:date22];
            _datestring1 = [NSString stringWithFormat:@"%@",newDate22];
            
            cell.enddatecell.text =_datestring1;
            cell.enddatecell.hidden=YES;
            
            NSDictionary *dic777=[completeArray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic6 [@"pickup_time"]);
            NSString *datestring66=[dic777 objectForKey:@"pickup_time"];
            
            NSDateFormatter *formatter33 = [[NSDateFormatter alloc] init];
            [formatter33 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
            NSDate *date33 = [formatter33 dateFromString:datestring66];
            [formatter33 setDateFormat:@"HH:mm"];
            NSString *newDate33 = [formatter33 stringFromDate:date33];
            _pickstring = [NSString stringWithFormat:@"%@",newDate33];
            
            cell.picktimecell.text =_pickstring;
            cell.picktimecell.hidden=YES;
            
            NSDictionary *dic888=[completeArray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic7 [@"pickup_time"]);
            NSString *datestring44=[dic888 objectForKey:@"pickup_time"];
            
            NSDateFormatter *formatter44 = [[NSDateFormatter alloc] init];
            [formatter44 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
            NSDate *date44 = [formatter44 dateFromString:datestring44];
            [formatter44 setDateFormat:@"HH:mm"];
            NSString *newDate44 = [formatter44 stringFromDate:date44];
            _dropstring = [NSString stringWithFormat:@"%@",newDate44];
            
            cell.droptimecell.text =_pickstring;
            cell.droptimecell.hidden=YES;

            NSDictionary *dic999=[completeArray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic999 [@"Base_Fare"]);
            NSString *bookstring111=[NSString stringWithFormat:@"%d", [dic999 [@"Base_Fare"] intValue]];
            cell.basefarecell.text =bookstring111;
            cell.basefarecell.hidden=YES;
            
            NSDictionary *dic1010=[completeArray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic1010 [@"Night_Charges"]);
            NSString *bookstring222=[NSString stringWithFormat:@"%d", [dic1010 [@"Night_Charges"] intValue]];
            cell.nighcell.text =bookstring222;
            cell.nighcell.hidden=YES;

            NSDictionary *dic1111=[completeArray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic1111 [@"service_tax"]);
            NSString *bookstring333=[NSString stringWithFormat:@"%d", [dic1111 [@"service_tax"] intValue]];
            cell.servicecell.text =bookstring333;
            cell.servicecell.hidden=YES;

            NSDictionary *dic1212=[completeArray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic1212 [@"final_Amount"]);
            NSString *bookstring444=[NSString stringWithFormat:@"%d", [dic1212 [@"final_Amount"] intValue]];
            cell.totalamontcell.text =bookstring444;
            cell.totalamontcell.hidden=YES;

            NSDictionary *dic1313=[completeArray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic1313 [@"swachh_bharat"]);
            NSString *bookstring555=[NSString stringWithFormat:@"%d", [dic1313 [@"swachh_bharat"] intValue]];
            cell.swachhcell.text =bookstring555;
            cell.swachhcell.hidden=YES;

            NSDictionary *dic1414=[completeArray objectAtIndex:indexPath.row];
            NSLog(@"%@", dic1414 [@"krishi_kalyan"]);
            NSString *bookstring666=[NSString stringWithFormat:@"%d", [dic1414 [@"krishi_kalyan"] intValue]];
            cell.krichcell.text =bookstring666;
            cell.krichcell.hidden=YES;
            
            NSDictionary *special=[completeArray objectAtIndex:indexPath.row];
            NSLog(@"%@", special [@"booking_type"]);
            NSString *spclstring=[special objectForKey:@"booking_type"];
            NSString *bookstring1=[NSString stringWithFormat:@"%d", [special [@"booking_id"] intValue]];
            
            if([spclstring isEqualToString:@"0"])
            {
                cell.specialbookid.text=bookstring1;
                cell.bookidcell.hidden=YES;
                cell.totaldaycell.hidden=YES;
                cell.booklab.hidden=YES;
                cell.totaldaylab.hidden=YES;
                cell.sepecialreqlab.hidden=NO;
                cell.specialbookid.hidden=NO;
                cell.paymentstutslab.hidden=NO;
                cell.advancepaymetlab.hidden=NO;
            }else if([spclstring isEqualToString:@"1"])
            {
                cell.sepecialreqlab.hidden=YES;
                cell.specialbookid.hidden=YES;
                cell.paymentstutslab.hidden=YES;
                cell.advancepaymetlab.hidden=YES;
                cell.bookidcell.hidden=NO;
                cell.totaldaycell.hidden=NO;
                cell.booklab.hidden=NO;
                cell.totaldaylab.hidden=NO;
            }
            
            NSDictionary *special1=[completeArray objectAtIndex:indexPath.row];
            NSLog(@"%@", special1 [@"sp_status"]);
            NSString *spclstring2=[special1 objectForKey:@"sp_status"];
            
            if([spclstring2 isEqualToString:@"0"])
            {
                cell.paymentstutslab.text=@"Completed";
                
            }else{
                
            }

            
            NSDictionary *special2=[completeArray objectAtIndex:indexPath.row];
            NSLog(@"%@", special2 [@"payment_mode"]);
           NSString *spclstring3 = [[special2 objectForKey:@"payment_mode"] stringValue];
            
            if([spclstring3 isEqualToString:@"0"])
            {
                cell.paymentstutslab.text=@"Completed";
                
            }else if ([spclstring3 isEqualToString:@"1"])
            {
                cell.paymentstutslab.text=@"Pending";
                cell.paymentstutslab.textColor=[UIColor redColor];
            }
            

            
            
            

            break;
        }
        case 3:
        {
            NSString *stu1=@"CANCELLED";
            cell.stuslab.text=stu1;
            cell.stuslab.textColor =[UIColor colorWithRed:(252/255.0) green:(38/255.0) blue:(38/255.0) alpha:1];
            
            dic11 = [cancelArray objectAtIndex:indexPath.row];
            
            NSString *jsonImageUrlString = [dic11 objectForKey:@"vehicle_image"];
            
            NSURL *imageURL = [NSURL URLWithString:jsonImageUrlString];
            
            [cell.imagecell sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"sedan_car.png"]];
            
            NSDictionary *reg=[cancelArray objectAtIndex:indexPath.row];
            NSLog(@"%@", reg [@"booking_id"]);
            NSString *bookstring=[NSString stringWithFormat:@"%d", [reg [@"booking_id"] intValue]];
            cell.bookidcell.text =bookstring;
            
            NSDictionary *reg1=[cancelArray objectAtIndex:indexPath.row];
            NSLog(@"%@", reg1 [@"place_to_visit"]);
            NSString *placestring=[reg1 objectForKey:@"place_to_visit"];
            
            cell.placecell.text =placestring;
             [cell.placecell resizeToFit];
            
            NSDictionary *reg2=[cancelArray objectAtIndex:indexPath.row];
            NSLog(@"%@", reg2 [@"date_of_journey"]);
            NSString *datestring2=[reg2 objectForKey:@"date_of_journey"];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
            NSDate *date = [formatter dateFromString:datestring2];
            [formatter setDateFormat:@"dd'-'MM'-'yyyy'"];
            NSString *newDate = [formatter stringFromDate:date];
            _datestring = [NSString stringWithFormat:@"%@",newDate];
            
            cell.tripcell.text =_datestring;
            
            NSDictionary *reg3=[cancelArray objectAtIndex:indexPath.row];
            NSLog(@"%@", reg3 [@"no_of_days"]);
            NSString *nodaystring=[reg3 objectForKey:@"no_of_days"];
            cell.totaldaycell.text =nodaystring;
            
            
            NSDictionary *reg4=[cancelArray objectAtIndex:indexPath.row];
            NSLog(@"%@", reg4 [@"end_of_journey"]);
            NSString *datestring3=[reg4 objectForKey:@"end_of_journey"];
            
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            [formatter1 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
            NSDate *date1 = [formatter1 dateFromString:datestring3];
            [formatter1 setDateFormat:@"dd'-'MM'-'yyyy'"];
            NSString *newDate1 = [formatter stringFromDate:date1];
            _datestring1 = [NSString stringWithFormat:@"%@",newDate1];
            
            cell.enddatecell.text =_datestring1;
            cell.enddatecell.hidden=YES;
            
            NSDictionary *reg5=[cancelArray objectAtIndex:indexPath.row];
            NSLog(@"%@", reg5 [@"pickup_time"]);
            NSString *datestring4=[reg5 objectForKey:@"pickup_time"];
            
            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
            [formatter2 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
            NSDate *date2 = [formatter2 dateFromString:datestring4];
            [formatter2 setDateFormat:@"HH:mm"];
            NSString *newDate2 = [formatter2 stringFromDate:date2];
            _pickstring = [NSString stringWithFormat:@"%@",newDate2];
            
            cell.picktimecell.text =_pickstring;
            cell.picktimecell.hidden=YES;
            
            NSDictionary *reg6=[cancelArray objectAtIndex:indexPath.row];
            NSLog(@"%@", reg6 [@"pickup_time"]);
            NSString *datestring5=[reg6 objectForKey:@"pickup_time"];
            
            NSDateFormatter *formatter3 = [[NSDateFormatter alloc] init];
            [formatter3 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
            NSDate *date3 = [formatter3 dateFromString:datestring5];
            [formatter3 setDateFormat:@"HH:mm"];
            NSString *newDate3 = [formatter3 stringFromDate:date3];
            _dropstring = [NSString stringWithFormat:@"%@",newDate3];
            
            cell.droptimecell.text =_pickstring;
            cell.droptimecell.hidden=YES;
            
            
            NSDictionary *special=[cancelArray objectAtIndex:indexPath.row];
            NSLog(@"%@", special [@"booking_type"]);
            NSString *spclstring=[special objectForKey:@"booking_type"];
            NSString *bookstring1=[NSString stringWithFormat:@"%d", [special [@"booking_id"] intValue]];
            
            if([spclstring isEqualToString:@"0"])
            {
                cell.specialbookid.text=bookstring1;
                cell.bookidcell.hidden=YES;
                cell.totaldaycell.hidden=YES;
                cell.booklab.hidden=YES;
                cell.totaldaylab.hidden=YES;
                cell.sepecialreqlab.hidden=NO;
                cell.specialbookid.hidden=NO;
                cell.paymentstutslab.hidden=YES;
                cell.advancepaymetlab.hidden=YES;
            }else if([spclstring isEqualToString:@"1"])
            {
                cell.sepecialreqlab.hidden=YES;
                cell.specialbookid.hidden=YES;
                cell.paymentstutslab.hidden=YES;
                cell.advancepaymetlab.hidden=YES;
                cell.bookidcell.hidden=NO;
                cell.totaldaycell.hidden=NO;
                cell.booklab.hidden=NO;
                cell.totaldaylab.hidden=NO;
            }
           
            
            NSDictionary *special1=[cancelArray objectAtIndex:indexPath.row];
            NSLog(@"%@spppp", special1 [@"sp_status"]);
            NSString *spclstring2=[special1 objectForKey:@"sp_status"];
            
            if([spclstring2 isEqualToString:@"0"])
            {
                cell.paymentstutslab.text=@"Completed";
                
            }else{
                
            }

            
            break;
            
        }
        default:
            break;
            
    }
    



    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    switch (self.segmentcontroller.selectedSegmentIndex) {
        case 0:
        {
            UpcomingViewController *destViewController= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UpcomingViewController"];
           
                
                destViewController.passbookid = [NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"booking_id"]];
                destViewController.passtittle = [NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"place_to_visit"]];
                destViewController.passvehicalmodel = [NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"vehicle_modle_Name"]];
                destViewController.passaddress = [NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"pickup_address"]];
                destViewController.passlocation = [NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"location"]];
                destViewController.passpincode = [NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"pincode"]];
                destViewController.passpickdate = _datestring;
                destViewController.passpicktime = _pickstring;
                destViewController.passdropdate = _datestring1;
                destViewController.passdroptime = _dropstring;
                destViewController.passbooktype=[NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"booking_type"]];
            destViewController.passbookbasefare=[NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"s_basefair"]];
            destViewController.passbookadvancpaid=[NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"s_advanced_payment"]];
            destViewController.passbookminkm=[NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"s_minkm"]];
            destViewController.passbookduepayment=[NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"s_duepayment"]];
            destViewController.passbookdiscount=[NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"s_discount"]];
                [self.navigationController pushViewController:destViewController animated:YES];

            }
            
        
            break;
        case 1:
        {
            LiveDetailsViewController *destViewController= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LiveDetailsViewController"];
            

               
                destViewController.passbookid1 = [NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"booking_id"]];
                destViewController.passtittle1 = [NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"place_to_visit"]];
                destViewController.passvehicalmodel1 = [NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"vehicle_modle_Name"]];
                destViewController.passaddress1 = [NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"pickup_address"]];
                
                destViewController.passpincode1 = [NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"pincode"]];
                destViewController.passdrivername1 = [NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"driver_name"]];
                destViewController.passdrivercontact1 = [NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"driver_mobile"]];
                destViewController.passpickdate1 = _datestring;
                destViewController.passpicktime1 = _pickstring;
                destViewController.passdropdate1 = _datestring1;
                destViewController.passdroptime1 = _dropstring;
            
            destViewController.passbooktype=[NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"booking_type"]];
            destViewController.passbookbasefare=[NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"s_basefair"]];
            destViewController.passbookadvancpaid=[NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"s_advanced_payment"]];
            destViewController.passbookminkm=[NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"s_minkm"]];
            destViewController.passbookduepayment=[NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"s_duepayment"]];
            destViewController.passbookdiscount=[NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"s_discount"]];

            [self.navigationController pushViewController:destViewController animated:YES];

                
            }
            break;
        case 2:
        {
            completedViewController1 *destViewController= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"completedViewController1"];
            
            
            destViewController.passbookid2 = [NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"booking_id"]];
            destViewController.passtittle2 = [NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"place_to_visit"]];
            destViewController.passvehicalmodel2 = [NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"vehicle_modle_Name"]];
            destViewController.passaddress2 = [NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"pickup_address"]];
            destViewController.passlocation2 = [NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"location"]];
            destViewController.passpincode2 = [NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"pincode"]];
            destViewController.passpickdate2 = _datestring;
            destViewController.passpicktime2 = _pickstring;

            destViewController.passdropdate2 = _datestring1;
            destViewController.passdroptime2 = _dropstring;

            destViewController.passbasefare=  [NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"Base_Fare"]];
            destViewController.passnightcharges=  [NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"Night_Charges"]];
            destViewController.passservicelab=  [NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"service_tax"]];
            destViewController.passtotalfare=  [NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"final_Amount"]];
            destViewController.passswatchh=  [NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"swachh_bharat"]];
            destViewController.passkrishtax=  [NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"krishi_kalyan"]];
            destViewController.passstrip=  [NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"refral_discount"]];
            destViewController.passrefullcharge=  [NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"Refuel_Charges"]];
            destViewController.passdiscount=  [NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"discount"]];
            
            
            destViewController.passbooktype=[NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"booking_type"]];
            destViewController.passbookbasefare=[NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"s_basefair"]];
            destViewController.passbookadvancpaid=[NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"s_advanced_payment"]];
            destViewController.passbookminkm=[NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"s_minkm"]];
            destViewController.passbookduepayment=[NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"s_duepayment"]];
            destViewController.passbookdiscount=[NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"s_discount"]];
            destViewController.passbooklatecharges=[NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"Late_Charges"]];
            destViewController.passbooktotalreading=[NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"Total_Reading"]];
             destViewController.passpaymentstuts=[NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"payment_mode"]];
            destViewController.passwallet=[NSString stringWithFormat:@"%@", self.completeArray[indexPath.row][@"cal_wallet"]];
            destViewController.Useridpass=_userid;
            [self.navigationController pushViewController:destViewController animated:YES];
            
        }
            break;
        case 3:
        {
            cancelViewController *destViewController= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"cancelViewController"];
            
            
            destViewController.passbookid = [NSString stringWithFormat:@"%@", self.cancelArray[indexPath.row][@"booking_id"]];
            destViewController.passtittle = [NSString stringWithFormat:@"%@", self.cancelArray[indexPath.row][@"place_to_visit"]];
            destViewController.passvehicalmodel = [NSString stringWithFormat:@"%@", self.cancelArray[indexPath.row][@"vehicle_modle_Name"]];
            destViewController.passaddress = [NSString stringWithFormat:@"%@", self.cancelArray[indexPath.row][@"pickup_address"]];
            destViewController.passlocation = [NSString stringWithFormat:@"%@", self.cancelArray[indexPath.row][@"location"]];
            destViewController.passpincode = [NSString stringWithFormat:@"%@", self.cancelArray[indexPath.row][@"pincode"]];
            destViewController.passpickdate = _datestring;
            destViewController.passpicktime = _pickstring;
            destViewController.passdropdate = _datestring1;
            destViewController.passdroptime = _dropstring;
            [self.navigationController pushViewController:destViewController animated:YES];

        }
            break;
        default:
            break;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //[profileArray removeAllObjects];
//    switch (self.segmentcontroller.selectedSegmentIndex) {
//        case 0:
//        {
//            if ([segue.identifier isEqualToString:@"upcomingdetails"]) {
//                NSIndexPath *indexPath = [self.tablview indexPathForSelectedRow];
//                UpcomingViewController *destViewController = segue.destinationViewController;
//                
//                destViewController.passbookid = [NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"booking_id"]];
//                destViewController.passtittle = [NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"place_to_visit"]];
//                destViewController.passvehicalmodel = [NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"vehicle_modle_Name"]];
//                destViewController.passaddress = [NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"pickup_address"]];
//                destViewController.passlocation = [NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"location"]];
//                destViewController.passpincode = [NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"pincode"]];
//                destViewController.passpickdate = _datestring;
//                destViewController.passpicktime = _pickstring;
//                destViewController.passdropdate = _datestring1;
//                destViewController.passdroptime = _dropstring;
//            }
//
//        }
//            break;
//        case 1:
//        {
//            if ([segue.identifier isEqualToString:@"Livedetails"]) {
//                NSIndexPath *indexPath = [self.tablview indexPathForSelectedRow];
//                
//                
//                
//                LiveDetailsViewController *destViewController = segue.destinationViewController;
//                destViewController.passbookid1 = [NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"booking_id"]];
//                destViewController.passtittle1 = [NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"place_to_visit"]];
//                destViewController.passvehicalmodel1 = [NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"vehicle_modle_Name"]];
//                destViewController.passaddress1 = [NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"pickup_address"]];
//                
//                destViewController.passpincode1 = [NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"pincode"]];
//                destViewController.passdrivername1 = [NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"driver_name"]];
//                destViewController.passdrivercontact1 = [NSString stringWithFormat:@"%@", self.livearray[indexPath.row][@"driver_mobile"]];
//                destViewController.passpickdate1 = _datestring;
//                destViewController.passpicktime1 = _pickstring;
//                destViewController.passdropdate1 = _datestring1;
//                destViewController.passdroptime1 = _dropstring;
//                
//            }
//
//        }
//        break;
//        default:
//            break;
//    }
//
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)segmentctrclick:(id)sender {
    
   
    if(_segmentcontroller.selectedSegmentIndex == 0)
    {
         _imag1.hidden=NO;
        _imag2.hidden=YES;
        _imag3.hidden=YES;
        _imag4.hidden=YES;
        //[self upcomingwebservices];
               [self.tablview reloadData];

    }
    else if(_segmentcontroller.selectedSegmentIndex == 1)
    {
        _imag2.hidden=NO;
        _imag1.hidden=YES;
        _imag3.hidden=YES;
        _imag4.hidden=YES;
               [self.tablview reloadData];
    
    }
    else if(_segmentcontroller.selectedSegmentIndex == 2)
    {
        _imag3.hidden=NO;
        _imag1.hidden=YES;
        _imag2.hidden=YES;
        _imag4.hidden=YES;
        
        [self.tablview reloadData];
        
    }
    else if(_segmentcontroller.selectedSegmentIndex == 3)
    {
        _imag4.hidden=NO;
        _imag1.hidden=YES;
        _imag2.hidden=YES;
        _imag3.hidden=YES;
        
        [self.tablview reloadData];
        
    }
   
}
@end
