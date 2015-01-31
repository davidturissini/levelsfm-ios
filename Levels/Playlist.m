//
//  Playlist.m
//  Levels
//
//  Created by David Turissini on 1/18/15.
//  Copyright (c) 2015 David Turissini. All rights reserved.
//

#import "Playlist.h"

@implementation Playlist

- (void) station:(Station *) station {
    [self removeAllObjects];
    _station = station;
}

@end
