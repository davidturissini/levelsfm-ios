//
//  Player.h
//  Levels
//
//  Created by David Turissini on 1/25/15.
//  Copyright (c) 2015 David Turissini. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "Track.h"

@interface Player : NSObject
    @property (strong) AVAudioPlayer *avPlayer;
    @property (nonatomic, strong) NSURL *src;
    @property double currentTime;
    @property (readonly) double duration;
    @property (strong) NSTimer *timer;
    @property (strong) Track *track;

    - (void) load;
    - (void) play;
    - (void) pause;
@end
