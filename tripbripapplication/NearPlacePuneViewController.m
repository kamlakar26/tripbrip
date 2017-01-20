//
//  NearPlacePuneViewController.m
//  tripbripapplication
//
//  Created by mac on 10/20/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "NearPlacePuneViewController.h"
#import "NearPlaceTableViewCell.h"
#import "NSData+Base64.h"
#import "UIImageView+WebCache.h"
#import "NearPlacesDetailsViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
@interface NearPlacePuneViewController ()

@end

@implementation NearPlacePuneViewController
@synthesize imagearray,mainArray,imagearray1,str1,profileArray,SearchArray;
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
    
    
    
    
    self.navigationItem.title=@"PLACES NEAR PUNE";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    imagearray=[[NSArray alloc]init];
       mainArray=[[NSDictionary alloc]init];
    imagearray1=[[NSMutableArray alloc]init];
    profileArray=[[NSMutableArray alloc]init];
    SearchArray=[[NSMutableArray alloc]init];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadWebdata];
            [self.tableview reloadData];
            [hud hideAnimated:YES];
        });
        
    });
    
    

   // imagearray=[[NSArray alloc]initWithObjects:@"image1.jpg",@"image2.jpg",@"image3.jpg",@"image4.jpg", nil];
    
    // Do any additional setup after loading the view.
}
-(void)loadWebdata{
    NSInteger success = 0;
    @try {
        
        NSString *tag=@"ImageData";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&place_type=%@",tag,_passbutton1];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/places_ios.php"];
        
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
             //NSLog(@"Response ==> %@", responseData);
            
            NSError *error = nil;
             mainArray = [NSJSONSerialization
                                 JSONObjectWithData:urlData
                                 options:NSJSONReadingMutableContainers
                                error:&error];
            
            imagearray1=[mainArray objectForKey:@"result"];
            
            for (int i=0; i<[imagearray1 count]; i++) {
                
                
                
                _globalstring= [[imagearray1 objectAtIndex:i]objectForKey:@"image_url"];
                NSLog(@"%@",_globalstring);
                NSString *place=[[imagearray1 objectAtIndex:i]objectForKey:@"place_name"];
                NSString *descrip=[[imagearray1 objectAtIndex:i]objectForKey:@"description"];
                NSString *besttime=[[imagearray1 objectAtIndex:i]objectForKey:@"visit"];
                NSString *route=[[imagearray1 objectAtIndex:i]objectForKey:@"route"];
                NSLog(@"%@",place);
                NSLog(@"%@",descrip);
                NSLog(@"%@",besttime);
                NSLog(@"%@",route);
                
                
            }
           
            
            success = [mainArray[@"success"]integerValue];
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
    
  return [imagearray1 count];
    
    
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"NearPlaceCell";
    
    
    NearPlaceTableViewCell *cell = (NearPlaceTableViewCell *)[_tableview dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NearPlaceCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    _tableview.backgroundColor = [UIColor clearColor];

    
    //cell.descrip.text=[imagearray1 objectAtIndex:indexPath.row];
   
    
    
    
    
    NSDictionary *dict = [imagearray1 objectAtIndex:indexPath.row];
    
    NSString *jsonImageUrlString = [dict objectForKey:@"image_url"];
    
    NSURL *imageURL = [NSURL URLWithString:jsonImageUrlString];
    
   [cell.placeimage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placelogo.png"]];
    
//    NSDictionary *dict1 = [imagearray1 objectAtIndex:indexPath.row];
//    
//    NSString *jsonImageUrlString1 = [dict1 objectForKey:@"place_name"];
//    
//    cell.placenamelab.text=jsonImageUrlString1;
//    
//    NSDictionary *dict2 = [imagearray1 objectAtIndex:indexPath.row];
//    
//    NSString *jsonImageUrlString2 = [dict2 objectForKey:@"description"];
//    
//    cell.descrip.text=jsonImageUrlString2;
//    
//    NSDictionary *dict3 = [imagearray1 objectAtIndex:indexPath.row];
//    
//    NSString *jsonImageUrlString3 = [dict3 objectForKey:@"visit"];
//    
//    cell.besttimelab.text=jsonImageUrlString3;
//    
//    NSDictionary *dict4 = [imagearray1 objectAtIndex:indexPath.row];
//    
//    NSString *jsonImageUrlString4 = [dict4 objectForKey:@"route"];
//    
//    cell.routelab.text=jsonImageUrlString4;
//    
    
    
    
    
//    NSDictionary *dict = [imagearray1 objectAtIndex:indexPath.row];
//    
//    NSString *str=[dict valueForKey:@"image_url"];
//    NSURL *str11=[NSURL URLWithString:str];
//  
//    cell.placeimage.image = [UIImage imageWithData:
//                            [NSData dataWithContentsOfURL:str11]];
//    
  
                   return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [profileArray removeAllObjects];
//   
//    
//    [profileArray addObject:[[imagearray1 objectAtIndex:indexPath.row] objectForKey:@"image_url"]];
////    [profileArray addObject:[[imagearray1 objectAtIndex:indexPath.row] objectForKey:@"place_name"]];
////    [profileArray addObject:[[imagearray1 objectAtIndex:indexPath.row] objectForKey:@"description"]];
////    [profileArray addObject:[[imagearray1 objectAtIndex:indexPath.row] objectForKey:@"visit"]];
////    [profileArray addObject:[[imagearray1 objectAtIndex:indexPath.row] objectForKey:@"route"]];
//    
//
//    NearPlacesDetailsViewController *reg=[[NearPlacesDetailsViewController alloc]init];
//    reg.dataArray=profileArray;
//    
//    //navC=[[UINavigationController alloc]initWithRootViewController:reg];
//    [self.navigationController pushViewController:reg animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    [profileArray removeAllObjects];
    if ([segue.identifier isEqualToString:@"imagedetails"]) {
        NSIndexPath *indexPath = [self.tableview indexPathForSelectedRow];
        
        
        
        NearPlacesDetailsViewController *destViewController = segue.destinationViewController;
        [profileArray addObject:[[imagearray1 objectAtIndex:indexPath.row] objectForKey:@"image_url"]];
         [profileArray addObject:[[imagearray1 objectAtIndex:indexPath.row] objectForKey:@"place_name"]];
         [profileArray addObject:[[imagearray1 objectAtIndex:indexPath.row] objectForKey:@"description"]];
         [profileArray addObject:[[imagearray1 objectAtIndex:indexPath.row] objectForKey:@"visit"]];
         [profileArray addObject:[[imagearray1 objectAtIndex:indexPath.row] objectForKey:@"route"]];
         [profileArray addObject:[[imagearray1 objectAtIndex:indexPath.row] objectForKey:@"id"]];
        
        destViewController.dataArray = profileArray;
        destViewController.imageid=[NSString stringWithFormat:@"%@", self.imagearray1[indexPath.row][@"id"]];
        
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
