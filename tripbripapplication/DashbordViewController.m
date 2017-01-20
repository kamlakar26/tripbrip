//
//  DashbordViewController.m
//  tripbripapplication
//
//  Created by mac on 10/17/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "DashbordViewController.h"
#import "PuneViewController.h"
#import "OfferViewController.h"
#import "HowWeWorkViewController.h"
#import "TraficViewController.h"
#import "PolicyViewController.h"
#import "ContacUsViewController.h"
#import "ProfileViewController.h"
#import "BookACarViewController.h"
#import "NearPlacePuneViewController.h"
#import "UIImageView+WebCache.h"
#import "Reachability.h"
#import "DashbordCollectionViewCell.h"
#import "ModelViewController.h"
#import "CarImageCollectionViewCell.h"

@interface DashbordViewController ()
{
    UICollectionViewFlowLayout *portraitLayout;
    

}@property(nonatomic,retain)NSString *str1;
@property(nonatomic,retain)NSString *str2;
@property(nonatomic,retain)NSString *str3;
@property(nonatomic,retain)NSString *str4;
@property(nonatomic,retain)NSString *str5;
@property(nonatomic,retain)NSString *str6;
@property(nonatomic,retain)NSString *str7;
@property(nonatomic,retain)NSString *passstring;
@property (weak, nonatomic) IBOutlet UIImageView *imagescroll;

@end

