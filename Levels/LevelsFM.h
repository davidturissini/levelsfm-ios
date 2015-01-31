//
//  LevelsFM.h
//  Levels
//
//  Created by David Turissini on 9/18/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LevelsFM;

typedef void (^LevelsRequestHandler)(NSDictionary*, NSURLResponse*, NSError*);

@interface LevelsFM : NSObject

+ (void)  request:(NSString *)path
           params:(NSDictionary *)params
completionHandler:(LevelsRequestHandler) levelsRequestHandler;

+ (void)    get:(NSString *)path
          params:(NSDictionary *)params
completionHandler:(LevelsRequestHandler) levelsRequestHandler;

+ (void)    post:(NSString *)path
          params:(NSDictionary *)params
completionHandler:(LevelsRequestHandler) levelsRequestHandler;


@end
