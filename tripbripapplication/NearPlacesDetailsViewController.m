//
//  NearPlacesDetailsViewController.m
//  tripbripapplication
//
//  Created by mac on 10/22/16.
//  Copyright © 2016 mac. All rights reserved.
//
#define kLabelAllowance 50.0f
#define kStarViewHeight 30.0f
#define kStarViewWidth 160.0f
#define kLeftPadding 5.0f

#import "NearPlacesDetailsViewController.h"
#import "UIImageView+WebCache.h"
#import "NSData+Base64.h"
#import "StarRatingView.h"
#import "WriteReviewViewController.h"
#import "BookACarViewController.h"
#import "Reachability.h"
@interface NearPlacesDetailsViewController ()
@property (weak, nonatomic) IBOutlet EDStarRating *starRating;
@property (weak, nonatomic) IBOutlet UILabel *starRatingLabel;
@property (strong,nonatomic) NSArray *colors;
@property(nonatomic,retain)NSString *plasestring;
@property(nonatomic,retain)NSString *imagestring;
@property(nonatomic,retain)NSString *imgid;
@end

@implementation NearPlacesDetailsViewController

bool isShown = false;

@synthesize mainArray,imagearray1,placelab,descriptionlab,visitelab,routelab,recipeName,imageplaces,dataArray;
- (void)viewDidLoad {
    [super viewDidLoad];
   // _reviewbutton.hidden=YES;
    //_booktripbutton.hidden=YES;
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

    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrlview.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrlview.contentSize = contentRect.size;
 [_scrlview setShowsVerticalScrollIndicator:NO];
    _ratingbutton.hidden=YES;
    _view1.hidden=YES;
    self.navigationItem.title=[dataArray objectAtIndex:1];;
    _view1.layer.cornerRadius = 7;
    _view1.layer.masksToBounds = YES;
    NSLog(@"%@",_imageid);
    [self displayData];
    _view1.hidden=YES;
    _plasestring=[dataArray objectAtIndex:1];
   // self.alertlab.text=[NSString stringWithFormat:@"%@ ?",string];
    //self.starRatingLabel.hidden=YES;
    
            // Do any additional setup after loading the view.
}

-(void)displayData{
//        self.imageplaces.image=[UIImage imageWithData:[[NSData alloc] initWithData:[NSData
//                                                                                  dataFromBase64String:[dataArray objectAtIndex:0]]]];
//   
       _imagestring =[dataArray objectAtIndex:0];

    
    NSURL *imageURL = [NSURL URLWithString:_imagestring];
    
    [imageplaces sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"image1.jpg"]];
    self.placelab.text=[dataArray objectAtIndex:1];
    self.descriptionlab.text=[dataArray objectAtIndex:2];
    self.visitelab.text=[dataArray objectAtIndex:3];
    self.routelab.text=[dataArray objectAtIndex:4];
     _imgid=[dataArray objectAtIndex:5];


    }

