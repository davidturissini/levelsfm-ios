//
//  LevelsFM.m
//  Levels
//
//  Created by David Turissini on 9/18/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import "LevelsFM.h"


@implementation LevelsFM


+ (void) request:(NSString *)path
          params:(NSDictionary *) params
          method:(NSString *)method
completionHandler:(LevelsRequestHandler)levelsRequestHandler {
    
    NSURLComponents *urlComponents = [self _buildURLComponents:path
                                                        params:params];

    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:urlComponents.URL];
    [urlRequest setHTTPMethod:method];
    
    if ([method isEqualToString:@"POST"]) {
        NSString *postBody = [self _convertDictionaryToPostParams:params];
        NSData *requestBodyData = [postBody dataUsingEncoding:NSUTF8StringEncoding];
        [urlRequest setHTTPBody:requestBodyData];
    }
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *connectionError) {
                               
                               if (connectionError) {
                                   NSLog(@"Connection error");
                               }
                               
                               NSDictionary *json = [self _handleJSON:data];
                               levelsRequestHandler(json, response, connectionError);
                           }];
}

+ (void) get:(NSString *) path
      params:(NSDictionary *)params
completionHandler:(LevelsRequestHandler)levelsRequestHandler {
    return [self request:path params:params method:@"GET" completionHandler:levelsRequestHandler];
}

+ (void) post:(NSString *) path
       params:(NSDictionary *)params
completionHandler:(LevelsRequestHandler)levelsRequestHandler {
    return [self request:path params:params method:@"POST" completionHandler:levelsRequestHandler];
}


/** 
 
   @private
 
 */
+ (NSString *) _host {
    return @"levelsfm-backend.herokuapp.com";
}


+ (NSDictionary *) _handleJSON:(NSData *)rawJSONData {
    NSError *error;
    
    NSDictionary *json = [NSJSONSerialization
                JSONObjectWithData:rawJSONData
                options:NSJSONReadingMutableLeaves
                error:&error];
    
    if (error) {
        NSLog(@"Error parsing JSON");
    }
    
    return json;
}


+ (NSURLComponents *)_buildURLComponents:(NSString *)path
                                  params:(NSDictionary *) params {
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] init];
    urlComponents.scheme = @"http";
    urlComponents.host = [self _host];
    urlComponents.path = path;
    urlComponents.queryItems = [self _dictionaryToQueryItems:params];
    
    return urlComponents;
}

+ (NSString *)_convertDictionaryToPostParams:(NSDictionary *)dict {
    NSMutableArray *stringArray = [[NSMutableArray alloc] init];
    for(id key in dict) {
        NSString *str = [[NSString alloc] initWithFormat:@"%@=%@", key, [dict valueForKey:key]];
        [stringArray addObject:str];
    }
    
    return [stringArray componentsJoinedByString:@"&"];
}

+ (NSArray *)_dictionaryToQueryItems:(NSDictionary *)dict {
    NSMutableArray *queryItems = [[NSMutableArray alloc] init];
    
    if (!dict) {
        return queryItems;
    }
    
    for(id key in dict) {
        NSURLQueryItem *item = [[NSURLQueryItem alloc] initWithName:key value:[dict valueForKey:key]];
        
        [queryItems addObject:item];
    }
    
    return queryItems;
    
}

@end
