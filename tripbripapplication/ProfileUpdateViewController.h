//
//  ProfileUpdateViewController.h
//  tripbripapplication
//
//  Created by mac on 1/3/17.
//  Copyright © 2017 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <stdlib.h>
@interface ProfileUpdateViewController : UIViewController<UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *mobileno;
@property (strong, nonatomic) IBOutlet UIImageView *imageview1;

@property(nonatomic,retain)NSString *passuserid;
@property(nonatomic,retain)NSString *passuser;
@property(nonatomic,retain)NSString *passemail;
@property(nonatomic,retain)NSString *passmobile;
@property (nonatomic,retain)NSString *Base64String;
@property(nonatomic,retain)NSString *FinalBaseString;
@property (nonatomic,retain)NSMutableArray *DataToshowArray;
@property(nonatomic,retain)NSDictionary *mainarray;
@property(nonatomic,retain)NSMutableArray *DataArray;

@property(nonatomic,retain)NSData *imageshow;

@property (strong, nonatomic) IBOutlet UIScrollView *scrolview;


- (IBAction)profileupdatebuttonclick:(id)sender;

- (IBAction)tapclick:(id)sender;
- (IBAction)updatebuttonclick:(id)sender;
@end
