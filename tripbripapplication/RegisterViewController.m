//
//  RegisterViewController.m
//  tripbripapplication
//
//  Created by mac on 10/15/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "RegisterViewController.h"
#import "DBManager.h"
#import "LoginScreenViewController.h"
#import <MessageUI/MFMessageComposeViewController.h>
//#import "IQKeyboardManager.h"
#import "Reachability.h"
@interface RegisterViewController ()
{
    int randomID ;
    NSMutableData * responseData;
    NSURLConnection * connection;

    
}
@property (nonatomic, strong) DBManager *dbManager;
@property(nonatomic,retain)NSString *otpmessage;
;
@end

@implementation RegisterViewController
@synthesize fullnameuser,emailiduser,passworduser,mobilenouser,referralcodeuser,otpstring;
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
    ////////////////////////////////
    
    //referralcodeuser.hidden=YES;
self.scrlview.contentSize =CGSizeMake(_scrlview.bounds.size.width, 800);
    
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)checkemailmobileWebService{
    NSInteger success = 0;
    @try {
        
        NSString *post =[[NSString alloc] initWithFormat:@"email=%@&mobile=%@",[self.emailiduser text],[self.mobilenouser text]];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/check_mobile_email.php"];
        
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
            NSMutableDictionary *jsonData1 = [NSJSONSerialization
                                              JSONObjectWithData:urlData
                                              options:NSJSONReadingMutableContainers
                                              error:&error];
            
            NSArray *result=[jsonData1 objectForKey:@"result"];
            
            // NSLog(@"%@jjjj",jsonData1);
            
            
            
            success = [jsonData1[@"success"] integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 1)
            {
                
                [self UniqueRandom];
       
            }
            if(success == 2)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello"
                                                                    message:@"You have Mobile no Already Exits !!"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil, nil];
                //alertView.tag = tag;
                [alertView show];
                
                
            }
            if(success == 3)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello"
                                                                    message:@"You have Emailid Already Exits !!"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil, nil];
                //alertView.tag = tag;
                [alertView show];
                
                
            }
            else
            {
                
                //NSString error_msg = (NSString ) jsonData[@"error_message"];
                //[self alertStatus:error_msg :@"Sign in Failed!" :0];
            }
            
        } else {
            //            if (error) NSLog(@"Error: %@", error);
            //            [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
        }
        // }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        //[self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
    if (success) {
        NSLog(@"login succeess");
    }
    
}

-(void)registerWebService{
    NSInteger success = 0;
    @try {
        
     NSString *post =[[NSString alloc] initWithFormat:@"name=%@&email=%@&mobile=%@&password=%@&other_reference_code=%@",[self.fullnameuser text],[self.emailiduser text],[self.mobilenouser text],[self.passworduser text],[self.referralcodeuser text]];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/ios_user_reg.php"];
        
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
        NSMutableDictionary *jsonData1 = [NSJSONSerialization
                                                      JSONObjectWithData:urlData
                                                      options:NSJSONReadingMutableContainers
                                                      error:&error];
            
           NSArray *result=[jsonData1 objectForKey:@"result"];
            
           // NSLog(@"%@jjjj",jsonData1);
            
            
            
            success = [jsonData1[@"success"] integerValue];
            NSLog(@"Success: %ld",(long)success);
            

            if(success == 1)
            {
                
                [self UpdateDataRegisterData];
               
                
                NSLog(@"LoginSuccess");
                
                
                
            }
            if(success == 0)
            {
                
                  NSLog(@"failure");

            }
            else
            {
                
                //NSString error_msg = (NSString ) jsonData[@"error_message"];
                //[self alertStatus:error_msg :@"Sign in Failed!" :0];
            }
            
        } else {
//            if (error) NSLog(@"Error: %@", error);
//            [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
        }
        // }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        //[self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
    if (success) {
        NSLog(@"login succeess");
    }
    
}

-(void)refferalwebserives
{
    NSInteger success = 0;
    @try {
        
       
            NSString *tag=@"Login";
            NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&reference_code=%@",tag,[self.referralcodeuser text]];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/other_refer_code_ios.php"];
            
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
                    [self registerWebService];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello"
                                                                        message:@"You have Registered Successfully !!"
                                                                       delegate:self
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil, nil];
                    //alertView.tag = tag;
                    [alertView show];
                    LoginScreenViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginScreenViewController"];
                    [self.navigationController pushViewController:vc animated:YES];
                    NSLog(@"Register SUCCESS");

                    //  [self alertStatus:@"Hello" :@"Login SUCCESS!" :0];
                    
                    
                }
                else if (success == 0)
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello"
                                                                        message:@"Invalide Referal code !!"
                                                                       delegate:self
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil, nil];
                    //alertView.tag = tag;
                    [alertView show];

 
                    NSLog(@"hi...");
                    
                    
                }
            } else {
                //if (error) NSLog(@"Error: %@", error);
                // [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
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

-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //Get response data
    responseData = [NSMutableData data];
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Get response data in NSString.
    NSString * responceStr = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@ressss",responceStr);
    
}



