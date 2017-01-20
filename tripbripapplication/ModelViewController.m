//
//  ModelViewController.m
//  tripbripapplication
//
//  Created by mac on 10/27/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "ModelViewController.h"
#import "ModalTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CarBookViewController.h"
#import "FillupDetailsViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
@interface ModelViewController ()
{
    BOOL checked;
    BOOL checked1;
}

@end

@implementation ModelViewController
@synthesize mainarray,modalarray,tablview,vehicalid,modalarray1,modeltype;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",_passperkmrs1);
    
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
    
     self.navigationItem.title=@"Vehicle Model";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
   // [self displayData];
    tablview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    modalarray=[[NSMutableArray alloc]init];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadcardata];
            [self.tablview reloadData];
            [hud hideAnimated:YES];
        });
        
    });

  
   
    self.tablview.delegate=self;
    //[self.tablview reloadData];
   // self.vehicalid=[modalarray objectAtIndex:0];
    //self.vehicalid=[modalarray objectAtIndex:0];
    //NSLog(@"%@111",vehicalid);
    // Do any additional setup after loading the view.
}
-(void)displayData{
    //        self.imageplaces.image=[UIImage imageWithData:[[NSData alloc] initWithData:[NSData
    //                                                                                  dataFromBase64String:[dataArray objectAtIndex:0]]]];
    //
  
    //self.vehicalid=[modalarray objectAtIndex:0];
    
    
    
}
-(void)loadcardata{
    NSInteger success = 0;
    @try {
        
        NSString *tag=@"vehical_id";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&vehicle_category_id=%@",tag,vehicalid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi_test/car_model_ios.php"];
        
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
        modalarray = [mainarray objectForKey:@"result"];
            
          //  for (int i=0; i<[modalarray count]; i++) {
                
//NSDictionary *dic=[modalarray objectAtIndex:i];
                
            
           // }

           
            
            
            success = [mainarray[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 0)
            {
               

                NSLog(@" SUCCESS");
                
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

-(void)passmodelidwebservices
{
    NSInteger success = 0;
    @try {
        
        _vehicaletypeac=@"1";
        NSString *post =[[NSString alloc] initWithFormat:@"vehicle_type=%@&vehicle_model_id=%@",_vehicaletypeac,_modelid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi_test/vehicle_model_id_ios.php"];
        
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
            modalarray1 = [mainarray objectForKey:@"result"];
            
            for (int i=0; i<[modalarray1 count]; i++) {
                
                NSDictionary *dic=[modalarray1 objectAtIndex:i];
                
                _getwebservicesmodelid=[dic objectForKey:@"id"];
                NSLog(@"%@modelid...",_getwebservicesmodelid);
            }

            
            // _passperkm=[mainarray objectForKey:@"Per_Km_Rate"];
            
            success = [mainarray[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 0)
            {
                
                
                NSLog(@" SUCCESS");
                
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

-(void)passmodelidwebservices1
{
    NSInteger success = 0;
    @try {
        
        _vehicaletypeNonAc=@"2";
        NSString *post =[[NSString alloc] initWithFormat:@"vehicle_type=%@&vehicle_model_id=%@",_vehicaletypeNonAc,_modelid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi_test/vehicle_model_id_ios.php"];
        
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
            modalarray1 = [mainarray objectForKey:@"result"];
            
            for (int i=0; i<[modalarray1 count]; i++) {
                
                NSDictionary *dic=[modalarray1 objectAtIndex:i];
                
                _getwebservicesmodelid=[dic objectForKey:@"id"];
                NSLog(@"%@modelid...",_getwebservicesmodelid);
            }
           
            
            // _passperkm=[mainarray objectForKey:@"Per_Km_Rate"];
            
            success = [mainarray[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 0)
            {
                
                
                NSLog(@" SUCCESS");
                
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
    
    return [modalarray count];
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"modelcell";
    
    
    ModalTableViewCell *cell = (ModalTableViewCell *)[tablview dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[ModalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
    }
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    tablview.backgroundColor = [UIColor clearColor];
    
    
    //cell.descrip.text=[imagearray1 objectAtIndex:indexPath.row];
    
    
    NSDictionary *dict = [modalarray objectAtIndex:indexPath.row];
    
    NSString *jsonImageUrlString = [dict objectForKey:@"vehicle_image"];
    
    NSURL *imageURL = [NSURL URLWithString:jsonImageUrlString];
    
    [cell.modelimage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"sedan_car.png"]];

    NSDictionary *dict1 = [modalarray objectAtIndex:indexPath.row];
    
    NSString *jsonImageUrlString1 = [dict1 objectForKey:@"vehicle_modle_Name"];
    
    cell.modelnamelab.text=jsonImageUrlString1;
    
    
   NSDictionary *dict11 = [modalarray objectAtIndex:indexPath.row];
    
    NSString *jsonImageUrlString11 = [dict11 objectForKey:@"Per_Km_Rate"];
    
    cell.acperrate.titleLabel.text=jsonImageUrlString11;
    NSLog(@"%@peer",jsonImageUrlString11);
    NSString *str=@"AC";
    
    cell.acperrate.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    // you probably want to center it
    cell.acperrate.titleLabel.textAlignment = NSTextAlignmentCenter; // if you want to
    ;
    [cell.acperrate setTitle:[NSString stringWithFormat:@"%@\n₹%@ /PER KM",str,jsonImageUrlString11] forState:UIControlStateNormal];
    cell.acperrate.layer.cornerRadius = 10; // this value vary as per your desire
    cell.acperrate.clipsToBounds = YES;
    
    
    
    
    
    NSDictionary *dict111 = [modalarray objectAtIndex:indexPath.row];
    
    NSString *jsonImageUrlString111 = [dict111 objectForKey:@"Per_Km_Rate1"];
    
    cell.nonacperrate.titleLabel.text=jsonImageUrlString111;
    NSString *str1=@"NON AC";
    
    cell.nonacperrate.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    // you probably want to center it
    cell.nonacperrate.titleLabel.textAlignment = NSTextAlignmentCenter; // if you want to
    ;
    [cell.nonacperrate setTitle:[NSString stringWithFormat:@"%@\n₹%@ /PER KM",str1,jsonImageUrlString111] forState:UIControlStateNormal];
    
    cell.nonacperrate.layer.cornerRadius = 10; // this value vary as per your desire
    cell.nonacperrate.clipsToBounds = YES;



    cell.ACBUTTON.hidden=YES;
    cell.labac.hidden=YES;
    //NSLog(@"%@peer1",jsonImageUrlString111);
    
    if([jsonImageUrlString111 isEqualToString:@"0"])
    {
        cell.nonacperrate.hidden=YES;
        cell.acperrate.hidden=YES;
         cell.ACBUTTON.hidden=NO;
        cell.labac.hidden=NO;
        NSDictionary *dict1111 = [modalarray objectAtIndex:indexPath.row];
        
        NSString *jsonImageUrlString1111 = [dict1111 objectForKey:@"Per_Km_Rate"];
        
        cell.ACBUTTON.titleLabel.text=jsonImageUrlString1111;
        
        NSString *str1=@"AC";
        
        cell.ACBUTTON.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        // you probably want to center it
        cell.ACBUTTON.titleLabel.textAlignment = NSTextAlignmentCenter; // if you want to
        ;
        [cell.ACBUTTON setTitle:[NSString stringWithFormat:@"%@\n₹%@ /PER KM",str1,jsonImageUrlString1111] forState:UIControlStateNormal];
        cell.ACBUTTON.layer.cornerRadius = 10; // this value vary as per your desire
        cell.ACBUTTON.clipsToBounds = YES;


    }
    
    cell.acperrate.tag = indexPath.row;
    cell.nonacperrate.tag = indexPath.row;
  //  c.contentview.tag=indexPath.row;
    cell.ACBUTTON.tag = indexPath.row;
    
    
     [cell.contentView addSubview:cell.acperrate];
     [cell.contentView addSubview:cell.nonacperrate];
     [cell.contentView addSubview:cell.ACBUTTON];
    //yourcell.contentview.tag=indexPath.row;
    [cell.acperrate addTarget:self action:@selector(AddMethod:) forControlEvents:UIControlEventTouchUpInside];
    [cell.nonacperrate addTarget:self action:@selector(AddMethod1:) forControlEvents:UIControlEventTouchUpInside];
    [cell.ACBUTTON addTarget:self action:@selector(AddMethod2:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}
-(void)AddMethod:(UIButton *)sender
{
    CGPoint buttonPosition1 = [sender convertPoint:CGPointZero
                                           toView:self.tablview];
    NSIndexPath *indexPath1 = [self.tablview indexPathForRowAtPoint:buttonPosition1];

    _modelid=[NSString stringWithFormat:@"%@", self.modalarray[indexPath1.row][@"id"]];
    NSLog(@"%@..",_modelid);
    [self passmodelidwebservices];
        
//        UIButton *button = (UIButton *)sender; // first, cast the sender to UIButton
//        
//        id rowid =[button superview];
//        id sectionid = [rowid superview];
//        
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[rowid tag] inSection:[sectionid tag]];
        
    CGPoint buttonPosition = [sender convertPoint:CGPointZero
                                            toView:self.tablview];
    NSIndexPath *indexPath = [self.tablview indexPathForRowAtPoint:buttonPosition];
    NSLog(@"%ld  indexPath.row ", (long)indexPath.row );
        FillupDetailsViewController *destViewController= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FillupDetailsViewController"];
        destViewController.passmodelstring = [NSString stringWithFormat:@"%@", self.modalarray[indexPath.row][@"vehicle_modle_Name"]];
        destViewController.passmodelid = [NSString stringWithFormat:@"%@", self.modalarray1[0][@"id"]];
    
        destViewController.passperkms=[NSString stringWithFormat:@"%@", self.modalarray[indexPath.row][@"Per_Km_Rate"]];
        ;
        destViewController.passnightcharges=_passnightcharges;
        destViewController.passnearpleaces=_passplacelab;
        destViewController.passsperkilomer=_passperkm;
    destViewController.passsvehicalid=vehicalid;
    NSString *Str=@"AC Driver";
    destViewController.passscartype1=Str;
    [self.navigationController pushViewController:destViewController animated:YES];
        // Your code here
 
    
    
}
-(void)AddMethod1:(UIButton *)btnAdd1
{
    CGPoint buttonPosition1 = [btnAdd1 convertPoint:CGPointZero
                                            toView:self.tablview];
    NSIndexPath *indexPath1 = [self.tablview indexPathForRowAtPoint:buttonPosition1];
    _modelid=[NSString stringWithFormat:@"%@", self.modalarray[indexPath1.row][@"id"]];
    NSLog(@"%@..",_modelid);
    [self passmodelidwebservices1];

    
    NSLog(@"AddMethod1");
//        UIButton *button = (UIButton *)btnAdd1; // first, cast the sender to UIButton
//        
//        id rowid =[button superview];
//        id sectionid = [rowid superview];
//        
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[rowid tag] inSection:[sectionid tag]];
    CGPoint buttonPosition = [btnAdd1 convertPoint:CGPointZero
                                            toView:self.tablview];
    NSIndexPath *indexPath = [self.tablview indexPathForRowAtPoint:buttonPosition];
    NSLog(@"%ld  indexPath.row ", (long)indexPath.row );

        FillupDetailsViewController *destViewController= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FillupDetailsViewController"];
        destViewController.passmodelstring = [NSString stringWithFormat:@"%@", self.modalarray[indexPath.row][@"vehicle_modle_Name"]];
    destViewController.passmodelid = [NSString stringWithFormat:@"%@", self.modalarray1[0][@"id"]];

        destViewController.passperkms=[NSString stringWithFormat:@"%@", self.modalarray[indexPath.row][@"Per_Km_Rate1"]];
        ;
        destViewController.passnightcharges=_passnightcharges;
        destViewController.passnearpleaces=_passplacelab;
        destViewController.passsperkilomer=_passperkm;
     destViewController.passsvehicalid=vehicalid;
    NSString *Str=@"NON AC Driver";
    destViewController.passscartype1=Str;

         [self.navigationController pushViewController:destViewController animated:YES];
        // Your code here
  
}
-(void)AddMethod2:(UIButton *)btnAdd2
{
   //        UIButton *button = (UIButton *)btnAdd2; // first, cast the sender to UIButton
//        
//        id rowid =[button superview];
//        id sectionid = [rowid superview];
//        
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[rowid tag] inSection:[sectionid tag]];
//        ModalTableViewCell* cell = (ModalTableViewCell*)[btnAdd2 superview];
//        NSIndexPath* indexPath = [tablview indexPathForCell:cell];
    
    CGPoint buttonPosition = [btnAdd2 convertPoint:CGPointZero
                                           toView:self.tablview];
    NSIndexPath *indexPath = [self.tablview indexPathForRowAtPoint:buttonPosition];
    NSLog(@"%ld  indexPath.row ", (long)indexPath.row );
    FillupDetailsViewController *destViewController= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FillupDetailsViewController"];
        destViewController.passmodelstring = [NSString stringWithFormat:@"%@", self.modalarray[indexPath.row][@"vehicle_modle_Name"]];
        destViewController.passmodelid = [NSString stringWithFormat:@"%@", self.modalarray[indexPath.row][@"id"]];
        destViewController.passperkms=[NSString stringWithFormat:@"%@", self.modalarray[indexPath.row][@"Per_Km_Rate"]];
        ;
        destViewController.passnightcharges=_passnightcharges;
        destViewController.passnearpleaces=_passplacelab;
        destViewController.passsperkilomer=_passperkm;
     destViewController.passsvehicalid=vehicalid;
    NSString *Str=@"AC Driver";
    destViewController.passscartype1=Str;

        // Your code here
         [self.navigationController pushViewController:destViewController animated:YES];
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tablview reloadData];
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
    
    
//    if ([segue.identifier isEqualToString:@"acnoac"]) {
//        NSIndexPath *indexPath = [self.tablview indexPathForSelectedRow];
//        FillupDetailsViewController *destViewController = segue.destinationViewController;
//        destViewController.passmodelstring = [NSString stringWithFormat:@"%@", self.modalarray[indexPath.row][@"vehicle_modle_Name"]];
//        destViewController.passmodelid = [NSString stringWithFormat:@"%@", self.modalarray[indexPath.row][@"id"]];
//        destViewController.passperkms=[NSString stringWithFormat:@"%@", self.modalarray[indexPath.row][@"Per_Km_Rate"]];
//;
//        destViewController.passnightcharges=_passnightcharges;
//        destViewController.passnearpleaces=_passplacelab;
//        destViewController.passsperkilomer=_passperkm;
//    }
//    
//    if ([segue.identifier isEqualToString:@"ac"]) {
//        NSIndexPath *indexPath = [self.tablview indexPathForSelectedRow];
//        FillupDetailsViewController *destViewController = segue.destinationViewController;
//        destViewController.passmodelstring = [NSString stringWithFormat:@"%@", self.modalarray[indexPath.row][@"vehicle_modle_Name"]];
//        destViewController.passmodelid = [NSString stringWithFormat:@"%@", self.modalarray[indexPath.row][@"id"]];
//        destViewController.passperkms=[NSString stringWithFormat:@"%@", self.modalarray[indexPath.row][@"Per_Km_Rate"]];
//        ;
//        destViewController.passnightcharges=_passnightcharges;
//        destViewController.passnearpleaces=_passplacelab;
//        destViewController.passsperkilomer=_passperkm;
//    }
//    
//    if ([segue.identifier isEqualToString:@"noac"]) {
//        NSIndexPath *indexPath = [self.tablview indexPathForSelectedRow];
//        FillupDetailsViewController *destViewController = segue.destinationViewController;
//        destViewController.passmodelstring = [NSString stringWithFormat:@"%@", self.modalarray[indexPath.row][@"vehicle_modle_Name"]];
//        destViewController.passmodelid = [NSString stringWithFormat:@"%@", self.modalarray[indexPath.row][@"id"]];
//        destViewController.passperkms=[NSString stringWithFormat:@"%@", self.modalarray[indexPath.row][@"Per_Km_Rate1"]];
//        ;
//        destViewController.passnightcharges=_passnightcharges;
//        destViewController.passnearpleaces=_passplacelab;
//        destViewController.passsperkilomer=_passperkm;
//    }
//
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
