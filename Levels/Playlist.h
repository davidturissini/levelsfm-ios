//
//  Playlist.h
//  Levels
//
//  Created by David Turissini on 1/18/15.
//  Copyright (c) 2015 David Turissini. All rights reserved.
//

#import "Queue.h"
#import "Station.h"

@interface Playlist : Queue
    @property (nonatomic, retain) Station *station;
@end
