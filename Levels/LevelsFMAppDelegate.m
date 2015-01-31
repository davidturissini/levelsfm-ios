//
//  LevelsFMAppDelegate.m
//  Levels
//
//  Created by David Turissini on 8/17/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "LevelsFMAppDelegate.h"
#import "UserStationsViewController.h"
#import "LevelsFMViewController.h"
#import "SCUI.h"
#import "User.h"


@implementation LevelsFMAppDelegate

@synthesize window, userStationsViewController, levelsFMViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [SCSoundCloud setClientID:@"99308a0184193d62e064cb770f4c1eae"
                       secret:@"8b222f6a853ea509d910ee3e037c6c8b"
                  redirectURL:[NSURL URLWithString:@"sampleproject://oauth"]];
    
    
    
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    levelsFMViewController = [[LevelsFMViewController alloc] initWithNibName:@"LevelsFMViewController" bundle:nil];
    
    
    _user = [User shared];
    _user.delegate = self;
    UIViewController *rootViewController = [self _getRootView];
    
    
    [self _setAVPermissions];
    
    window.rootViewController = rootViewController;
    [window makeKeyAndVisible];
    
    return YES;
}

- (void) _setAVPermissions {
    //[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

- (UIViewController *) _getRootView {
    UIViewController *view;
    
    if ([_user isLoggedIn]) {
        view = [self _createUserStationsViewController];
    } else {
        view = [self _createUserLoginViewController];
    }
    
    return view;
}

- (UIViewController *)_createUserStationsViewController {
    _navController = [[UINavigationController alloc] init];
    userStationsViewController = [[UserStationsViewController alloc] initWithNibName:@"UserStationsViewController" bundle:nil];
    [levelsFMViewController pushViewController:userStationsViewController animated:NO];
    [_navController pushViewController:userStationsViewController animated:NO];
    return _navController;
}

- (UIViewController *)_createUserLoginViewController {
    return [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
}

- (void) userDidLogin:(id)sender {
    NSLog(@"User did login");
    window.rootViewController = [self _createUserStationsViewController];
}

- (void) userWillLogin:(id)sender {
    NSLog(@"User will login");
}

- (void) userDidLogout:(id)sender {
    NSLog(@"User did logout");
    window.rootViewController = [self _createUserLoginViewController];
}

- (void) userWillLogout:(id)sender {
    NSLog(@"User will logout");
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
