//
//  BookACarViewController.m
//  tripbripapplication
//
//  Created by mac on 10/20/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "BookACarViewController.h"
#import "BookingTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ModelViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
@interface BookACarViewController ()
@property(nonatomic,retain)NSString *getid;
@end

@implementation BookACarViewController
@synthesize bookaryya,tablview,mainarray,profileArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@ddd",_passstring);
    /////////// Check Internet Connection...
    
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
     self.navigationItem.title=@"Vehicle Category";
//    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.jpg"] style:UIBarButtonItemStyleBordered target:nil action:nil];
//    self.navigationItem.backBarButtonItem = btn;
 
//    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]init];
//    barBtn.title=@"";
//    self.navigationItem.leftBarButtonItem=barBtn;
//    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];

    tablview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadcardata];
              [self.tablview reloadData];
            [hud hideAnimated:YES];
        });
        
    });
   
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadcardata{
    NSInteger success = 0;
    @try {
        
        NSString *tag=@"ImageData";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@",tag];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi_test/get_vehicle_categories.php"];
        
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
            
            bookaryya=[mainarray objectForKey:@"result"];
            
            for (int i=0; i<[bookaryya count]; i++) {
                
                
                
                NSString *str= [[bookaryya objectAtIndex:i]objectForKey:@"vehicle_cat_url"];
                NSLog(@"%@",str);
                _getid= [[bookaryya objectAtIndex:i]objectForKey:@"id"];
                NSLog(@"%@",_getid);
              
                
                
            }
            
            
            success = [mainarray[@"success"]integerValue];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [bookaryya count];
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"bookcell";
    
    
    BookingTableViewCell *cell = (BookingTableViewCell *)[tablview dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"bookcell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    tablview.backgroundColor = [UIColor clearColor];
    
    
    //cell.descrip.text=[imagearray1 objectAtIndex:indexPath.row];
    
    
    NSDictionary *dict = [bookaryya objectAtIndex:indexPath.row];
    
    NSString *jsonImageUrlString = [dict objectForKey:@"vehicle_cat_url"];
    
    NSURL *imageURL = [NSURL URLWithString:jsonImageUrlString];
    
    [cell.carimage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"sedan_car.png"]];
    
    NSDictionary *dict1 = [bookaryya objectAtIndex:indexPath.row];
    
    NSString *jsonImageUrlString1 = [dict1 objectForKey:@"vehicle_category"];
    
    cell.carname.text=jsonImageUrlString1;
    
    NSDictionary *dict2 = [bookaryya objectAtIndex:indexPath.row];
    
    NSString *jsonImageUrlString2 = [dict2 objectForKey:@"Per_Km_Rate"];
    
    cell.carperkm.text=jsonImageUrlString2;
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
       if ([segue.identifier isEqualToString:@"modelseque"]) {
        NSIndexPath *indexPath = [self.tablview indexPathForSelectedRow];
        ModelViewController *destViewController = segue.destinationViewController;
        destViewController.vehicalid = [NSString stringWithFormat:@"%@", self.bookaryya[indexPath.row][@"id"]];
        destViewController.passperkmrs = [NSString stringWithFormat:@"%@", self.bookaryya[indexPath.row][@"Per_Km_Rate"]];
        destViewController.passnightcharges = [NSString stringWithFormat:@"%@", self.bookaryya[indexPath.row][@"Night_Charges"]];
           destViewController.passplacelab=_passstring;
           destViewController.passperkm = [NSString stringWithFormat:@"%@", self.bookaryya[indexPath.row][@"min_kms"]];
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
