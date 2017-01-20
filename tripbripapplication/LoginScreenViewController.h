//
//  LoginScreenViewController.h
//  tripbripapplication
//
//  Created by mac on 10/14/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <FacebookSDK/FacebookSDK.h>
//#import <GoogleSignIn/GoogleSignIn.h>
@interface LoginScreenViewController : UIViewController//<FBLoginViewDelegate>  //,GIDSignInUIDelegate

//@property (weak, nonatomic) IBOutlet FBLoginView *loginButton;

//@property(weak, nonatomic) IBOutlet GIDSignInButton *signInButton;

@property (weak, nonatomic) IBOutlet UITextField *usermobile;

@property (weak, nonatomic) IBOutlet UITextField *userpassword;
@property (weak, nonatomic) IBOutlet UILabel *showpassword;
@property (weak, nonatomic) IBOutlet UIButton *showbutton;
@property(nonatomic,retain)NSMutableArray *array;

@property(nonatomic,retain)NSString *userid;
@property(nonatomic,retain)NSString *username;
@property(nonatomic,retain)NSString *emailid;
@property(nonatomic,retain)NSData *imagedata;

- (IBAction)signupbuttonclick:(id)sender;

- (IBAction)Loginbuttonclick:(id)sender;
- (IBAction)showpasswordbuttonclick:(id)sender;
- (IBAction)linkbuttonclick:(id)sender;
- (IBAction)tapclick:(id)sender;

@end
