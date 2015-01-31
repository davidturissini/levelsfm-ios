//
//  Track.h
//  Levels
//
//  Created by David Turissini on 9/18/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import "Model.h"
#import "SCUI.h"

typedef void (^SCTrackFetchHandler)(NSDictionary*);

@interface Track : Model
    @property (strong) NSURL *streamURL;

    -(void)fetchSCData:(SCTrackFetchHandler)trackFetchHandler;
@end
