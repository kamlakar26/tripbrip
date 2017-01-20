//
//  ProfileViewController.m
//  tripbripapplication
//
//  Created by mac on 10/17/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "ProfileViewController.h"
#import "HistoryTableViewCell.h"
#import "DBManager.h"
#import "HistoryDetailsViewController.h"
#import "LoginScreenViewController.h"
#import "PaymentWalletViewController.h"
#import "ProfileUpdateViewController.h"
@interface ProfileViewController ()
@property (nonatomic, strong) DBManager *dbManager;
@property(nonatomic,retain)NSArray *statusArray;
@property(nonatomic,retain)NSString *registerTypeString;
@property(nonatomic,retain)NSString *registerTypeString1;
@property(nonatomic,retain)NSString *registerTypeString2;
@property(nonatomic,retain)NSString *userid;

@property(nonatomic,retain)NSString *walletstring;

@property(nonatomic,retain)NSMutableArray *BuyerIdArray;

@end

@implementation ProfileViewController
@synthesize imagearyya,tittleArray,tablview,DataArray,mainarray,usernametext,useremailtext,ValidString,usermobiletext,userid;
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title=@"Profile";
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    _editbtn.hidden=YES;
    ValidString=@"0";
    DataArray=[[NSMutableArray alloc]init];
    [self selectBuyerID];
    [self knowStatusForuser];
     [self currentbalaanceswallet];
   // _walletmoneylab.text=@"₹";
    useremailtext.text=_registerTypeString;
    usermobiletext.text=_registerTypeString1;
    _mobiletext.text=_registerTypeString2;
    
    _tripmoneylab.text=[NSString stringWithFormat:@"₹%@",_passtripstring];
    _walletmoneylab.text=[NSString stringWithFormat:@"₹%@",_walletstring];
    if([_walletmoneylab.text isEqualToString:@"₹(null)"])
    {
        _walletmoneylab.text=@"₹0";
    }

    // Do any additional setup after loading the view.
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


-(void)getdataprofile
{
    for (int i=0; i<[DataArray count]; i++) {
        
        
               self.usernametext.text=[[DataArray objectAtIndex:i] objectForKey:@"Name"];
               self.useremailtext.text=[[DataArray objectAtIndex:i] objectForKey:@"Email"];
                 self.usermobiletext.text=[[DataArray objectAtIndex:i] objectForKey:@"Mobile_Number"];
    }

}

