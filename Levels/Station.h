//
//  Station.h
//  Levels
//
//  Created by David Turissini on 9/18/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"
#import "LevelsFM.h"
#import "Track.h"

typedef void (^StationNextTrackHandler)(Track*);

@protocol StationDelegate

- (void)stationNextTrackDidLoad:(Track *)track;

@end

@interface Station : Model
    @property (nonatomic, assign) NSObject<StationDelegate> *delegate;
    - (void) getNextTrack;
@end