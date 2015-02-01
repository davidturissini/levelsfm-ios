//
//  UIPlayerSeekbarView.m
//  Levels
//
//  Created by David Turissini on 1/31/15.
//  Copyright (c) 2015 David Turissini. All rights reserved.
//

#import "UIPlayerSeekbarView.h"

@implementation UIPlayerSeekbarView

-(id)initWithFrameAndPlayer:(CGRect)frame player:(Player *)player {
    self = [super initWithFrame:frame];
    
    if (self) {
        _player = player;
    
        [self addTarget:self action:@selector(onSeekbarTouchDown:) forControlEvents:UIControlEventTouchDown];
    
        [self addTarget:self action:@selector(onSeekbarTouchUp:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(onSeekbarTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
        
        [self _attachPlayerNotifications];
    }
    
    return self;
}

-(void) _attachPlayerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPlayerCanPlay:) name:@"canplay" object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPlayerTimeupdate:) name:@"timeupdate" object:_player];
}

- (void)removePlayerNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"canplay" object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"timeupdate" object:_player];
}

- (void) dealloc {
    [self removePlayerNotifications];
    
}

-(void) onPlayerCanPlay:(NSNotificationCenter *)notificationCenter {
    [self setMaximumValue:_player.duration];
}

-(void) onPlayerTimeupdate:(Player *)player {
    if (_isTouchDownOnSeekbar == NO) {
        [self setValue:_player.currentTime];
    }
}

- (void) onSeekbarTouchDown:(id)sender {
    _isTouchDownOnSeekbar = YES;
}

- (void) onSeekbarTouchUp:(id)sender {
    _player.currentTime = self.value;
    _isTouchDownOnSeekbar = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
