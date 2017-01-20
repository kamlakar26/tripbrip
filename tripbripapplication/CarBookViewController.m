//
//  CarBookViewController.m
//  tripbripapplication
//
//  Created by mac on 11/10/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "CarBookViewController.h"
#import "DBManager.h"
#import "BreakupViewController.h"
#import "HistoryDetailsViewController.h"
#import "DashbordViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "UILabel+UILabel_dynamicSizeMe.h"
@interface CarBookViewController ()
{
    int totalsub;
    int estimatedfare1;
}
@property (nonatomic, strong) DBManager *dbManager;
@property(nonatomic,retain)NSString *discountstring;
@property(nonatomic,retain)NSString *tripmoneystring;
@end

@implementation CarBookViewController
@synthesize modelstring,labmodel,statusArray,username,usercontactno,journeydate,dropdate,pickuptime,droptime,numofdays,address,placetovisit,farevehicle,promoarray,promodictionary,promocodetext,prolab;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.username resizeToFit];
    [self.placetovisit resizeToFit];
    _view1.hidden=YES;
    _successsbutton.hidden=YES;
    
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
    
    
    
    
    
    self.scrllview.contentSize =CGSizeMake(_scrllview.bounds.size.width, 900);
    
    //CGRect contentRect = CGRectZero;
    //for (UIView *view in self.scrllview.subviews) {
      //  contentRect = CGRectUnion(contentRect, view.frame);
    //}
    //self.scrllview.contentSize = contentRect.size;
    self.navigationItem.title=@"CONFIRMATION";
    self.subview.hidden=YES;
    [self knowStatusForuser];
    [self selectUserID];
    
    prolab.hidden=YES;
    
    NSString *string = [NSString stringWithFormat:@"%@",_passfarevehicle];
    int value = [string intValue];
    
    NSString *str4=[NSString stringWithFormat:@"%@",_passnumdays];
    int noofdays=[str4 intValue];

    
    NSString *string1=[NSString stringWithFormat:@"%@",_pperkimlomer];
    int value1 = [string1 intValue];
    
    int value11=value1 *noofdays;
    
    
    int tototbasefare = value * value11;
    
    NSLog(@"%dddd",tototbasefare);
    
    NSString *str=[NSString stringWithFormat:@"%@",_passnight];
    int nighvalue=[str intValue];
    
    
    int valuess= nighvalue *noofdays;
    
    NSString *str1=[NSString stringWithFormat:@"%@",_tripmoneystring];
    int tripmoney=[str1 intValue];
    
    if(tripmoney == 0)
    {
         totalsub= tototbasefare + valuess - tripmoney;
    }
    else if (tripmoney >= 1500)
    {
         totalsub= tototbasefare + valuess - 1500;
    }
    else{
        totalsub= tototbasefare + valuess - tripmoney;

    }
    
    
    
    
    
    
    
    NSLog(@"%dddd",totalsub);
    
    float services= totalsub * 5.6/100;
    float swatch = totalsub * 0.20/100;
    float krich = totalsub * 0.20/100;
    
    
    
    int totaltax = services + swatch + krich;
    
    NSLog(@"%dddd",totaltax);
    
    int estim = tototbasefare + valuess + totaltax;
    
    NSString *estimated=[NSString stringWithFormat:@"₹%d",estim];
    
    
    labmodel.text=modelstring;
    username.text=_registerTypeString;
    usercontactno.text=_registerTypeString1;
    journeydate.text=_passjouneydate;
    //dropdate.text=_passDropdate;
    pickuptime.text=_passpickuptime;
    droptime.text=_passdroptime;
    numofdays.text=_passnumdays;
    address.text=_passaddress;
    placetovisit.text=_passplacetovisit;
    farevehicle.text=[NSString stringWithFormat:@"₹%@",_passfarevehicle];
    _minkms.text=[NSString stringWithFormat:@"₹%d",value11];;
    dropdate.text=_passDropdate;
    _estimatedfare.text=estimated;
    _estimate2.text=estimated;
    _labtripmoney.text=[NSString stringWithFormat:@"₹%@",_tripmoneystring];
    _cartype.text=_PCartype;
    //_labdiscout.text=@"0";
    //_labdiscout.text=_discountstring;
    
    
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *date = [formatter dateFromString:_passjouneydate];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    NSString *newDate = [formatter stringFromDate:date];
    _datestring = [NSString stringWithFormat:@"%@",newDate];
    NSLog(@"%@ddd",_datestring);
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"dd-MM-yyyy"];
    NSDate *date1 = [formatter1 dateFromString:_passDropdate];
    [formatter1 setDateFormat:@"MM-dd-yyyy"];
    NSString *newDate1 = [formatter1 stringFromDate:date1];
    _datestring1 = [NSString stringWithFormat:@"%@",newDate1];
    NSLog(@"%@ddd",_datestring1);
    
    // Do any additional setup after loading the view.
}
-(void)knowStatusForuser{
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"trip.sqlite"];
    
    // Check if should load specific record for editing.
    
    NSString *queryav=[NSString stringWithFormat:@"SELECT fullname,mobileno,Satus3 from Logintable1"];
    [self.dbManager executeQuery:queryav];
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    self.statusArray = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:queryav]];
    _registerTypeString = [[self.statusArray objectAtIndex:0]objectAtIndex:0];
    _registerTypeString1 = [[self.statusArray objectAtIndex:0]objectAtIndex:1];
    _tripmoneystring = [[self.statusArray objectAtIndex:0]objectAtIndex:2];

    
    NSLog(@"%@",statusArray);
    NSLog(@"id%@",_registerTypeString);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Breakup"]) {
        
        BreakupViewController *destViewController = segue.destinationViewController;
        destViewController.passnightchargess =_passnight;
       destViewController.passbasefare =[NSString stringWithFormat:@"%@",_passfarevehicle];
        destViewController.passdiscount= _labdiscout.text;
        destViewController.passzero=_labdiscout.text;
        destViewController.passtripmoney=_tripmoneystring;
        destViewController.passnumberofdayssss=numofdays.text;
        destViewController.perkm=_pperkimlomer;
        destViewController.vehicleidcheck=_vehicleid;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
}
-(void)promocodewebservices{
    NSInteger success = 0;
    @try {
        
        NSString *tag=@"promocodes";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&promo_code=%@",tag,promocodetext.text];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/promocode.php"];
        
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
            promodictionary = [NSJSONSerialization
                                  JSONObjectWithData:urlData
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
            NSMutableArray *reultsArray = [NSMutableArray new];
            NSMutableDictionary *reultsDict = [NSMutableDictionary new];
            
            if ([promodictionary objectForKey:@"result"]) {
                reultsArray=[promodictionary objectForKey:@"result"];
            }
            
            
            for (NSDictionary *dic in reultsArray) {
                
                if ([dic objectForKey:@"amount"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"amount"] forKey:@"amount"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                _discountstring=[reultsDict objectForKey:@"amount"];
//                if ([[reultsDict allKeys] count] > 0) {
//                    [promoarray addObject:reultsDict];
//                    //[_array1 addObjectsFromArray:upcomingArray]
//                    NSLog(@"%@2222",promoarray);
//                    _discountstring=[promoarray valueForKey:@"amount"];
//                }
                
            }
            
            success = [promodictionary[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);

            if(success == 1)
            {
               promocodetext.enabled = NO;
                _view1.hidden=NO;
                _labfare.hidden=YES;
                _estimatedfare.hidden=YES;
                prolab.hidden=NO;
                prolab.textColor=[UIColor greenColor];
                prolab.text=@"Promo code Apply Successfully.";
                _successsbutton.hidden=NO;
                NSLog(@"SUCCESS");
                _labdiscout.text=[NSString stringWithFormat:@"₹%@",_discountstring];

                
                NSString *string = [NSString stringWithFormat:@"%@",_passfarevehicle];
                int value = [string intValue];
                
                NSString *string1=[NSString stringWithFormat:@"%@",_pperkimlomer];

                int value1 = [string1 intValue];
                
                
                NSString *str4=[NSString stringWithFormat:@"%@",_passnumdays];
                int noofdays=[str4 intValue];
                
                
                
                
                int value11=value1 *noofdays;

                
                
                
                
                int tototbasefare = value * value11;
                
                NSLog(@"%dddd",tototbasefare);
                
                NSString *str=[NSString stringWithFormat:@"%@",_passnight];
                int nighvalue=[str intValue];
                
                int value4=nighvalue*noofdays;
                
                 totalsub= tototbasefare + value4;
                
                NSString *dis=[NSString stringWithFormat:@"%@",_discountstring];
                int disco=[dis intValue];
                
                NSString *str1=[NSString stringWithFormat:@"%@",_tripmoneystring];
                int tripmoney=[str1 intValue];
                
                if(tripmoney == 0)
                {
                     estimatedfare1 = totalsub - disco-tripmoney;
                }
                else if (tripmoney >= 1500)
                {
                      estimatedfare1 = totalsub - disco-1500;
                }
                else{
                      estimatedfare1 = totalsub - disco-tripmoney;
                }

                
                              
                
                NSLog(@"%dddd",totalsub);
                
                float services= estimatedfare1 * 5.6/100;
                float swatch = estimatedfare1 * 0.20/100;
                float krich = estimatedfare1 * 0.20/100;
                
                
                
                int totaltax = services + swatch + krich + estimatedfare1;
                
                NSLog(@"%dddd",totaltax);
                
                //    int estim = tototbasefare + nighvalue + totaltax;
                //    
                NSString *estimated=[NSString stringWithFormat:@"₹%d",totaltax];
                
                //_estimatedfare.text=estimated;
                _estimate2.text=estimated;
                _applypromobutton.hidden=YES;

                
            }
            if(success == 0)
            {
                 //promocodetext.text=@"";
                prolab.hidden=NO;
                prolab.textColor=[UIColor redColor];
                prolab.text=@"Invalid PromoCode.!!";
                _applypromobutton.hidden=NO;

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



- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
    
    
    
}

- (IBAction)applypromocodebuttonclick:(id)sender {
    [self promocodewebservices];
   
      }


- (IBAction)breakupamontclick:(id)sender {
    
    
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

-(void)BookACarWebservices{
    NSInteger success = 0;
    @try {
        
        NSString *tag=@"bookacar";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&user_id=%@&Vehicle_Model_id=%@&date_of_journey=%@&pickup_time=%@&no_of_days=%@&end_of_journey=%@&pickup_address=%@&pincode=%@&place_to_visit=%@&location=%@",tag,_userid,_modelid,_datestring,_passpickuptime,_passnumdays,_datestring1,_passaddress1,_passpincode,_passplacetovisit,_passlocation];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi_test/user_booking_new_ios.php"];
        
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
            promodictionary = [NSJSONSerialization
                               JSONObjectWithData:urlData
                               options:NSJSONReadingMutableContainers
                               error:&error];
            
            NSDictionary *req=[promodictionary objectForKey:@"result"];
            
            _bookingid=[req objectForKey:@"booking_id"];
            
            success = [promodictionary[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 1)
            {
               [self alertStatus:@"BOOKING SUCCESS" :@"" :0];
               DashbordViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DashbordViewController"];
                   [self.navigationController pushViewController:vc animated:YES];
                
                NSLog(@"SUCCESS");
                
            }
            if(success == 0)
            {
                
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



- (IBAction)bookbuttonclick:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self BookACarWebservices];
            [hud hideAnimated:YES];
        });
        
    });

   
}

- (IBAction)tapclick:(id)sender {
    NSLog(@"hiii.....");
    [self.view endEditing:YES];

}
- (IBAction)successbuttonclick:(id)sender {
    _applypromobutton.hidden=NO;
    _successsbutton.hidden=YES;
    _view1.hidden=YES;
    _labfare.hidden=NO;
    _estimatedfare.hidden=NO;
    promocodetext.text=@"";
    prolab.hidden=YES;
    promocodetext.enabled = YES;
    _labdiscout.text=@"0";
    
    
    
    
}
@end
