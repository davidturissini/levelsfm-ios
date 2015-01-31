//
//  Track.m
//  Levels
//
//  Created by David Turissini on 9/18/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import "Track.h"


@implementation Track

-(void)fetchSCData:(SCTrackFetchHandler)trackFetchHandler {
    NSString *trackURLString = [[NSString alloc] initWithFormat:@"https://api.soundcloud.com/tracks/%@.json?client_id=99308a0184193d62e064cb770f4c1eae", [self get:@"id"]];
    
    
    NSURL *trackUrl = [NSURL URLWithString:trackURLString];
    

   [SCRequest performMethod:SCRequestMethodGET
                 onResource:trackUrl
            usingParameters:nil
                withAccount:nil
     sendingProgressHandler:nil
            responseHandler:^(NSURLResponse *response, NSData *responseData, NSError *error) {
                NSDictionary *json = [NSJSONSerialization
                                      JSONObjectWithData:responseData
                                      options:NSJSONReadingMutableLeaves
                                      error:&error];
                trackFetchHandler(json);
            }];
}

@end