-(void)ratingwebservices
{
    
    NSInteger success = 0;
    @try {
        
        NSString *post =[[NSString alloc] initWithFormat:@"image_id=%@&points=%@",_imageid,_string1];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/place_star_ios.php"];
        
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
            
        NSArray *DataArray=[ratingjson objectForKey:@"result"];
            
            
            
            NSLog(@"%@jjjj",ratingjson);
            
            
            success = [ratingjson[@"success"] integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            if(success == 1)
            {
                
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Rating:(id)sender {
    _view1.hidden=NO;
    _starRating.hidden=NO;
    _starRating.backgroundColor  = [UIColor clearColor];
    
    _starRating.starImage = [[UIImage imageNamed:@"star-template@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _starRating.starHighlightedImage = [[UIImage imageNamed:@"star-highlighted-template@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _starRating.maxRating = 5.0;
    _starRating.delegate = self;
    _starRating.horizontalMargin = 15.0;
    _starRating.editable=YES;
    _starRating.rating= 2.5;
    _starRating.displayMode=EDStarRatingDisplayHalf;
    [_starRating  setNeedsDisplay];
    _starRating.tintColor = self.colors[0];
    [self starsSelectionChanged:_starRating rating:2.5];

    
    
//    if (!isShown) {
//      
//        [UIView animateWithDuration:0.25 animations:^{
//            
//        }];
//        isShown = true;
//      StarRatingView* starViewNoLabel = [[StarRatingView alloc]initWithFrame:CGRectMake(50, 150, kStarViewWidth+kLeftPadding, kStarViewHeight) andRating:50 withLabel:NO animated:YES];
//        [self.view1 addSubview:starViewNoLabel];
//
//    } else {
//        [UIView animateWithDuration:0.25 animations:^{
//            
//        }];
//        isShown = false;
//        StarRatingView* starViewNoLabel = [[StarRatingView alloc]initWithFrame:CGRectMake(50, 150, kStarViewWidth+kLeftPadding, kStarViewHeight) andRating:50 withLabel:NO animated:YES];
//        [self.view1 addSubview:starViewNoLabel];
//    }
  
    


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
    _string1= [NSString stringWithFormat:@"Rating: %.1f", rating];
    if( [control isEqual:_starRating] )
        _starRatingLabel.text = _string1;
    _ratingbutton.titleLabel.text=_string1;
    
    NSLog(@"%@dd",_string1);

    
    
}

- (IBAction)okbuttonclick:(id)sender {
   
    [self ratingwebservices];
   // _starRatingLabel.text=_string1;
    NSLog(@"%@22",_string1);
    if([_starRatingLabel.text isEqualToString:@"Rating: 0.5"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"5starsgray.png"];
        [_ratingbutton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.view addSubview:_ratingbutton];
    }
    if([_starRatingLabel.text isEqualToString:@"Rating: 1.0"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"5-green-stars-e1435960250936.png"];
        [_ratingbutton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.view addSubview:_ratingbutton];
        
    }
    if([_starRatingLabel.text isEqualToString:@"Rating: 1.5"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"5starsgray.png"];
        [_ratingbutton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.view addSubview:_ratingbutton];
    }
    if([_starRatingLabel.text isEqualToString:@"Rating: 2.0"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"5-green-stars-e1435960250936.png"];
        [_ratingbutton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.view addSubview:_ratingbutton];
        
    }
    if([_starRatingLabel.text isEqualToString:@"Rating: 2.5"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"5starsgray.png"];
        [_ratingbutton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.view addSubview:_ratingbutton];
    }
    if([_starRatingLabel.text isEqualToString:@"Rating: 3.0"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"5-green-stars-e1435960250936.png"];
        [_ratingbutton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.view addSubview:_ratingbutton];
        
    }
    if([_starRatingLabel.text isEqualToString:@"Rating: 3.5"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"5-green-stars-e1435960250936.png"];
        [_ratingbutton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.view addSubview:_ratingbutton];
        
    }
    
    if([_starRatingLabel.text isEqualToString:@"Rating: 4.0"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"5-green-stars-e1435960250936.png"];
        [_ratingbutton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.view addSubview:_ratingbutton];
        
    }
    if([_starRatingLabel.text isEqualToString:@"Rating: 4.5"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"5-green-stars-e1435960250936.png"];
        [_ratingbutton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.view addSubview:_ratingbutton];
        
    }
    if([_starRatingLabel.text isEqualToString:@"Rating: 5.0"])
    {
        UIImage *buttonImage = [UIImage imageNamed:@"5-green-stars-e1435960250936.png"];
        [_ratingbutton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.view addSubview:_ratingbutton];
        
    }
    
    _view1.hidden=YES;
    _starRating.hidden=YES;
}

- (IBAction)reviewbuttonclick:(id)sender {
    WriteReviewViewController *destViewController= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WriteReviewViewController"];
    destViewController.passplasestring =_plasestring;
    destViewController.passimagestring=_imagestring;
    destViewController.passimageid=_imgid;
    [self.navigationController pushViewController:destViewController animated:YES];

}

- (IBAction)booktripbuttonclick:(id)sender {
    
    BookACarViewController *destViewController= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BookACarViewController"];
    destViewController.passstring=self.placelab.text;
       [self.navigationController pushViewController:destViewController animated:YES];

    
}

- (IBAction)asmelater:(id)sender {
    _view1.hidden=YES;

}
@end
