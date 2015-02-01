//
//  UIPlayerView.m
//  Levels
//
//  Created by David Turissini on 1/26/15.
//  Copyright (c) 2015 David Turissini. All rights reserved.
//

#import "UIPlayerView.h"

@implementation UIPlayerView



-(id)initWithFrameAndPlayer:(CGRect)frame player:(Player *)player {

    self = [super initWithFrame:frame];
    

    if (self) {
        [self setPlayer:player];
        [self layoutControls];
    }
    
    return self;
}

- (void)layoutControls {
    
    CGRect frame = self.frame;
    
    
    int labelWidth = 45;
    int labelPadding = 20;
    int labelTotalWidth = labelWidth + (labelPadding * 2);
    
   
     _timeElapsed = [[UITimeLabel alloc] initWithFrame:CGRectMake(labelPadding, 0, labelWidth, 50)];
    
    
    _timeRemaining = [[UITimeLabel alloc] initWithFrame:CGRectMake(frame.size.width - labelWidth - labelPadding, 0, labelWidth, 50)];

    
    CGRect seekbarRect = CGRectMake(labelTotalWidth, 0, frame.size.width - (labelTotalWidth * 2), 50);
    _seekbarView = [[UIPlayerSeekbarView alloc] initWithFrameAndPlayer:seekbarRect player:_player];
    
    [self addSubview:_timeElapsed];
    [self addSubview:_timeRemaining];
    [self addSubview:_seekbarView];
}

- (void)setPlayer:(Player *)player {
    if (_player != nil) {
        [self removePlayerNotifications];
    }
    
    _player = player;
    
    [self attachPlayerNotifications];
}

-(void) removePlayerNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"timeupdate" object:_player];
}

- (void) attachPlayerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPlayerTimeupdate:) name:@"timeupdate" object:_player];
    
}

- (void)onPlayerTimeupdate:(NSNotificationCenter *)notificationCenter {
    [_timeElapsed printFormattedSeconds:_player.currentTime];
    [_timeRemaining printFormattedSeconds:_player.duration - _player.currentTime];

}

- (void) dealloc {
    [self removePlayerNotifications];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
