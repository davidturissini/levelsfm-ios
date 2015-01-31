//
//  User.m
//  Levels
//
//  Created by David Turissini on 9/18/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import "User.h"


#define SERVICE_NAME @"LEVELSFM"



@implementation User
@synthesize delegate;

- (id) init {
    self = [super init];
    
    if (self) {
        _keychain = [[Keychain alloc] initWithService:SERVICE_NAME withGroup:nil];
        NSData *tokenData = [_keychain find:@"token"];
    
        if (tokenData) {
            _token = [[NSString alloc] initWithData:tokenData encoding:NSUTF8StringEncoding];
        }
    }
    
    return self;
    
}

- (void) fetchStations:(LevelsRequestHandler)completionHandler {
    return [LevelsFM get:@"/users/daveturissini/stations" params:nil completionHandler:completionHandler];
}

- (BOOL) isLoggedIn {
    NSData *token = [_keychain find:@"token"];
    
    if (token == nil) {
        return NO;
    }
    
    return YES;
    
}

- (void)login:(NSString *)username password:(NSString *)password {
    NSDictionary *loginParams = @{
                                 @"username" : username,
                                 @"password" : password
                                 };
    
    if ([self.delegate respondsToSelector:@selector(userWillLogin:)]) {
        [self.delegate userWillLogin:self];
    }
    
    [LevelsFM post:@"/login"
               params:loginParams
    completionHandler:^(NSDictionary* json, NSURLResponse* response, NSError* error){
        NSString *key = @"token";
        NSData * value = [[json valueForKey:@"token"] dataUsingEncoding:NSUTF8StringEncoding];
        [_keychain insert:key :value];
        
        if ([self.delegate respondsToSelector:@selector(userDidLogin:)]) {
            [self.delegate userDidLogin:self];
        }
        
    }];
    
}

- (void)logout {
    if ([self.delegate respondsToSelector:@selector(userWillLogin:)]) {
        [self.delegate userWillLogout:self];
    }
    
    [LevelsFM get:@"/logout"
            params:nil
 completionHandler:^(NSDictionary* json, NSURLResponse* response, NSError* error){
     [_keychain remove:@"token"];
     
     if ([self.delegate respondsToSelector:@selector(userDidLogout:)]) {
         [self.delegate userDidLogout:self];
     }
     
 }];
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