@implementation DashbordViewController
@synthesize bookcarscroll,nearpleacescrollview;
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    _pagecontrol.transform = CGAffineTransformMakeScale(0.7, 0.7);
    
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
    
    
    _str1= _button1.titleLabel.text=@"5";
    _str2=_button2.titleLabel.text=@"3";
    _str3= _button3.titleLabel.text=@"2";
     _str4= _button4.titleLabel.text=@"1";
    _str5= _button5.titleLabel.text=@"4";
    _str6=_button6.titleLabel.text=@"6";
    _str7=_button6.titleLabel.text=@"7";

    self.navigationItem.hidesBackButton = YES;
    
    self.navigationItem.title=@"TripBrip";

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
      UINavigationController* nc = (UINavigationController*)[[[UIApplication sharedApplication] delegate] window].rootViewController;
    [nc.navigationBar setBarTintColor:[UIColor blueColor]];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [bookcarscroll setShowsHorizontalScrollIndicator:NO];
    [nearpleacescrollview setShowsHorizontalScrollIndicator:NO];
     [_scrollview2 setShowsVerticalScrollIndicator:NO];
    
    // self.scrollview2.contentSize =CGSizeMake(_scrollview2.bounds.size.width, 1000);
    
    
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrollview2.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrollview2.contentSize = contentRect.size;
    
    CGRect contentRect1 = CGRectZero;
    for (UIView *view in self.bookcarscroll.subviews) {
        contentRect1 = CGRectUnion(contentRect1, view.frame);
    }
    self.bookcarscroll.contentSize = contentRect1.size;
    
    CGRect contentRect2 = CGRectZero;
    for (UIView *view in self.nearpleacescrollview.subviews) {
        contentRect2 = CGRectUnion(contentRect2, view.frame);
    }
    self.nearpleacescrollview.contentSize = contentRect2.size;
    ///////imagecoureve..............
    
    self.scrolllimage.layer.cornerRadius = self.scrolllimage.frame.size.height / 12;
    self.scrolllimage.layer.masksToBounds = YES;
    self.scrolllimage.layer.borderWidth = 0;
    self.scrolllimage.contentMode = UIViewContentModeScaleAspectFill;
    
    self.imagebook2.layer.cornerRadius = self.scrolllimage.frame.size.height / 12;
    self.imagebook2.layer.masksToBounds = YES;
    self.imagebook2.layer.borderWidth = 0;
    self.imagebook2.contentMode = UIViewContentModeScaleAspectFill;

    self.imagebook3.layer.cornerRadius = self.scrolllimage.frame.size.height / 12;
    self.imagebook3.layer.masksToBounds = YES;
    self.imagebook3.layer.borderWidth = 0;
    self.imagebook3.contentMode = UIViewContentModeScaleAspectFill;

    self.imagebook4.layer.cornerRadius = self.scrolllimage.frame.size.height / 12;
    self.imagebook4.layer.masksToBounds = YES;
    self.imagebook4.layer.borderWidth = 0;
    self.imagebook4.contentMode = UIViewContentModeScaleAspectFill;

    self.button1.layer.cornerRadius = self.scrolllimage.frame.size.height / 14;
    self.button1.layer.masksToBounds = YES;
    self.button1.layer.borderWidth = 0;
    self.button1.contentMode = UIViewContentModeScaleAspectFill;

    self.button2.layer.cornerRadius = self.scrolllimage.frame.size.height / 14;
    self.button2.layer.masksToBounds = YES;
    self.button2.layer.borderWidth = 0;
    self.button2.contentMode = UIViewContentModeScaleAspectFill;

    self.button3.layer.cornerRadius = self.scrolllimage.frame.size.height / 14;
    self.button3.layer.masksToBounds = YES;
    self.button3.layer.borderWidth = 0;
    self.button3.contentMode = UIViewContentModeScaleAspectFill;

    self.button4.layer.cornerRadius = self.scrolllimage.frame.size.height / 14;
    self.button4.layer.masksToBounds = YES;
    self.button4.layer.borderWidth = 0;
    self.button4.contentMode = UIViewContentModeScaleAspectFill;

    self.button5.layer.cornerRadius = self.scrolllimage.frame.size.height / 14;
    self.button5.layer.masksToBounds = YES;
    self.button5.layer.borderWidth = 0;
    self.button5.contentMode = UIViewContentModeScaleAspectFill;

    self.button6.layer.cornerRadius = self.scrolllimage.frame.size.height / 14;
    self.button6.layer.masksToBounds = YES;
    self.button6.layer.borderWidth = 0;
    self.button6.contentMode = UIViewContentModeScaleAspectFill;
    
    self.button7.layer.cornerRadius = self.scrolllimage.frame.size.height / 14;
    self.button7.layer.masksToBounds = YES;
    self.button7.layer.borderWidth = 0;
    self.button7.contentMode = UIViewContentModeScaleAspectFill;
    
    self.tabbar.delegate=self;
    _imagesData=[[NSMutableArray alloc]init];
    _carimagedata=[[NSMutableArray alloc]init];
    
   // self.imagesData = @[@"1.-min.png", @"2.-min.png", @"3.-min.png"];
    
    [self setupScrollViewImages];
    
    for (UIScrollView *scrollView in self.scrollViews) {
        scrollView.delegate = self;
    }
    
     //TAPageControl from storyboard
    self.customStoryboardPageControl.numberOfPages = self.imagesData.count;
    
    
   ////////tabbar item...........
    
    self.tabbar.translucent = false;
    self.tabbar.tintColor = [UIColor whiteColor];
    for (int i=0; i<4; i++)
    {
        UITabBarItem *tab = [self.tabbar.items objectAtIndex:i];
        tab.image = [tab.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    }
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:52.0/255.0 green:111.0/255.0 blue:147.0/255.0 alpha:1.0] }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }
                                             forState:UIControlStateSelected];
    
    ///////////// TapGesture........Book A car
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    singleTapGestureRecognizer.enabled = YES;
    singleTapGestureRecognizer.cancelsTouchesInView = NO;
    [bookcarscroll addGestureRecognizer:singleTapGestureRecognizer];
   // _imagesData=[[NSArray alloc]init];
    portraitLayout = [[UICollectionViewFlowLayout alloc] init];
   
    [self loadcardata];
    [self loadcardata1];
    [self.collectionview reloadData];
    [self.collectionview1 reloadData];
    
    self.collectionview.delegate=self;
    self.collectionview.dataSource=self;
    self.collectionview1.dataSource=self;
    self.collectionview1.delegate=self;
//
//    UITapGestureRecognizer *singleTapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap1:)];
//    singleTapGestureRecognizer1.numberOfTapsRequired = 1;
//    singleTapGestureRecognizer1.enabled = YES;
//    singleTapGestureRecognizer1.cancelsTouchesInView = NO;
//    [nearpleacescrollview addGestureRecognizer:singleTapGestureRecognizer1];
    

    
    
    // note that the view contains a UIScrollView in aScrollView
    
