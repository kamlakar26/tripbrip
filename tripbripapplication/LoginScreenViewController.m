//
//  LoginScreenViewController.m
//  tripbripapplication
//
//  Created by mac on 10/14/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "LoginScreenViewController.h"
#import "RegisterViewController.h"
#import "DashbordViewController.h"
#import "DBManager.h"
#import "MBProgressHUD.h"
//#import "IQKeyboardManager.h"
#import "RegisterViewController.h"
#import "Reachability.h"
#import "NSData+Base64.h"
@interface LoginScreenViewController ()
{
}
@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSString *statusFromBuyerDB;

@property(nonatomic,retain)NSMutableArray *statusArray;

@property (nonatomic, strong) NSString *userbalancestring;


@end


@implementation LoginScreenViewController
@synthesize usermobile,userpassword,array;
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
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title=@"TripBrip";
    //////////////////////
     _statusArray=[[NSMutableArray alloc]init];
    array=[[NSMutableArray alloc]init];
    
    
    
    
   
 //////////////////////////////
    
    [self toggleHiddenState:YES];
//    
//    self.loginButton.delegate = self;
//    self.loginButton.readPermissions = @[@"public_profile", @"email"];
    
    
    
    
   // [GIDSignIn sharedInstance].uiDelegate = self;
//    [GIDSignIn sharedInstance].delegate = self;
//    [GIDSignIn sharedInstance].uiDelegate = self;
    
    
    //[GIDSignIn sharedInstance].scopes.append("https://www.googleapis.com/auth/plus.login")
    //[GIDSignIn sharedInstance].append("https://www.googleapis.com/auth/plus.me")
    
    


   // [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view.
}

//- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
//    //[myActivityIndicator stopAnimating];
//}
//
//// Present a view that prompts the user to sign in with Google
//- (void)signIn:(GIDSignIn *)signIn
//presentViewController:(UIViewController *)viewController {
//    [self presentViewController:viewController animated:YES completion:nil];
//}
//
//// Dismiss the "Sign in with Google" view
//- (void)signIn:(GIDSignIn *)signIn
//dismissViewController:(UIViewController *)viewController {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (IBAction)didTapSignOut:(id)sender {
//    [[GIDSignIn sharedInstance] signOut];
//}
//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)toggleHiddenState:(BOOL)shouldHide{
   
}


#pragma mark - FBLoginView Delegate method implementation

//-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
//    
//    
//    [self toggleHiddenState:NO];
//}
//
//
//-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
//    NSLog(@"%@", user);
//   
//}
//
//
//-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
//       
//    [self toggleHiddenState:YES];
//}
//
//
//-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
//    NSLog(@"%@", [error localizedDescription]);
//}
//

