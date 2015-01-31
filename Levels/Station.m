//
//  Station.m
//  Levels
//
//  Created by David Turissini on 9/18/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import "Station.h"
#import "Track.h"

@implementation Station
@synthesize delegate;

NSString *const URLPATH_NEXT_TRACK = @"/tracks/next";

- (id) init {
    self = [super init];
    
    return self;
    
}

- (void)getNextTrack {
    
    NSString *stationPath = [[NSString alloc] initWithFormat:@"/stations/%@/tracks/next", [self get:@"_id"]];
    
    
    [LevelsFM get:stationPath
           params:nil
completionHandler:^(NSDictionary* data, NSURLResponse* response, NSError* error) {
        Track *track = [[Track alloc] initWithAttributes:data];
    
    if ([self.delegate respondsToSelector:@selector(stationNextTrackDidLoad:)])
        [self.delegate stationNextTrackDidLoad:track];
    }];
    
}

@end
