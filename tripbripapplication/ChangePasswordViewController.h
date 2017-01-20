//
//  ChangePasswordViewController.h
//  tripbripapplication
//
//  Created by mac on 11/7/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *newpasswordtext;

@property (weak, nonatomic) IBOutlet UITextField *Confirpasswordtext;
@property(nonatomic,retain)NSString *mobileno;
- (IBAction)submitclick:(id)sender;
- (IBAction)tapbuttonclick:(id)sender;
@end
