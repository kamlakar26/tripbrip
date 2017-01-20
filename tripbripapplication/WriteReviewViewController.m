//
//  WriteReviewViewController.m
//  tripbripapplication
//
//  Created by mac on 11/28/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "WriteReviewViewController.h"
#import "StarRatingView.h"
#import "ReviewCell.h"
#import "UIImageView+WebCache.h"
#import "DBManager.h"
#import "Reachability.h"
@interface WriteReviewViewController ()
@property (strong,nonatomic) NSArray *colors;
@property (nonatomic, strong) DBManager *dbManager;
@property(nonatomic,retain)NSArray *userarray;
@property(nonatomic,retain)NSString *userid;
@property(nonatomic,retain)NSString *username;
@property(nonatomic,retain)NSMutableArray *DataArray;

@end
@implementation WriteReviewViewController
@synthesize starRating=_starRating;
@synthesize starRatingLabel = _starRatingLabel;

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
    
    _usertextreview.text = @"Enter your review";
    _usertextreview.textColor = [UIColor lightGrayColor];
    _usertextreview.delegate = self;
    
    [self selectUserID];
  _view1.hidden=YES;
    _view2.hidden=YES;
 self.navigationItem.title=_passplasestring;
    self.aleartlab.text=[NSString stringWithFormat:@"%@ ?",_passplasestring];
     self.aleartlab2.text=[NSString stringWithFormat:@"%@ ?",_passplasestring];
    
    NSURL *imageURL = [NSURL URLWithString:_passimagestring];
    
    [_placeimage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"image1.jpg"]];
       
    
    
    
    
    _DataArray=[[NSMutableArray alloc]init];
    [self showreviewinformationwebservices];
    
    
   // [self.tableview reloadData];
    self.tableview.delegate=self;
    // Do any additional setup after loading the view.
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    _usertextreview.text = @"";
    _usertextreview.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(_usertextreview.text.length == 0){
        _usertextreview.textColor = [UIColor lightGrayColor];
        _usertextreview.text = @"Enter your review";
        [_usertextreview resignFirstResponder];
    }
}
-(void)selectUserID
{
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"trip.sqlite"];
    
    NSString *query26;
    //if (self.recordIDToEdit == -1) {
    query26=@"SELECT Satus2,fullname from Logintable1";
    //}
    [self.dbManager executeQuery:query26];
    
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    // Get the results.
    if (self.userarray != nil) {
        self.userarray = nil;
    }
    self.userarray=[[NSMutableArray alloc]init];
    
    self.userarray = [[NSMutableArray alloc]initWithArray:[self.dbManager loadDataFromDB:query26]];
    NSLog(@"total......%@",self.userarray);
    _userid = [[self.userarray objectAtIndex:0] objectAtIndex:0];
    _username = [[self.userarray objectAtIndex:0] objectAtIndex:1];
    
}

