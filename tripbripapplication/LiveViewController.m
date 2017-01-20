//
//  LiveViewController.m
//  tripbripapplication
//
//  Created by mac on 11/13/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "LiveViewController.h"
#import "completedViewController.h"
#import "cancelViewController.h"
#import "historyDetailsTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DBManager.h"
#import "UpcomingViewController.h"
#import "LiveDetailsViewController.h"
@interface LiveViewController ()
@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation LiveViewController
@synthesize historyarray,tableview,upcomingArray,upcomingdictionary,profileArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    upcomingArray=[[NSMutableArray alloc]init];
    profileArray=[[NSMutableArray alloc]init];
    self.tableview.delegate=self;
    [self selectUserID];
    [self Livewebservices];
    [self.tableview reloadData];

    // Do any additional setup after loading the view.
}
-(void)Livewebservices{
    NSInteger success = 0;
    @try {
        
        NSString *tag=@"upcoming";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&user_id=%@",tag,_userid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/user_live_booking_ios.php"];
        
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
            NSMutableDictionary *reultsDict = [NSMutableDictionary new];
            
            if ([upcomingdictionary objectForKey:@"result"]) {
                reultsArray=[upcomingdictionary objectForKey:@"result"];
            }
            
            
            for (NSDictionary *dic in reultsArray) {
                
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
                
                
                if ([[reultsDict allKeys] count] > 0) {
                    [upcomingArray addObject:reultsDict];
                }
                
            }
            
            success = [upcomingdictionary[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 0)
            {
                
                NSLog(@"Login SUCCESS");
                
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [upcomingArray count];
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"livecell";
    
    
    historyDetailsTableViewCell *cell = (historyDetailsTableViewCell *)[tableview dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"historydetails" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    NSDictionary *dict = [upcomingArray objectAtIndex:indexPath.row];
    
    NSString *jsonImageUrlString = [dict objectForKey:@"vehicle_image"];
    
    NSURL *imageURL = [NSURL URLWithString:jsonImageUrlString];
    
    [cell.imagecell sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"image1.jpg"]];
    
    NSDictionary *reg=[upcomingArray objectAtIndex:indexPath.row];
    NSLog(@"%@", reg [@"booking_id"]);
    NSString *bookstring=[NSString stringWithFormat:@"%d", [reg [@"booking_id"] intValue]];
    cell.bookidcell.text =bookstring;
    
    NSDictionary *reg1=[upcomingArray objectAtIndex:indexPath.row];
    NSLog(@"%@", reg1 [@"place_to_visit"]);
    NSString *placestring=[reg1 objectForKey:@"place_to_visit"];
    
    cell.placecell.text =placestring;
    
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
    
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"Livedetails"]) {
        NSIndexPath *indexPath = [self.tableview indexPathForSelectedRow];
        
        
        
        LiveDetailsViewController *destViewController = segue.destinationViewController;
        //        [profileArray addObject:[[upcomingArray objectAtIndex:indexPath.row] objectForKey:@"booking_id"]];
        //        [profileArray addObject:[[upcomingArray objectAtIndex:indexPath.row] objectForKey:@"Vehicle_Model_id"]];
        //        [profileArray addObject:[[upcomingArray objectAtIndex:indexPath.row] objectForKey:@"pickup_address"]];
        //        [profileArray addObject:[[upcomingArray objectAtIndex:indexPath.row] objectForKey:@"location"]];
        //        [profileArray addObject:[[upcomingArray objectAtIndex:indexPath.row] objectForKey:@"pincode"]];
        //        [profileArray addObject:[[upcomingArray objectAtIndex:indexPath.row] objectForKey:@"date_of_journey"]];
        //        [profileArray addObject:[[upcomingArray objectAtIndex:indexPath.row] objectForKey:@"pickup_time"]];
        //        [profileArray addObject:[[upcomingArray objectAtIndex:indexPath.row] objectForKey:@"end_of_journey"]];
        //        [profileArray addObject:[[upcomingArray objectAtIndex:indexPath.row] objectForKey:@"pickup_time"]];
        
//        destViewController.passbookid = [NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"booking_id"]];
//        destViewController.passtittle = [NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"place_to_visit"]];
//        destViewController.passvehicalmodel = [NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"vehicle_modle_Name"]];
//        destViewController.passaddress = [NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"pickup_address"]];
//       
//        destViewController.passpincode = [NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"pincode"]];
//        destViewController.passdrivername = [NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"driver_name"]];
//        destViewController.passdrivercontact = [NSString stringWithFormat:@"%@", self.upcomingArray[indexPath.row][@"driver_mobile"]];
//        destViewController.passpickdate = _datestring;
//        destViewController.passpicktime = _pickstring;
//        destViewController.passdropdate = _datestring1;
//        destViewController.passdroptime = _dropstring;
        
    }
    

    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)segmentctrlclick:(id)sender {
   
}
@end