-(void)profiledataupdate
{

NSInteger success = 0;
@try {
    
    NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@&name=%@&email=%@",userid,[self.useremailtext text],[self.usermobiletext text]];
    NSLog(@"PostData: %@",post);
    
    NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi_test/profile_update_ios.php"];
    
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
        mainarray = [NSJSONSerialization
                                          JSONObjectWithData:urlData
                                          options:NSJSONReadingMutableContainers
                                          error:&error];
        
        DataArray=[mainarray objectForKey:@"result"];
        

        
        NSLog(@"%@jjjj",mainarray);
        
        
        success = [mainarray[@"success"] integerValue];
        NSLog(@"Success: %ld",(long)success);
        
        if(success == 1)
        {
            
            NSLog(@"Login SUCCESS");
            [self alertStatus:@"Hello":@"Profile Data updated successfully !" :0];
            
            
            
            
            
        }
        if(success == 2)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                                message:@"Email already Exist!!"
                                                               delegate:self
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil, nil];
            //alertView.tag = tag;
            [alertView show];
            
            NSLog(@"Login SUCCESS");
            
            
            
            
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








-(void)knowStatusForuser{
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"trip.sqlite"];
    
    // Check if should load specific record for editing.
    
    NSString *queryav=[NSString stringWithFormat:@"SELECT fullname,emaiid,mobileno,Satus3 from Logintable1"];
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
    _registerTypeString2 = [[self.statusArray objectAtIndex:0]objectAtIndex:2];
    _passtripstring=[[self.statusArray objectAtIndex:0]objectAtIndex:3];
    
    NSLog(@"%@",_statusArray);
    NSLog(@"id%@",_registerTypeString);

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
    userid = [[self.BuyerIdArray objectAtIndex:0] objectAtIndex:0];
    [self fetchUserID];
}
-(void)fetchUserID{
    
    NSInteger success = 0;
    @try {
        
        //if([[self.UserName text] isEqualToString:@""] || [[self.Password text] isEqualToString:@""] ) {
        
        //  [self alertStatus:@"Please enter Email and Password" :@"Sign in Failed!" :0];
        
        // } else {
        NSString *tag=@"ProfileShow";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&user_id=%@",tag,userid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/profile_update_ios.php"];
        
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
            mainarray = [NSJSONSerialization
                         JSONObjectWithData:urlData
                         options:NSJSONReadingMutableContainers
                         error:&error];
            
           
            
            
    
            success = [mainarray[@"Success"] integerValue];
            NSLog(@"Success: %ld",(long)success);
            

            
            if(success == 1)
            {
                
                NSLog(@"Login SUCCESS");
            [self alertStatus:@"Hello":@"Profile Data updated successfully !" :0];
               
                
                
                
                
            }
            if(success == 2)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                                    message:@"Email already Exist!!"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil, nil];
                //alertView.tag = tag;
                [alertView show];
                
                NSLog(@"Login SUCCESS");
                
                
                
                
            }
            else {
                
                // NSString *error_msg = (NSString *) jsonData[@"error_message"];
                //[self alertStatus:error_msg :@"Sign in Failed!" :0];
            }
            
        } else {
            //if (error) NSLog(@"Error: %@", error);
            //[self alertStatus:@"Connection Failed" :@"Sorry!" :0];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)editbuttonclick:(id)sender {
    
    if ([ValidString isEqualToString:@"0"]){
        //[self.editbtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"done.png"]] forState:UIControlStateSelected];
       
        [_editbtn setBackgroundImage:[UIImage imageNamed:@"Accept-512.png"] forState:UIControlStateNormal];
        [self.view addSubview:_editbtn];
        
        [self.editbtn setSelected:YES];
      
        
        ValidString = @"1";
        ValidString=[NSString stringWithFormat:@"%@",ValidString];
        NSLog(@"zero%@",ValidString);
        self.usernametext.enabled = YES;
        self.useremailtext.enabled = YES;
        self.usermobiletext.enabled = YES;
        
        
    } else {
       // [self.editbtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"edit.png"]] forState:UIControlStateSelected];
        
        
        [_editbtn setBackgroundImage:[UIImage imageNamed:@"23-512.png"] forState:UIControlStateNormal];
        [self.view addSubview:_editbtn];
        
        
        
        [self.editbtn setSelected:NO];
      
        
        ValidString = @"0";
        ValidString=[NSString stringWithFormat:@"%@",ValidString];
        NSLog(@"zero%@",ValidString);
        [self profiledataupdate];
        self.usernametext.enabled = NO;
        self.useremailtext.enabled = NO;
        self.usermobiletext.enabled = NO;
    }

    
    
}

- (IBAction)tripwallerbuttonclick:(id)sender {
    PaymentWalletViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PaymentWalletViewController"];
    vc.passuserid=userid;
    vc.passwattet=_walletstring;
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)profilebutton:(id)sender {
    ProfileUpdateViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProfileUpdateViewController"];
    vc.passuserid=userid;
    vc.passuser=_registerTypeString;
    vc.passemail=_registerTypeString1;
    vc.passmobile=_registerTypeString2;
    vc.imageshow=_profileimage;
    [self.navigationController pushViewController:vc animated:YES];


}
-(void)logoutmethod
{
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"trip.sqlite"];
    
    NSString *status=@"0";
    NSString *que51=[NSString stringWithFormat:@"update Logintable1 set Satus1=('%@')",status];
    [self.dbManager executeQuery:que51];
    
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        
        
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    
}
- (IBAction)logoutbuttonclick:(id)sender {
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Logout"
                                  message:@"Are you sure want to logout?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [self logoutmethod];
                                    LoginScreenViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginScreenViewController"];
                                        [self.navigationController pushViewController:vc animated:YES];
                                    
                                    
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
-(void)currentbalaanceswallet{
    NSInteger success = 0;
    @try {
        
        NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@",userid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi_test/money_ios.php"];
        
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
            
            _walletstring=[req objectForKey:@"w_money"];
            
            NSLog(@"%@jjjj",jsonData1);
            
            
            
            success = [jsonData1[@"success"] integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 1)
            {
                
                //[self alertStatus:@"Password Change!!":@"Hello" :0];
                NSLog(@"payment SUCCESS");
                
                
                
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

@end
