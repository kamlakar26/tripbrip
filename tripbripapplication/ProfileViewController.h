//
//  ProfileViewController.h
//  tripbripapplication
//
//  Created by mac on 10/17/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *mobiletext;

@property (weak, nonatomic) IBOutlet UITableView *tablview;

@property (weak, nonatomic) IBOutlet UITextField *usernametext;
@property (weak, nonatomic) IBOutlet UITextField *useremailtext;
@property (weak, nonatomic) IBOutlet UITextField *usermobiletext;

@property (weak, nonatomic) IBOutlet UILabel *tripmoneylab;

@property (weak, nonatomic) IBOutlet UIButton *editbtn;

@property (weak, nonatomic) IBOutlet UIImageView *userimage;
@property (strong, nonatomic) IBOutlet UILabel *tripwalletmoneylab;

@property(nonatomic,retain)NSData *profileimage;


@property(nonatomic,retain)NSArray *imagearyya;
@property(nonatomic,retain)NSArray *tittleArray;

@property(nonatomic,retain)NSDictionary *mainarray;
@property(nonatomic,retain)NSMutableArray *DataArray;
@property(nonatomic,retain)NSString *ValidString;
@property (strong, nonatomic) IBOutlet UILabel *walletmoneylab;

@property(nonatomic,retain)NSString *passtripstring;
- (IBAction)logoutbuttonclick:(id)sender;
- (IBAction)editbuttonclick:(id)sender;
- (IBAction)tripwallerbuttonclick:(id)sender;
- (IBAction)profilebutton:(id)sender;


@end
