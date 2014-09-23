//
//  LevelsFM.h
//  Levels
//
//  Created by David Turissini on 9/18/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LevelsFM;

@protocol LevelsFMDelegate <NSObject>
- (void) jsonDidFinishLoading:(LevelsFM *) sender json:(id)data;
//- (void) jsonDidFailWithError:(LevelsFM *) sender error:(NSError *)error;
@end

@interface LevelsFM : NSObject
@property (strong, nonatomic) NSString *domain;
@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) id <LevelsFMDelegate> delegate;
- (NSURLConnection *) request:(NSString *)path params:(NSDictionary *)params method:(NSString *)method;
- (NSURLConnection *)request:(NSString *)path params:(NSDictionary *)params;
@end
