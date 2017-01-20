//
//  RegisterViewController.h
//  tripbripapplication
//
//  Created by mac on 10/15/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>
@interface RegisterViewController : UIViewController<NSURLConnectionDelegate>
@property (weak, nonatomic) IBOutlet UITextField *fullnameuser;
@property (weak, nonatomic) IBOutlet UITextField *emailiduser;
@property (weak, nonatomic) IBOutlet UITextField *mobilenouser;
@property (nonatomic, strong) NSString *otpstring;
@property (weak, nonatomic) IBOutlet UITextField *passworduser;
@property (weak, nonatomic) IBOutlet UITextField *referralcodeuser;

@property(nonatomic,retain)NSArray *mainArray;

- (IBAction)submitbuttonclick:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;
- (IBAction)tapclcik:(id)sender;

@end
