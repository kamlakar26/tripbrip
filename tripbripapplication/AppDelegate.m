//
//  AppDelegate.m
//  tripbripapplication
//
//  Created by mac on 10/14/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "AppDelegate.h"
//#import <FacebookSDK/FacebookSDK.h>
#import <GoogleMaps/GoogleMaps.h>
//#import <GooglePlaces/GooglePlaces.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [GMSServices provideAPIKey:@"AIzaSyCa19si_6JD2d6BvvcHheIg75ZCKzd3_Kg"];

//    [FBLoginView class];
//    [FBProfilePictureView class];
    
    
    //google login.......................
    
//    NSError* configureError;
//   [[GGLContext sharedInstance] configureWithError: &configureError];
//    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
//    
//    [GIDSignIn sharedInstance].delegate = self;
//
//    [GIDSignIn sharedInstance].clientID = @"488430024631-e90jp1fvdvbr949njh4h0aq370ct6l3u.apps.googleusercontent.com";
    
    
    
    return YES;
}
//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation {
//    NSLog(@"hiiii");
////    return [[GIDSignIn sharedInstance] handleURL:url
////                               sourceApplication:sourceApplication
////                                      annotation:annotation];
//    
//    return [FBAppCall handleOpenURL:url
//                  sourceApplication:sourceApplication];
//
//}



//- (void)signIn:(GIDSignIn *)signIn
//didSignInForUser:(GIDGoogleUser *)user
//     withError:(NSError *)error {
//    // Perform any operations on signed in user here.
//    NSString *userId = user.userID;                  // For client-side use only!
//    NSString *idToken = user.authentication.idToken; // Safe to send to the server
//    NSString *fullName = user.profile.name;
//    NSString *givenName = user.profile.givenName;
//    NSString *familyName = user.profile.familyName;
//    NSString *email = user.profile.email;
//    // [START_EXCLUDE]
//    NSDictionary *statusText = @{@"statusText":
//                                     [NSString stringWithFormat:@"Signed in user: %@",
//                                      fullName]};
//    [[NSNotificationCenter defaultCenter]
//     postNotificationName:@"ToggleAuthUINotification"
//     object:nil
//     userInfo:statusText];
//    // [END_EXCLUDE]
//}
//// [END signin_handler]
//
//// This callback is triggered after the disconnect call that revokes data
//// access to the user's resources has completed.
//// [START disconnect_handler]
//- (void)signIn:(GIDSignIn *)signIn
//didDisconnectWithUser:(GIDGoogleUser *)user
//     withError:(NSError *)error {
//    // Perform any operations when the user disconnects from app here.
//    // [START_EXCLUDE]
//    NSDictionary *statusText = @{@"statusText": @"Disconnected user" };
//    [[NSNotificationCenter defaultCenter]
//     postNotificationName:@"ToggleAuthUINotification"
//     object:nil
//     userInfo:statusText];
//    // [END_EXCLUDE]
//}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
