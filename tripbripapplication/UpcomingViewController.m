//
//  UpcomingViewController.m
//  tripbripapplication
//
//  Created by mac on 11/12/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "UpcomingViewController.h"
#import "cancelViewController.h"
#import "DashbordViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "UILabel+UILabel_dynamicSizeMe.h"
@interface UpcomingViewController ()

@end

@implementation UpcomingViewController
@synthesize dataArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    [_scrollview setShowsVerticalScrollIndicator:NO];
//    CGRect contentRect = CGRectZero;
//    for (UIView *view in self.scrollview.subviews) {
//        contentRect = CGRectUnion(contentRect, view.frame);
//    }
//    self.scrollview.contentSize = contentRect.size;
  self.scrollview.contentSize =CGSizeMake(_scrollview.bounds.size.width, 700);
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
    
    
    self.navigationItem.title=[NSString stringWithFormat:@"Booking ID %@",_passbookid];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.pickupaddlab resizeToFit];
    self.titlelab.text=_passtittle;
    self.labbookingid.text=_passbookid;
    self.vehicallab.text=_passvehicalmodel;
    self.pickupaddlab.text=_passaddress;
    self.locatioinlab.text=_passlocation;
    self.pincodelab.text=_passpincode;
    self.pickdatelab.text=_passpickdate;
    self.picktimelab.text=_passpicktime;
    self.dropdatelab.text=_passdropdate;
    self.droptimelab.text=_passdroptime;

    NSString *datestring2=_passpickdate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
    NSDate *date = [formatter dateFromString:datestring2];
    [formatter setDateFormat:@"dd'-'MM'-'yyyy'"];
    NSString *newDate = [formatter stringFromDate:date];
    _formatstring = [NSString stringWithFormat:@"%@",newDate];
      
    NSString *datestring3=_passpickdate;
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
    NSDate *date1 = [formatter1 dateFromString:datestring3];
    [formatter setDateFormat:@"dd'-'MM'-'yyyy'"];
    NSString *newDate1 = [formatter1 stringFromDate:date1];
    _formatstring = [NSString stringWithFormat:@"%@",newDate1];
    
    _basefare.text=_passbookbasefare;
    _advancepaid.text=_passbookadvancpaid;
    _minkm.text=_passbookminkm;
    _duepayment.text=_passbookduepayment;
    _discount.text=_passbookdiscount;
    if([_basefare.text isEqualToString:@"0"])
    {
        _basefare.hidden=YES;
        _basefarelab.hidden=YES;
    }
    if([_advancepaid.text isEqualToString:@"0"])
    {
        _advancepaid.hidden=YES;
        _advancelab.hidden=YES;
    }
    if([_minkm.text isEqualToString:@"0"])
    {
        _minkm.hidden=YES;
        _minkmlab.hidden=YES;
    }
    if([_duepayment.text isEqualToString:@"0"])
    {
        _duepayment.hidden=YES;
        _duepaymentlab.hidden=YES;
    }
    if([_discount.text isEqualToString:@"0"])
    {
        _discount.hidden=YES;
        _dicountlab.hidden=YES;
    }
    
    if([_passbooktype isEqualToString:@"0"])
    {
        _view1.hidden=NO;
        
    }else if([_passbooktype isEqualToString:@"1"])
    {
        _view1.hidden=YES;

    }
    
    //dataArray=[[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view.
}
-(void)cancelbookwebservices
{
    
        NSInteger success = 0;
        @try {
            
            
                NSString *tag=@"Login";
                NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&booking_id=%@",tag,_passbookid];
                NSLog(@"PostData: %@",post);
                
                NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/user_cancel_booking_ios.php"];
                
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
                
                NSError *error = [[NSError alloc] init];
                NSHTTPURLResponse *response = nil;
                NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                NSLog(@"response%@",response);
                NSLog(@"Response code: %ld", (long)[response statusCode]);
                
                if ([response statusCode] >= 200 && [response statusCode] < 300)
                {
                    NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                    NSLog(@"Response ==> %@", responseData);
                    
                    NSError *error = nil;
                    NSMutableDictionary *jsonData = [NSJSONSerialization
                                                     JSONObjectWithData:urlData
                                                     options:NSJSONReadingMutableContainers
                                                     error:&error];
                    NSLog(@"%@jjjj",jsonData);
                    
                    NSDictionary *dic =[jsonData objectForKey:@"result"];
                    
                    
                    
                    success = [jsonData[@"success"] integerValue];
                    NSLog(@"Success: %ld",(long)success);
                    
                    
                    if(success == 1)
                    {
                        NSLog(@"Login SUCCESS");
                        [self alertStatus:@"" :@"Your Booking Cancelled Successfully!" :0];
                        
                        DashbordViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DashbordViewController"];
                        [self.navigationController pushViewController:vc animated:YES];

                    }
                    else if (success == 0)
                    {
                        
                    
                } else {
                    //if (error) NSLog(@"Error: %@", error);
                    // [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
                }
            }
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

- (IBAction)phonecall:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:2249421122"]];
}

- (IBAction)cancelbookbuttonclick:(id)sender {
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:@"Are you sure want to Cancel Booking?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                                    
                                    
                                    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            [self cancelbookwebservices];
                                            [hud hideAnimated:YES];
                                        });
                                        
                                    });

                                    
                                    
                                    
                                   
                                                                        
                                    
                                }];
    [alert addAction:yesButton];
    UIAlertAction* nobutton = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   
                                   //Handel your yes please button action here
                                   
                                   
                               }];
    [alert addAction:nobutton];
    [self presentViewController:alert animated:YES completion:nil];
    }

- (IBAction)backbuttonclick:(id)sender {
}
@end
