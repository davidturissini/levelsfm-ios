//
//  LevelsFMAppDelegate.h
//  Levels
//
//  Created by David Turissini on 8/17/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Security/Security.h>
#import "LevelsFM.h"
#import "User.h"
#import "LoginViewController.h"

@class UserStationsViewController;
@class LevelsFMViewController;

@interface LevelsFMAppDelegate : UIResponder <UIApplicationDelegate, UserDelegate>

    @property (strong, nonatomic) UIWindow *window;
    @property (nonatomic, retain) LevelsFMViewController *levelsFMViewController;
    @property (nonatomic, retain) UserStationsViewController *userStationsViewController;
    @property (nonatomic, retain) LoginViewController *loginViewController;
    @property (nonatomic, retain) UINavigationController *navController;
    @property (nonatomic, retain) LevelsFM *levels;
    @property (nonatomic, retain) User *user;
@end