//    NSArray *imagesArray = [NSArray arrayWithObjects:@"book_1.png", @"book_2.png", @"book_3.png",@"book_4.png", nil];
//    
//    [bookcarscroll setPagingEnabled:NO];
//    [bookcarscroll setAlwaysBounceVertical:NO];
//    for (int i = 0; i < [imagesArray count]; i++)
//    {
//        CGFloat xOrigin = i * bookcarscroll.frame.size.width;
//        
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xOrigin, 0, bookcarscroll.frame.size.width, bookcarscroll.frame.size.height)];
//        [imageView setImage:[UIImage imageNamed:[imagesArray objectAtIndex:i]]];
//        [imageView setContentMode:UIViewContentModeScaleAspectFit];
//        
//        [bookcarscroll addSubview:imageView];
//    }
//    
//    [bookcarscroll setContentSize:CGSizeMake(bookcarscroll.frame.size.width * [imagesArray count], bookcarscroll.frame.size.height)];

    
//    NSArray *imagesArray1 = [NSArray arrayWithObjects:@"place_1.png", @"place_2.png", @"place_3.png",@"place_4.png",@"place_5.png", nil];
//    
//    for (int i = 0; i < [imagesArray1 count]; i++)
//    {
//        CGFloat xOrigin = i * nearpleacescrollview.frame.size.width;
//        
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xOrigin, 0, nearpleacescrollview.frame.size.width, nearpleacescrollview.frame.size.height)];
//        [imageView setImage:[UIImage imageNamed:[imagesArray1 objectAtIndex:i]]];
//        [imageView setContentMode:UIViewContentModeScaleAspectFit];
//        
//        [nearpleacescrollview addSubview:imageView];
//    }
//    
//    [nearpleacescrollview setContentSize:CGSizeMake(nearpleacescrollview.frame.size.width * [imagesArray count], nearpleacescrollview.frame.size.height)];
//
    
   
    // Do any additional setup after loading the view.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

     if (collectionView == self.collectionview) {
         
         return _imagesData.count;
         
     }else{
         return _carimagedata.count;
     }
    
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == self.collectionview) {
    
    static NSString *identifier = @"collectioncell";
    
    DashbordCollectionViewCell *cell = (DashbordCollectionViewCell *)[_collectionview dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"collectioncell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
        NSDictionary *dict = [_imagesData objectAtIndex:indexPath.row];
        
        NSString *jsonImageUrlString = [dict objectForKey:@"slider_image"];
        
        NSURL *imageURL = [NSURL URLWithString:jsonImageUrlString];
        
        [cell.collectionimage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placelogo.png"]];
        
        int pages = floor(collectionView.contentSize.width/collectionView.frame.size.width);
        [_pagecontrol setNumberOfPages:pages];
        return cell;

    }
   else
    {
        static NSString *identifier = @"collectioncell1";
        
        CarImageCollectionViewCell *cell = (CarImageCollectionViewCell *)[_collectionview1 dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"collectioncell1" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        NSDictionary *dict = [_carimagedata objectAtIndex:indexPath.row];
        
        NSString *jsonImageUrlString = [dict objectForKey:@"vehicle_cat_url2"];
        
        NSURL *imageURL = [NSURL URLWithString:jsonImageUrlString];
        
        [cell.carimages sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placelogo.png"]];
     
        return cell;
    
    }
    
    //cell.pagecontrol=[_imagedata objectAtIndex:indexPath.row];
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize returnSize = CGSizeZero;
    
    if (collectionViewLayout == portraitLayout) {
        returnSize = CGSizeMake(320.0, 180.0);
    } else {
        returnSize = CGSizeMake(320.0, 180.0);
    }
    
    return returnSize;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    ModelViewController *destViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ModelViewController"];
    destViewController.vehicalid = [NSString stringWithFormat:@"%@", self.carimagedata[indexPath.row][@"id"]];
 //   destViewController.passperkmrs = [NSString stringWithFormat:@"%@", self.carimagedata[indexPath.row][@"Per_Km_Rate"]];
    destViewController.passnightcharges = [NSString stringWithFormat:@"%@", self.carimagedata[indexPath.row][@"Night_Charges"]];
    destViewController.passplacelab=_passstring;
    destViewController.passperkm = [NSString stringWithFormat:@"%@", self.carimagedata[indexPath.row][@"min_kms"]];
    [self.navigationController pushViewController:destViewController animated:YES];

    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _collectionview.frame.size.width;
    float currentPage = _collectionview.contentOffset.x / pageWidth;
    
    if (0.0f != fmodf(currentPage, 1.0f))
    {
        _pagecontrol.currentPage = currentPage + 1;
    }
    else
    {
        _pagecontrol.currentPage = currentPage;
    }
    NSLog(@"finishPage: %ld", (long)_pagecontrol.currentPage);
}
///////TIMER SLIDER
//- (void) viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    // start repeatable method
//    [self performSelector:@selector(makeTick) withObject:nil afterDelay:8.0f];
//}
//
//- (void) makeTick {
//    
//    [self performSelector:@selector(makeTick) withObject:nil afterDelay:8.0f];
//    
//    // Calclulate new offset
//    CGPoint pt = self.scrollView1.contentOffset;
//    pt.x += self.scrollView1.frame.size.width;
//    // If it's a last subview in scrollview return back
//    if (!(pt.x < self.scrollView1.contentSize.width)) {
//        pt.x = 0;
//    }
//    [self.scrollView1 setContentOffset:pt animated:YES];
//}

-(void)loadcardata{
    NSInteger success = 0;
    @try {
        
        NSString *tag=@"scrollimages";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@",tag];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/slider_ios.php"];
        
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
            NSDictionary *dictionay1 = [NSJSONSerialization
                         JSONObjectWithData:urlData
                         options:NSJSONReadingMutableContainers
                         error:&error];
            
            _imagesData=[dictionay1 objectForKey:@"result"];
          
            for (int i=0; i<[_imagesData count]; i++) {
                
                NSDictionary *dic=[_imagesData objectAtIndex:0];
                
                NSString *str= [dic objectForKey:@"slider_image"];
                NSLog(@"iiiiii%@",str);
                
                
            }

            
            
            success = [dictionay1[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 1)
            {
               


                NSLog(@"Login SUCCESS");
                
            }
            if(success == 0)
            {
                                NSLog(@"failure");
                
            }
            else {
                
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


-(void)loadcardata1{
    NSInteger success = 0;
    @try {
        
        NSString *tag=@"scrollimages";
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
            NSDictionary *dictionay1 = [NSJSONSerialization
                                        JSONObjectWithData:urlData
                                        options:NSJSONReadingMutableContainers
                                        error:&error];
            
            _carimagedata=[dictionay1 objectForKey:@"result"];
            
            for (int i=0; i<[_carimagedata count]; i++) {
                
                NSDictionary *dic=[_carimagedata objectAtIndex:i];
                
                NSString *str= [dic objectForKey:@"vehicle_cat_url2"];
                NSString *str1=[dic objectForKey:@"id"];
                NSString *str2=[dic objectForKey:@"Per_Km_Rate"];
                NSString *str3=[dic objectForKey:@"Night_Charges"];
                
                NSLog(@"iiiiii%@",str);
                 NSLog(@"iiiiii%@",str1);
                 NSLog(@"iiiiii%@",str2);
                 NSLog(@"iiiiii%@",str3);
                
            }
            
            
            
            success = [dictionay1[@"success"]integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 1)
            {
                
                
                
                NSLog(@"Login SUCCESS");
                
            }
            if(success == 0)
            {
                NSLog(@"failure");
                
            }
            else {
                
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


- (void)singleTap:(UITapGestureRecognizer *)gesture {
    BookACarViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BookACarViewController"];
       [self.navigationController pushViewController:vc animated:YES];

    //handle taps
}
//- (void)singleTap1:(UITapGestureRecognizer *)gesture {
//    NearPlacePuneViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NearPlacePuneViewController"];
//    [self.navigationController pushViewController:vc animated:YES];
//    
//    //handle taps
//}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    for (UIScrollView *scrollView in self.scrollViews) {
        
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.frame) * self.imagesData.count, CGRectGetHeight(scrollView.frame));
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    
    
        self.customStoryboardPageControl.currentPage = pageIndex;
    
}

- (void)setupScrollViewImages
{
    for (UIScrollView *scrollView in self.scrollViews) {
        for (int i=0;i<[_imagesData count];i++)
        {
           [_imagesData enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL *stop) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(scrollView.frame) * idx, 0, CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame))];
               
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.image = [UIImage imageNamed:imageName];

            [scrollView addSubview:imageView];
           
            
        }];
        }
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
   
    if([item.title  isEqual: @"About Us"])
    {
        [self performSegueWithIdentifier:@"howwework" sender:item];
        
    }
    if([item.title  isEqual: @"Policy"])
    {
        [self performSegueWithIdentifier:@"Policy" sender:item];
        
    }
    
    if([item.title  isEqual: @"Booking History"])
    {
        [self performSegueWithIdentifier:@"history" sender:item];
        
    }
    if([item.title  isEqual: @"Profile"])
    {
        [self performSegueWithIdentifier:@"Profile" sender:item];
        
    }
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
//    if ([segue.identifier isEqualToString:@"carsegue"]) {
//        NSIndexPath *indexPath = [self.collectionview1 indexPathsForSelectedItems];
//        ModelViewController *destViewController = segue.destinationViewController;
//        destViewController.vehicalid = self.carimagedata[indexPath.row][0][@"id"];
//        destViewController.passperkmrs =self.carimagedata[indexPath.row][0][@"Per_Km_Rate"];
//        destViewController.passnightcharges =self.carimagedata[indexPath.row][0][@"Night_Charges"];
//      
//        //destViewController.passplacelab=_passstring;
//    }

    
    
    
    
    
    
   
    if([segue.identifier isEqualToString:@"howwework"]){
        HowWeWorkViewController *detail2 = segue.destinationViewController;
    }
    if([segue.identifier isEqualToString:@"Policy"]){
        PolicyViewController *detail3 = segue.destinationViewController;
    }
    
    if([segue.identifier isEqualToString:@"history"]){
        ContacUsViewController *detail5 = segue.destinationViewController;
    }
    if([segue.identifier isEqualToString:@"Profile"]){
        ProfileViewController *detail6 = segue.destinationViewController;
        detail6.profileimage=_passimage;
    }
    if([segue.identifier isEqualToString:@"bookcar"]){
        BookACarViewController *detail6 = segue.destinationViewController;
    }
    if([segue.identifier isEqualToString:@"nearplaces"]){
        NearPlacePuneViewController *detail6 = segue.destinationViewController;
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)BookACarbuttonclick:(id)sender {
    //[self performSegueWithIdentifier:@"bookcar" sender:sender];

}

- (IBAction)NearPlacePune:(id)sender {
   // [self performSegueWithIdentifier:@"nearplaces" sender:sender];

}
- (IBAction)button1click:(id)sender {
    NearPlacePuneViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NearPlacePuneViewController"];
    vc.passbutton1=_str1;
       [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)button2click:(id)sender {
    NearPlacePuneViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NearPlacePuneViewController"];
    vc.passbutton1=_str2;
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)button3:(id)sender {
    NearPlacePuneViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NearPlacePuneViewController"];
    vc.passbutton1=_str3;
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)button4click:(id)sender {
    NearPlacePuneViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NearPlacePuneViewController"];
    vc.passbutton1=_str4;
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)button5click:(id)sender {
    NearPlacePuneViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NearPlacePuneViewController"];
    vc.passbutton1=_str5;
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)button6click:(id)sender {
    NearPlacePuneViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NearPlacePuneViewController"];
    vc.passbutton1=_str6;
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)button7click:(id)sender {
    NearPlacePuneViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NearPlacePuneViewController"];
    vc.passbutton1=_str7;
    [self.navigationController pushViewController:vc animated:YES];

}
@end
