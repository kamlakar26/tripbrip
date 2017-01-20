//
//  HelpViewController.h
//  tripbripapplication
//
//  Created by mac on 1/5/17.
//  Copyright © 2017 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface HelpViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionview1;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property(nonatomic,retain)NSDictionary *contactdictionry;
- (IBAction)EMAILbuttonclicks:(id)sender;

- (IBAction)phonecallbutton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *callbutton;

@property (strong, nonatomic) IBOutlet UIButton *emailbutton;
@property(nonatomic,retain)NSMutableArray *contactarray;
@end
