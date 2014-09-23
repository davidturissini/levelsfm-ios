//
//  LevelsFM.m
//  Levels
//
//  Created by David Turissini on 9/18/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import "LevelsFM.h"

@implementation LevelsFM

@synthesize domain, delegate;

- (LevelsFM *) init {
    self = [super init];
    
    if (self) {
        self.domain = @"http://levelsfm-backend.herokuapp.com";
    }
    
    return self;
}


- (NSURLConnection *)request:(NSString *)path params:(NSDictionary *)params method:(NSString *)method {
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", domain, path];
    NSURL *url = [[NSURL alloc] initWithString:urlString];

    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:method];
    
    if (params != nil) {
        NSData *requestData = [NSJSONSerialization dataWithJSONObject:params options:0 error:NULL];
        [request setHTTPBody:requestData];
    }
    
    NSURLConnection *loginConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    return loginConnection;
    
}

- (NSURLConnection *)request:(NSString *)path params:(NSDictionary *)params {
    return [self request:path params:params method:@"GET"];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    self.responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [self.responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSString *data = [[NSString alloc] initWithData:self.responseData encoding:NSASCIIStringEncoding];
    
    NSError *error;
    
    
    id object = [NSJSONSerialization
                 JSONObjectWithData:self.responseData
                 options:0
                 error:&error];
    
    
    [delegate jsonDidFinishLoading:self json:object];
   
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    //[delegate jsonDidFailWithError:self error:error];
}

@end
