//
//  LevelsFMAppDelegate.h
//  Levels
//
//  Created by David Turissini on 8/17/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Security/Security.h>

@class UserStationsViewController;
@class LevelsFMViewController;
@class LoginViewController;

@interface LevelsFMAppDelegate : UIResponder <UIApplicationDelegate>

    @property (strong, nonatomic) UIWindow *window;
    @property (nonatomic, retain) LevelsFMViewController *levelsFMViewController;
    @property (nonatomic, retain) UserStationsViewController *userStationsViewController;
    @property (nonatomic, retain) LoginViewController *loginViewController;
@end