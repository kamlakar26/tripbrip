//
//  SpecialRequestViewController.m
//  tripbripapplication
//
//  Created by mac on 10/23/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "SpecialRequestViewController.h"
#import "DBManager.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
@interface SpecialRequestViewController ()
@property(nonatomic,retain)NSMutableArray *mainArray;
@property(nonatomic,retain)NSMutableArray *categoryArray1;
@property(nonatomic,retain)NSString *ValueSelected;
@property(nonatomic,retain)NSString *ValueSelected2;
@property (nonatomic, strong) DBManager *dbManager;
@property(nonatomic,retain)NSArray *statusArray;
@property(nonatomic,retain)NSString *registerTypeString;
@property(nonatomic,retain)NSString *registerTypeString1;
@property(nonatomic,retain)NSString *registerTypeString2;

@end

@implementation SpecialRequestViewController
@synthesize wish,catagory,specialwishtextfields;
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
    
    
     self.navigationItem.title=@"Special Request";
    self.scrollview.contentSize =CGSizeMake(_scrollview.bounds.size.width, 800);
     [_scrollview setShowsVerticalScrollIndicator:NO];
    [self knowStatusForuser];
    _mainArray=[[NSMutableArray alloc]initWithObjects:@"ECONOMICAL",@"SEDAN",@"LARGE",@"LUXURY", nil];
     _categoryArray1=[[NSMutableArray alloc]initWithObjects:@"Family Trip",@"Friends Trip",@"Picnic",@"Long Trip",@"Day-Outing",@"Suprise Anyone", nil];
    // Do any additional setup after loading the view.
}
-(void)specialrequestwebservices
{
    NSInteger success = 0;
    @try {
        
        
            NSString *tag=@"specialrequest";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&name=%@&email=%@&mobile=%@&message=%@&wish=%@&category=%@",tag,_registerTypeString,_registerTypeString1,_registerTypeString2,self.specialwishtextfields.text,_ValueSelected2,_ValueSelected];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://www.tripbrip.com/webapi/get_customer_request.php"];
            
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
                
                NSArray *result=[jsonData objectForKey:@"result"];
                if (result.count >0)
                {
                    NSMutableDictionary *reg=[result objectAtIndex:0];
                    
                    //                NSString *emailstring=[reg objectForKey:@"email"];
                    //                NSString *passwordstring=[reg objectForKey:@"password"];
                    //                NSLog(@"%@",emailstring);
                    NSLog(@"%@",reg);
                }
                
                
                success = [jsonData[@"success"] integerValue];
                NSLog(@"Success: %ld",(long)success);
                
                
                if(success == 0)
                {
                    NSLog(@"Login SUCCESS");
                    [self alertStatus:@"":@"Your Request is Submitted!" :0];
                    
                                       
                }
            else {
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
-(void)knowStatusForuser{
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"trip.sqlite"];
    
    // Check if should load specific record for editing.
    
    NSString *queryav=[NSString stringWithFormat:@"SELECT FullName,Emailid,Mobileno from RegisterTable"];
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
    _registerTypeString2= [[self.statusArray objectAtIndex:0]objectAtIndex:2];
    
    NSLog(@"%@",_statusArray);
    NSLog(@"id%@",_registerTypeString);
}

-(void)FirstEbService{
    
    // UniPicItems=[[NSArray alloc]initWithObjects:@"Select",@"Pune University",@"Mumbai University",@"Matathwada University",@"Kolhapur University",@"Oxford University" ,@"Delhi University", nil];
    Unipicker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 200, 320, 200)];
    Unipicker.backgroundColor = [UIColor whiteColor];
    Unipicker.dataSource=self;
    Unipicker.delegate=self;
    Unipicker.tag = 1;
    [self.view addSubview:Unipicker];
}
-(void)SecondWebService{
    //if ( !Unipicker.hidden) {
    // Unipicker.hidden = YES;
    // }
    // [self selectproductwebservices];
    Yerpicker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 250, 320, 200)];
    Yerpicker.backgroundColor = [UIColor whiteColor];
    Yerpicker.dataSource=self;
    Yerpicker.delegate=self;
    Yerpicker.tag = 2;
    [self.view addSubview:Yerpicker];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    
    
    if (pickerView.tag==1)
    {
        return [_mainArray count];
        
    }
    else if (pickerView.tag==2)
    {
        return [_categoryArray1 count];
        
    }
    return nil;
    
    
    
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //NSLog(@"Row %ld has dr %@",(long)row,[mainArray objectAtIndex:row]);
    // return [[mainArray objectAtIndex:row] objectForKey:@"C_Name"];
    
    if (pickerView.tag==1)
    {
        return [_mainArray objectAtIndex:row] ;
        
    }
    else if (pickerView.tag==2)
    {
        return [_categoryArray1 objectAtIndex:row];
        
    }
    return nil;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    //NSLog(@"Selected Row %d", row);
    if (pickerView.tag==1) {
        _ValueSelected = [_mainArray objectAtIndex:row];
        NSLog(@"......%@",_mainArray);
        // self.FistCategoryTxtFIeld.text=[[mainArray objectAtIndex:row] objectForKey:@"C_Name"];
        [self.catagory setTitle:[_mainArray objectAtIndex:row]forState: UIControlStateNormal];
        //[self selectproductwebservices];
        Unipicker.hidden = YES;
        
    }
    if (pickerView.tag==2) {
        _ValueSelected2 = [_categoryArray1 objectAtIndex:row];
        NSLog(@"......%@",_categoryArray1);
        //self.secondCategoryTxtField.text=[[categoryArray1 objectAtIndex:row] objectForKey:@"P_Name"];
        [self.wish setTitle:[_categoryArray1 objectAtIndex:row]  forState: UIControlStateNormal];
        
        Yerpicker.hidden = YES;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)catagorybuttonclick:(id)sender {
    [self FirstEbService];
    
}

- (IBAction)Wishbuttonclick:(id)sender {
    [self SecondWebService];
}

- (IBAction)tapclick:(id)sender {
    NSLog(@"hiii.....");
    [self.view endEditing:YES];

}

- (IBAction)specialrequestbutton:(id)sender {
    
    
    if(specialwishtextfields.text==NULL || [specialwishtextfields.text isEqualToString:@""] || [specialwishtextfields.text isEqualToString:@" "]) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"All Field Required" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alertView show];
        
        
        // There's no text in the box.
    }else
    {
        
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self specialrequestwebservices];

            [hud hideAnimated:YES];
        });
        
    });
    }
   }
@end
