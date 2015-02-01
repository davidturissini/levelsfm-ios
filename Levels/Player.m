//
//  Player.m
//  Levels
//
//  Created by David Turissini on 1/25/15.
//  Copyright (c) 2015 David Turissini. All rights reserved.
//

#import "Player.h"

@implementation Player
@synthesize src, currentTime, duration;

NSString *const EVENT_CANPLAY = @"canplay";
NSString *const EVENT_PLAY = @"play";
NSString *const EVENT_PAUSE = @"pause";
NSString *const EVENT_TIMEUPDATE = @"timeupdate";
NSString *const EVENT_ENDED = @"ended";

-(id) init {
    self = [super init];
    
    
    return self;
}


-(void) _createTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(_updateTrackProgress:) userInfo:nil repeats:YES];
}

- (void) _destroyTimer {
    [_timer invalidate];
    _timer = nil;
}

-(void) load {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:src];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *error;
        
        _avPlayer = [[AVAudioPlayer alloc] initWithData:data error:&error];
        _avPlayer.delegate = self;
        [_avPlayer prepareToPlay];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_CANPLAY object:self];
        
    }];
}

- (void) setSrc:(NSURL *)url {
    src = url;
    [self load];
}

- (double)duration {
    return _avPlayer.duration;
}

- (double)currentTime {
    return _avPlayer.currentTime;
}

- (void)setCurrentTime:(double)_currentTime {
    _avPlayer.currentTime = _currentTime;
}

-(void)_updateTrackProgress:(NSTimer *)timer {
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_TIMEUPDATE object:self];
}

-(void) pause {
    [_avPlayer pause];
    [self _destroyTimer];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_PAUSE object:self];
}

-(void) play {
    [_avPlayer play];
    [self _createTimer];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_PLAY object:self];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
                       successfully:(BOOL)flag {
    if (flag == YES) {
        [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_ENDED object:self];
    }
}

+ (Player *)shared {
    static Player __strong *appPlayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appPlayer = [[self alloc] init];
    });
    return appPlayer;
    
}

@end
