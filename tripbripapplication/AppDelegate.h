//
//  AppDelegate.h
//  tripbripapplication
//
//  Created by mac on 10/14/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <GoogleSignIn/GoogleSignIn.h>
//#import <Google/SignIn.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>     //GIDSignInDelegate

@property (strong, nonatomic) UIWindow *window;

@property (weak, nonatomic) UIViewController *paymentOptionVC;
@end