-(void)ratingwebservices
{
    
    NSInteger success = 0;
    @try {
        
        NSString *post =[[NSString alloc] initWithFormat:@"image_id=%@&points=%@&user_name=%@&review=%@&user_id=%@",_passimageid,_string1,_username,self.usertextreview.text,_userid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/places_star_ios.php"];
        
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
            NSDictionary *ratingjson = [NSJSONSerialization
                                        JSONObjectWithData:urlData
                                        options:NSJSONReadingMutableContainers
                                        error:&error];
            
            NSMutableArray *DataArray=[ratingjson objectForKey:@"result"];
            
//            if (!_usertextreview.text)  // if the textfield's text is null
//            {
//                [DataArray addObject:[NSNull null]];
//            }
            
            NSLog(@"%@jjjj",ratingjson);
            
            
            success = [ratingjson[@"success"] integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            if(success == 1)
            {
                [self showreviewinformationwebservices];
                [self.tableview reloadData];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thank You..!!"
                                                                    message:@""
                                                                   delegate:self
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil, nil];
                //alertView.tag = tag;
                [alertView show];

                NSLog(@"Login SUCCESS");
                
                
            }
            if(success == 0)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello"
                                                                    message:@"You All Ready Registred Your Review For This Place!!"
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
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        //[self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
    if (success) {
        NSLog(@"login succeess");
    }
}





-(void)showreviewinformationwebservices
{
    
    NSInteger success = 0;
    @try {
        
        NSString *post =[[NSString alloc] initWithFormat:@"image_id=%@",_passimageid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/places_show_ios.php"];
        
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
            NSDictionary *ratingjson = [NSJSONSerialization
                                        JSONObjectWithData:urlData
                                        options:NSJSONReadingMutableContainers
                                        error:&error];
            
            _DataArray=[ratingjson objectForKey:@"result"];
            NSLog(@"%@111",_DataArray);
            
//            for (int i=0; i<[_DataArray count]; i++) {
//                
////                
////                if (!_usertextreview.text)  // if the textfield's text is null
////                {
////                    [_DataArray addObject:[NSNull null]];
////                }
//                
//            }
            
            NSLog(@"%@jjjj",ratingjson);
            
            
            success = [ratingjson[@"success"] integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            if(success == 1)
            {
                
                NSLog(@"Login SUCCESS");
                
                
            }
            if(success == 0)
            {
               
                //[alertView show];
                
                
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
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        //[self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
    if (success) {
        NSLog(@"login succeess");
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > _usertextreview.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [_usertextreview.text length] + [string length] - range.length;
    return newLength <= 15;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitreviewbuttonclick:(id)sender {
    
    
    
    if ([self.usertextreview.text length] <= 15) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                            message:@"Enter some text"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
        
    }
    else{
        _view2.hidden=YES;
        [self ratingwebservices];
    }
}

- (IBAction)backtoratingbuttonclick:(id)sender {
    _view1.hidden=NO;
    _view2.hidden=YES;
}

- (IBAction)writereviewbuttonclick:(id)sender {
    _starRatingLabel.hidden=YES;
    _view2.hidden=YES;
    _view1.hidden=NO;
    _starRating.hidden=NO;
    _starRating.backgroundColor  = [UIColor clearColor];
    
    _starRating.starImage = [[UIImage imageNamed:@"star-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _starRating.starHighlightedImage = [[UIImage imageNamed:@"star-highlighted-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _starRating.maxRating = 5.0;
    _starRating.delegate = self;
    _starRating.horizontalMargin = 15.0;
    _starRating.editable=YES;
    _starRating.rating= 2.5;
    _starRating.displayMode=EDStarRatingDisplayHalf;
    [_starRating  setNeedsDisplay];
    _starRating.tintColor = self.colors[0];
    [self starsSelectionChanged:_starRating rating:2.5];

}

- (IBAction)tapclick:(id)sender {
    NSLog(@"hiii.....");
    [self.view endEditing:YES];
}
- (void)viewDidUnload
{
    [self setStarRating:nil];
    [self setStarRatingLabel:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)starsSelectionChanged:(EDStarRating *)control rating:(float)rating
{
   _string1 = [NSString stringWithFormat:@"Rating: %.1f", rating];
    if( [control isEqual:_starRating] )
        _starRatingLabel.text = _string1;
    NSLog(@"%@",_string1);
    
    
}


- (IBAction)backbuttonclick:(id)sender {
     _view1.hidden=YES;
    
}

- (IBAction)nextbuttonclick:(id)sender {
    _view2.hidden=NO;
    _view1.hidden=YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _DataArray.count;
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"reviewcell";
    
    
    ReviewCell *cell = (ReviewCell *)[_tableview dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"reviewcell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
   
    if(!_DataArray || !_DataArray.count)
    {
        cell = [[ReviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
    }
    else
    {
    
    
    
    NSDictionary *dict2 = [_DataArray objectAtIndex:indexPath.row];
    
        NSString *jsonImageUrlString1 = [dict2 objectForKey:@"username"];
    if([jsonImageUrlString1 isEqualToString:@"<null>"])
    {
    cell.usernamecell.text=@" ";
    }else{
         cell.usernamecell.text=jsonImageUrlString1;
    }

    
    
    NSDictionary *dict1 = [_DataArray objectAtIndex:indexPath.row];
    
    NSString *jsonImageUrlString2 = [dict1 objectForKey:@"description_review"];
    
    if([jsonImageUrlString2 isEqualToString:@"<null>"])
    {
        cell.reviewcell.text=@" ";
    }else
    {
    cell.reviewcell.text=jsonImageUrlString2;
    }
        cell.buttonreview.hidden=NO;
    }
    if([_string1 isEqualToString:@"Rating: 0.5"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"0.5S.png"];
        [cell.buttonreview setBackgroundImage:buttonImage forState:UIControlStateNormal];
    }
    if([_string1 isEqualToString:@"Rating: 1.0"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"1.0S.png"];
        [cell.buttonreview setBackgroundImage:buttonImage forState:UIControlStateNormal];
        
    }
    if([_string1 isEqualToString:@"Rating: 1.5"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"1.5S.png"];
         [cell.buttonreview setBackgroundImage:buttonImage forState:UIControlStateNormal];
       
    }
    if([_string1 isEqualToString:@"Rating: 2.0"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"2.0S.png"];
        [cell.buttonreview setBackgroundImage:buttonImage forState:UIControlStateNormal];
    }
    if([_starRatingLabel.text isEqualToString:@"Rating: 2.5"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"2.5s.png"];
        [cell.buttonreview setBackgroundImage:buttonImage forState:UIControlStateNormal];
    }
    if([_string1 isEqualToString:@"Rating: 3.0"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"3.0S.png"];
        [cell.buttonreview setBackgroundImage:buttonImage forState:UIControlStateNormal];
    }
    if([_string1 isEqualToString:@"Rating: 3.5"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"3.5s.png"];
         [cell.buttonreview setBackgroundImage:buttonImage forState:UIControlStateNormal];
    }
    
    if([_string1 isEqualToString:@"Rating: 4.0"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"4.0s.png"];
        [cell.buttonreview setBackgroundImage:buttonImage forState:UIControlStateNormal];
    }
    if([_string1 isEqualToString:@"Rating: 4.5"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"4.5S.png"];
        [cell.buttonreview setBackgroundImage:buttonImage forState:UIControlStateNormal];
    }
    if([_string1 isEqualToString:@"Rating: 5.0"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"5Stars.png"];
        [cell.buttonreview setBackgroundImage:buttonImage forState:UIControlStateNormal];
      
        
    }

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

@end
