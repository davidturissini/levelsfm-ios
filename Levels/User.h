//
//  User.h
//  Levels
//
//  Created by David Turissini on 9/18/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import "Model.h"
#import "Keychain.h"
#import "LevelsFM.h"
#import "Station.h"

@protocol UserDelegate <NSObject>

@optional
- (void) userWillLogin:(id)sender;
- (void) userDidLogin:(id)sender;
- (void) userWillLogout:(id)sender;
- (void) userDidLogout:(id)sender;

@end

@interface User : Model
@property (nonatomic, retain) NSString *token;
@property (nonatomic, retain) Keychain *keychain;
@property (nonatomic, weak) id <UserDelegate> delegate;
- (void)login:(NSString *)username password:(NSString *)password;
- (void)logout;
- (void)fetchStations:(LevelsRequestHandler)completionHandler;
- (BOOL)isLoggedIn;
+ (id)shared;
@end
