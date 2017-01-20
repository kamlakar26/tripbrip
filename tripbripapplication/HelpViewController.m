//
//  HelpViewController.m
//  tripbripapplication
//
//  Created by mac on 1/5/17.
//  Copyright © 2017 mac. All rights reserved.
//

#import "HelpViewController.h"
#import "ContactCollectionViewCell.h"
#import "DBManager.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "UILabel+UILabel_dynamicSizeMe.h"

@interface HelpViewController ()
{
      UICollectionViewFlowLayout *portraitLayout;
}
@property (nonatomic, strong) DBManager *dbManager;
@property(nonatomic,retain)NSArray *BuyerIdArray;
@property(nonatomic,retain)NSString *userid;
@property(nonatomic,retain)NSString *datestring;
@property(nonatomic,retain)NSString *datestring1;
@property(nonatomic,retain)NSString *pickstring;
@property(nonatomic,retain)NSString *dropstring;
@property(nonatomic,retain)NSString *bookingid;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"Contact Us";

    _emailbutton.layer.cornerRadius = 0.5 * _emailbutton.bounds.size.width;
    _callbutton.layer.cornerRadius = 0.5 * _callbutton.bounds.size.width;
    [self selectBuyerID];
    self.scrollview.contentSize =CGSizeMake(_scrollview.bounds.size.width, 800);
    [_scrollview setShowsVerticalScrollIndicator:NO];
    _contactarray=[[NSMutableArray alloc]init];
    _contactdictionry=[[NSDictionary alloc]init];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self Bookinghistorywebservies];
            [self.collectionview1 reloadData];
            [hud hideAnimated:YES];
        });
        
    });

    _collectionview1.delegate=self;
    _collectionview1.dataSource=self;
    // Do any additional setup after loading the view.
}
-(void)selectBuyerID{
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
    if (self.BuyerIdArray != nil) {
        self.BuyerIdArray = nil;
    }
    self.BuyerIdArray=[[NSMutableArray alloc]init];
    
    self.BuyerIdArray = [[NSMutableArray alloc]initWithArray:[self.dbManager loadDataFromDB:query26]];
    NSLog(@"total......%@",self.BuyerIdArray);
    _userid = [[self.BuyerIdArray objectAtIndex:0] objectAtIndex:0];
    
}
-(void)Bookinghistorywebservies{
    NSInteger success = 0;
    @try {
        
        NSString *tag=@"cancel";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&user_id=%@",tag,_userid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/user_cancel_booking_show_ios.php"];
        
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
            _contactdictionry = [NSJSONSerialization
                                  JSONObjectWithData:urlData
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
            NSMutableArray *reultsArray = [NSMutableArray new];
            
            
            if ([_contactdictionry objectForKey:@"result"]) {
                reultsArray=[_contactdictionry objectForKey:@"result"];
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
                if ([dic objectForKey:@"status"] != nil) {
                    
                    [reultsDict setObject:[dic objectForKey:@"status"] forKey:@"status"];
                    
                } else {
                    //NO NEED TO IMPLEMENT
                }
                
                
                if ([[reultsDict allKeys] count] > 0) {
                    [_contactarray addObject:reultsDict];
                }
                
            }
            
            success = [_contactdictionry[@"success"]integerValue];
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


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _contactarray.count;
    //return _carimagedata.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"collectioncell";
    
    ContactCollectionViewCell *cell = (ContactCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"collectioncell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
   
    
    NSDictionary *dic11 = [_contactarray objectAtIndex:indexPath.row];
    
    NSString *jsonImageUrlString = [dic11 objectForKey:@"vehicle_image"];
    
    NSURL *imageURL = [NSURL URLWithString:jsonImageUrlString];
    
    [cell.carimage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"sedan_car.png"]];
    
    NSDictionary *reg=[_contactarray objectAtIndex:indexPath.row];
    NSLog(@"%@", reg [@"booking_id"]);
    _bookingid=[NSString stringWithFormat:@"%d", [reg [@"booking_id"] intValue]];
    cell.bookid.text =_bookingid;
    
    NSDictionary *reg1=[_contactarray objectAtIndex:indexPath.row];
    NSLog(@"%@", reg1 [@"place_to_visit"]);
    NSString *placestring=[reg1 objectForKey:@"place_to_visit"];
    
    cell.placevitisit.text =placestring;
    [cell.bookid resizeToFit];
    //[cell.placevitisit.text resizeToFit];

    
    
    NSDictionary *reg2=[_contactarray objectAtIndex:indexPath.row];
    NSLog(@"%@", reg2 [@"date_of_journey"]);
    NSString *datestring2=[reg2 objectForKey:@"date_of_journey"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
    NSDate *date = [formatter dateFromString:datestring2];
    [formatter setDateFormat:@"dd'-'MM'-'yyyy'"];
    NSString *newDate = [formatter stringFromDate:date];
    _datestring = [NSString stringWithFormat:@"%@",newDate];
    
    cell.pickdate.text =_datestring;
    
    
    NSDictionary *reg4=[_contactarray objectAtIndex:indexPath.row];
    NSLog(@"%@", reg4 [@"end_of_journey"]);
    NSString *datestring3=[reg4 objectForKey:@"end_of_journey"];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
    NSDate *date1 = [formatter1 dateFromString:datestring3];
    [formatter1 setDateFormat:@"dd'-'MM'-'yyyy'"];
    NSString *newDate1 = [formatter stringFromDate:date1];
    _datestring1 = [NSString stringWithFormat:@"%@",newDate1];
    
    cell.dropdate.text =_datestring1;
    
    
    NSDictionary *reg5=[_contactarray objectAtIndex:indexPath.row];
    NSLog(@"%@", reg5 [@"pickup_time"]);
    NSString *datestring4=[reg5 objectForKey:@"pickup_time"];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
    NSDate *date2 = [formatter2 dateFromString:datestring4];
    [formatter2 setDateFormat:@"HH:mm"];
    NSString *newDate2 = [formatter2 stringFromDate:date2];
    _pickstring = [NSString stringWithFormat:@"%@",newDate2];
    
    cell.picktime.text =_pickstring;
    
    NSDictionary *reg6=[_contactarray objectAtIndex:indexPath.row];
    NSLog(@"%@", reg6 [@"pickup_time"]);
    NSString *datestring5=[reg6 objectForKey:@"pickup_time"];
    
    NSDateFormatter *formatter3 = [[NSDateFormatter alloc] init];
    [formatter3 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
    NSDate *date3 = [formatter3 dateFromString:datestring5];
    [formatter3 setDateFormat:@"HH:mm"];
    NSString *newDate3 = [formatter3 stringFromDate:date3];
    _dropstring = [NSString stringWithFormat:@"%@",newDate3];
    
    cell.droptime.text =_pickstring;
    
    NSDictionary *reg11=[_contactarray objectAtIndex:indexPath.row];
    NSLog(@"%@", reg11 [@"status"]);
    NSString *placestring1=[NSString stringWithFormat:@"%d", [reg11 [@"status"] intValue]];

    
    if([placestring1 isEqualToString:@"0"])
    {
        cell.satus.text=@"Cancelled";
    }
    if([placestring1 isEqualToString:@"1"])
     {
         cell.satus.text=@"Upcoming";
     }
    if([placestring1 isEqualToString:@"2"])
    {
        cell.satus.text=@"Live";
    }
    if([placestring1 isEqualToString:@"3"])
    {
        cell.satus.text=@"Completed";
    }
   
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize returnSize = CGSizeZero;
    
    if (collectionViewLayout == portraitLayout) {
        returnSize = CGSizeMake(320.0, 180.0);
    } else {
        returnSize = CGSizeMake(320.0, 180.0);
    }
    
    return returnSize;
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

- (IBAction)EMAILbuttonclicks:(id)sender {
    
    
    NSString *emailTitle = [NSString stringWithFormat:@"Booking ID - %@",_bookingid];
    // Email Content
    NSString *messageBody = @"Customer issues";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"Care@tripbrip.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)phonecallbutton:(id)sender {
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Call us on"
                                 message:@"02249421122"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Call"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:02249421122"]];
                                    //Handle your yes please button action here
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}
@end
