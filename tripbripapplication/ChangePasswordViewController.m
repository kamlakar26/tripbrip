//
//  ChangePasswordViewController.m
//  tripbripapplication
//
//  Created by mac on 11/7/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "LoginScreenViewController.h"
//#import "IQKeyboardManager.h"
#import "Reachability.h"
@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController
@synthesize newpasswordtext,Confirpasswordtext,mobileno;
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
    
    self.navigationItem.title=@"Change Password";
    // Do any additional setup after loading the view.
}
-(void)changepassword{
    NSInteger success = 0;
    @try {
        
        NSString *post =[[NSString alloc] initWithFormat:@"mobile_number=%@&password=%@&",mobileno,newpasswordtext.text];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/change_password_ios.php"];
        
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
            
              NSDictionary *req=[jsonData1 objectForKey:@"result"];
            
           
            NSLog(@"%@jjjj",jsonData1);
            
            
            
            success = [jsonData1[@"success"] integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 1)
            {
                
                 [self alertStatus:@"Password Change!!":@"Hello" :0];
                NSLog(@"ForgetPassword SUCCESS");
                
                
                
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

- (IBAction)submitclick:(id)sender {
    
    if([newpasswordtext.text isEqualToString:Confirpasswordtext.text])
        {
        [self changepassword];
            LoginScreenViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginScreenViewController"];
           
            [self.navigationController pushViewController:vc animated:YES];
        //do whatever
    }else{
      
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Password Not Match"
                                                            message:@"New Password and Confirm Password Dost not match !!"
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil, nil];
        //alertView.tag = tag;
        [alertView show];

    }
}

- (IBAction)tapbuttonclick:(id)sender {
    NSLog(@"hiii.....");
    [self.view endEditing:YES];

}
@end