-(void)UniqueRandom{
   
      UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Enter The OTP"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        // optionally configure the text field
        textField.keyboardType = UIKeyboardTypeAlphabet;
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         UITextField *textField = [alert.textFields firstObject];
                                        if([[textField text] isEqualToString:otpstring]) {
                                            [self refferalwebserives];
                                           

                                                             //[self alertStatus:@"OTP Right" :@"" :0];
                                                             
                                        }else{
                                            [self alertStatus:@"OTP is Wrong" :@"" :0];

                                        }
                                                     }];
    
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
      randomID = arc4random() % 2000 + 1000;
    NSLog(@"%lu",(unsigned long)randomID);
    
    
    otpstring= [NSString stringWithFormat:@"%d", randomID];
    NSString *varyingString1 = otpstring;
    NSString *varyingString2 = @" is Your One Time Password to complete the registration at TripBrip";
    _otpmessage = [NSString stringWithFormat: @"%@ %@", varyingString1, varyingString2];
    
    NSString * authkey = @"119718AkintvzJaWd578dd8d3";
    //Multiple mobiles numbers separated by comma
    NSString * mobiles = mobilenouser.text;
    //Sender ID,While using route4 sender id should be 6 characters long.
    NSString * senderId = @"TRPBRP";
    //Your message to send, Add URL encoding here.
    NSString *message=self.otpmessage;
    //define route
    NSString * route = @"4";
    
    
    NSString * url = [[NSString stringWithFormat:@"http://control.c2sms.com/api/sendhttp.php?authkey=%@&mobiles=%@&message=%@&sender=%@&route=%@", authkey, mobiles, message, senderId, route] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
}



-(void)UpdateDataRegisterData{
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"trip.sqlite"];

    
    NSString *fullnamestring=[NSString stringWithFormat:@"%@",self.fullnameuser.text];
    NSString *emailstring=[NSString stringWithFormat:@"%@",self.emailiduser.text];
    // NSString *rpswd=[NSString stringWithFormat:@"%@",self.repaswrd.text];
    
    NSString *mobilenostring=[NSString stringWithFormat:@"%@",self.mobilenouser.text];
    NSString *paasswordstring=[NSString stringWithFormat:@"%@",self.passworduser.text];
     NSString *referralstrig=[NSString stringWithFormat:@"%@",self.referralcodeuser.text];
    
    
    NSString *queryName;
    queryName = [NSString stringWithFormat:@"update RegisterTable set FullName=('%@'),Emailid=('%@'),Mobileno=('%@'),Password=('%@'),Referalcode=('%@')",fullnamestring ,emailstring,mobilenostring,paasswordstring,referralstrig];
    [self.dbManager executeQuery:queryName];
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        // LoginViewController *log=[[LoginViewController alloc]init];
        // log.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
        // [self presentViewController:log animated:YES completion:nil];
        
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    
    
}

- (IBAction)submitbuttonclick:(id)sender
{
   
    NSString *stringToBeTested = @"8123456789";
   
    NSString *mobileNumberPattern = @"[789][0-9]{9}";
    NSPredicate *mobileNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNumberPattern];
    
    BOOL matched = [mobileNumberPred evaluateWithObject:stringToBeTested];
    
    if([mobileNumberPred evaluateWithObject:mobilenouser.text] == NO)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please Enter Valid Mobile number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
      
    if ([emailTest evaluateWithObject:emailiduser.text] == NO) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please Enter Valid Email Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        // [alert release];
        
        return;
    }
   
    
    else{
        
        
        if(fullnameuser.text==NULL || [fullnameuser.text isEqualToString:@""] || [fullnameuser.text isEqualToString:@" "] ||emailiduser.text==NULL || [emailiduser.text isEqualToString:@""] || [emailiduser.text isEqualToString:@" "]||mobilenouser.text==NULL || [mobilenouser.text isEqualToString:@""] || [mobilenouser.text isEqualToString:@" "]||passworduser.text==NULL || [passworduser.text isEqualToString:@""] || [passworduser.text isEqualToString:@" "]) {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"All Field Required" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
            [alertView show];
            
            
            // There's no text in the box.
        }else
        {
           

            [self checkemailmobileWebService];
        
        }
    }

      //
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tapclcik:(id)sender {
      [self.view endEditing:YES];
}
@end