-(void)loginwebservices
{
NSInteger success = 0;
@try {
    
    if([[self.usermobile text] isEqualToString:@""] || [[self.userpassword text] isEqualToString:@""] ) {
        
        [self alertStatus:@"Please enter Mobile number and Password" :@"Sign in Failed!" :0];
        
    } else {
        NSString *tag=@"Login";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&Mobile_Number=%@&password=%@",tag,[self.usermobile text],[self.userpassword text]];
        NSLog(@"PostData: %@",post);
        
       NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi_test/user_login_iso.php"];
        
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
            
            _userid=[dic objectForKey:@"User_Id"];
            NSLog(@"%@",_userid);
            _username=[dic objectForKey:@"Name"];
            NSLog(@"%@",_username);
            _emailid=[dic objectForKey:@"Email"];
            NSLog(@"%@",_emailid);
            
            _userbalancestring=[dic objectForKey:@"User_Balance"];
            NSLog(@"%@",_userbalancestring);

           
                
                
                // NSData* data = [[NSData alloc] initWithBase64EncodedString:[[mainArray objectAtIndex:i] objectForKey:@"img"] options:0];
               // _imagedata = [[NSData alloc] initWithData:[NSData
                                                           //  dataFromBase64String:[dic objectForKey:@"profile_image"]]];
                
                // NSString *strr=[[mainArray objectAtIndex:i] objectForKey:@"img"];
              //   NSLog(@"img...%@",_imagedata);
            NSString *str = [dic objectForKey:@"profile_image"];
            NSUserDefaults *pers=[NSUserDefaults standardUserDefaults];
            [pers setObject:str forKey:@"profile_pic"];
            
            
            success = [jsonData[@"success"] integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 1)
            {
                NSLog(@"Login SUCCESS");
              //  [self alertStatus:@"Hello" :@"Login SUCCESS!" :0];
                
                [self updateDatabase];
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                
            DashbordViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"DashbordViewController"];
                [controller.navigationItem setTitle:nil];
                controller.passimage=_imagedata;
                
                [self.navigationController pushViewController:controller animated:YES];
                return;
                
            }
            else if (success == 0)
            {
                NSLog(@"hi...");
               
                [self alertStatus:@"username and password incorrect" :@"Sign in Failed!" :0];
                [self.navigationController presentedViewController];
                
            }
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

-(void)updateDatabase{
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"trip.sqlite"];

    NSString *queryup;
    queryup = [NSString stringWithFormat:@"update Logintable1 set mobileno=('%@'), Password=('%@'),fullname=('%@'),emaiid=('%@'),Satus3=('%@')", [self.usermobile text],[self.userpassword text],_username,_emailid,_userbalancestring];
    [self.dbManager executeQuery:queryup];
    NSString *status=@"1";
    NSString *que51=[NSString stringWithFormat:@"update Logintable1 set Satus2=('%@'),Satus1=('%@')",_userid,status];
    [self.dbManager executeQuery:que51];
    
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
    }
    else{
        NSLog(@"Could not execute the query.");
    }

}
-(void)updateDatabase1{
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"trip.sqlite"];
    
    NSString *queryup;
    queryup = [NSString stringWithFormat:@"update Logintable1 set mobileno=('%@'), Password=('%@')", [self.usermobile text],[self.userpassword text]];
    [self.dbManager executeQuery:queryup];
    NSString *status=@"1";
    NSString *que51=[NSString stringWithFormat:@"update Logintable1 set Satus2=('%@'),Satus1=('%@')",_userid,status];
    [self.dbManager executeQuery:que51];
    
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    
}

-(void)knowStatusForuser{
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"trip.sqlite"];
    
    // Check if should load specific record for editing.
    
    NSString *queryav=[NSString stringWithFormat:@"SELECT Satus1,mobileno from Logintable1"];
    [self.dbManager executeQuery:queryav];
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    self.statusArray = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:queryav]];
    _statusFromBuyerDB = [[self.statusArray objectAtIndex:0]objectAtIndex:0];
    NSLog(@"%@",_statusArray);
    NSLog(@"id%@",_statusFromBuyerDB);
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)signupbuttonclick:(id)sender {
    
//    RegisterViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RegisterViewController"];
//        [self.navigationController pushViewController:vc animated:YES];

    // [self performSegueWithIdentifier:@"Signup" sender:self];
}

- (IBAction)Loginbuttonclick:(id)sender {
   
   
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    
//    DashbordViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"DashbordViewController"];
//    [controller.navigationItem setTitle:nil];
//    [self.navigationController pushViewController:controller animated:YES];
//    return;

   // DashbordViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DashbordViewController"];
      // [self.navigationController pushViewController:vc animated:YES];
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
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self loginwebservices];
                
                [hud hideAnimated:YES];
            });
            
        });

        NSLog(@"There IS internet connection");
    }

    
   }

- (IBAction)showpasswordbuttonclick:(id)sender {
    
           if (self.userpassword.secureTextEntry == YES) {
            [ self.showbutton setTitle:@"HIDE" forState:(UIControlStateNormal)];
            
            self.userpassword.secureTextEntry = NO;
            [_showbutton setBackgroundImage:[UIImage imageNamed:@"niX8MpbGT.png"] forState:UIControlStateNormal];
        }
        
        else
        {
            [ self.showbutton setTitle:@"SHOW" forState:(UIControlStateNormal)];
            
            self.userpassword.secureTextEntry = YES;
            [_showbutton setBackgroundImage:[UIImage imageNamed:@"unchecked_checkbox-512.png"] forState:UIControlStateNormal];

        }
        
}

- (IBAction)linkbuttonclick:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.tripbrip.com/documents/Tech_and_services.html"]];
    
}

- (IBAction)tapclick:(id)sender {
    NSLog(@"hiii.....");
    [self.view endEditing:YES];
}
@end
