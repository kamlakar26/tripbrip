//
//  DashbordViewController.h
//  tripbripapplication
//
//  Created by mac on 10/17/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAExampleDotView.h"
#import "TAPageControl.h"
@interface DashbordViewController : UIViewController<UITabBarDelegate,UITabBarControllerDelegate,UIScrollViewDelegate, TAPageControlDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet TAPageControl *customStoryboardPageControl;

@property (strong, nonatomic) IBOutletCollection(UIScrollView) NSArray *scrollViews;
@property (weak, nonatomic) IBOutlet UIImageView *scrolllimage;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView1;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview2;
@property (weak, nonatomic) IBOutlet UIScrollView *bookcarscroll;
@property (weak, nonatomic) IBOutlet UIImageView *bookimage;

@property (weak, nonatomic) IBOutlet UIScrollView *nearpleacescrollview;

@property (weak, nonatomic) IBOutlet UITabBar *tabbar;

@property (weak, nonatomic) IBOutlet UIImageView *imagebook2;
@property (weak, nonatomic) IBOutlet UIImageView *imagebook3;
@property (weak, nonatomic) IBOutlet UIImageView *imagebook4;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;

@property (strong, nonatomic) IBOutlet UIPageControl *pagecontrol;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionview;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionview1;
@property (strong, nonatomic) IBOutlet UIButton *button7;
@property (strong, nonatomic) IBOutlet UIButton *button6;

- (IBAction)button1click:(id)sender;
- (IBAction)button2click:(id)sender;
- (IBAction)button3:(id)sender;

- (IBAction)button4click:(id)sender;
- (IBAction)button5click:(id)sender;
- (IBAction)button6click:(id)sender;
- (IBAction)button7click:(id)sender;



/////ButttonProperty....
@property (weak, nonatomic) IBOutlet UIButton *pune;
@property (weak, nonatomic) IBOutlet UIButton *offer;
@property (weak, nonatomic) IBOutlet UIButton *howwework;
@property (weak, nonatomic) IBOutlet UIButton *policy;
@property (weak, nonatomic) IBOutlet UIButton *trafic;
@property (weak, nonatomic) IBOutlet UIButton *profile;
@property (weak, nonatomic) IBOutlet UIButton *Booking;
////////
@property (strong, nonatomic) NSMutableArray *imagesData;
@property (strong, nonatomic) NSMutableArray *carimagedata;
@property (strong, nonatomic) NSArray *BookCarImage;

@property(nonatomic,retain)NSData *passimage;

- (IBAction)BookACarbuttonclick:(id)sender;
- (IBAction)NearPlacePune:(id)sender;


@end
