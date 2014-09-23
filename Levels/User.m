//
//  User.m
//  Levels
//
//  Created by David Turissini on 9/18/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import "User.h"
#import "LevelsFM.h"

@implementation User

- (NSURLConnection *)login:(NSString *)username password:(NSString *)password {
   
    LevelsFM *levels = [[LevelsFM alloc] init];
    NSDictionary *loginParams = [[NSDictionary alloc] initWithObjectsAndKeys:username, @"username", password, @"password", nil];
    

    NSURLConnection *connection = [levels request:@"/login" params:loginParams method:@"POST"];
    
    return connection;
}

+ (id)shared {
    static User *appUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appUser = [[self alloc] init];
    });
    return appUser;
}

@end
