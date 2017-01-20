//
//  ContacUsViewController.m
//  tripbripapplication
//
//  Created by mac on 10/17/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "ContacUsViewController.h"
#import "SubContactTableViewCell.h"
#import "MBProgressHUD.h"
#import "UILabel+UILabel_dynamicSizeMe.h"
@interface ContacUsViewController ()

@end

@implementation ContacUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"Contact Us";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"faq1-2" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.webview1 loadHTMLString:htmlString baseURL:nil];
    self.scrollview.contentSize =CGSizeMake(_scrollview.bounds.size.width, 700);
    
   

    
   
    
    selectindex=-1;
    _array1=[[NSMutableArray alloc]init];
    
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadWebdata];
            [self.tableview reloadData];
            [hud hideAnimated:YES];
        });
        
    });
    _tableview.delegate=self;
    _tableview.dataSource=self;

      // _array3=[[NSMutableArray alloc]init];

    
        // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_array1 count];
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"subcell";
    
    
    SubContactTableViewCell *cell = (SubContactTableViewCell *)[_tableview dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"subcell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
       if(selectindex==indexPath.row)
    {
        cell.contentView.backgroundColor=[UIColor lightGrayColor];
    }
    else{
        cell.contentView.backgroundColor=[UIColor whiteColor];
    }
    
    NSDictionary *dict1 = [_array1 objectAtIndex:indexPath.row];
    
        NSString *jsonImageUrlString1 = [dict1 objectForKey:@"question"];
    
        cell.lab1.text=jsonImageUrlString1;
    [cell.lab1 resizeToFit];
    
    NSLog(@"%@33",jsonImageUrlString1);
    
    NSDictionary *dict2 = [_array1 objectAtIndex:indexPath.row];
    
    NSString *jsonImageUrlString2 = [dict2 objectForKey:@"answer"];
    
    cell.ansertextview.text=jsonImageUrlString2;
  
    NSIndexPath *indexPath1 = [_tableview indexPathForSelectedRow];
    
    [_tableview selectRowAtIndexPath:indexPath1
                            animated:NO
                      scrollPosition:UITableViewScrollPositionMiddle];

   
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(selectindex == indexPath.row)
    {
        return 200;
    }else{
        return 44;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if(selectindex == indexPath.row)
    {
        selectindex= -1;
        [_tableview reloadRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        return;
    }
    if(selectindex != -1)
    {
        NSIndexPath *prvpath=[NSIndexPath indexPathForRow:selectindex inSection:0];
        selectindex =indexPath.row;
        [_tableview reloadRowsAtIndexPaths:[NSMutableArray arrayWithObject:prvpath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    selectindex=indexPath.row;
    [_tableview reloadRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
-(void)loadWebdata{
    NSInteger success = 0;
    @try {
        
        NSString *str=@"1";
        NSString *post =[[NSString alloc] initWithFormat:@"faq_status=%@",str];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/get_faq.php"];
        
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
            _contdictinary = [NSJSONSerialization
                         JSONObjectWithData:urlData
                         options:NSJSONReadingMutableContainers
                         error:&error];
            
            _array1=[_contdictinary objectForKey:@"result"];
            
            NSLog(@"%@",_array1);
            success = [_contdictinary[@"success"]integerValue];
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
-(void)loadWebdata1{
    NSInteger success = 0;
    @try {
        
        NSString *str=@"2";
        NSString *post =[[NSString alloc] initWithFormat:@"faq_status=%@",str];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/get_faq.php"];
        
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
            _contdictinary = [NSJSONSerialization
                              JSONObjectWithData:urlData
                              options:NSJSONReadingMutableContainers
                              error:&error];
            
            _array1=[_contdictinary objectForKey:@"result"];
            
            NSLog(@"%@",_array1);
            success = [_contdictinary[@"success"]integerValue];
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
-(void)loadWebdata2{
    NSInteger success = 0;
    @try {
        
        NSString *str=@"3";
        NSString *post =[[NSString alloc] initWithFormat:@"faq_status=%@",str];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/get_faq.php"];
        
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
            _contdictinary = [NSJSONSerialization
                              JSONObjectWithData:urlData
                              options:NSJSONReadingMutableContainers
                              error:&error];
            
            _array1=[_contdictinary objectForKey:@"result"];
            
            NSLog(@"%@",_array1);
            success = [_contdictinary[@"success"]integerValue];
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

- (IBAction)safetybuttonclick:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
           [self loadWebdata2];
          [self.tableview reloadData];
            [hud hideAnimated:YES];
        });
        
    });

    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"faq1-2" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.webview1 loadHTMLString:htmlString baseURL:nil];


}

- (IBAction)billingbuttonclick:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadWebdata1];
            [self.tableview reloadData];
            [hud hideAnimated:YES];
        });
        
    });
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"faq2-2" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.webview1 loadHTMLString:htmlString baseURL:nil];
}

- (IBAction)billinginfobuttonclick:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadWebdata];
            [self.tableview reloadData];
            [hud hideAnimated:YES];
        });
        
    });
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"faq3-2" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.webview1 loadHTMLString:htmlString baseURL:nil];

}
@end
