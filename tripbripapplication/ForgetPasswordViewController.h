//
//  ForgetPasswordViewController.h
//  tripbripapplication
//
//  Created by mac on 11/7/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *Forgettext;
@property(nonatomic,retain)NSString *otpstring;

- (IBAction)submitbuttonclick:(id)sender;
- (IBAction)tapbuttonclick:(id)sender;


@end
