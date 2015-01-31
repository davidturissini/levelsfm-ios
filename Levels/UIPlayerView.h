//
//  UIPlayerView.h
//  Levels
//
//  Created by David Turissini on 1/26/15.
//  Copyright (c) 2015 David Turissini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "UIPlayerSeekbarView.h"
#import "UITimeLabel.h"

@interface UIPlayerView : UIView
    @property (strong, nonatomic) UIImageView *artistImage;
    @property (strong, nonatomic) UITimeLabel *timeElapsed;
    @property (strong, nonatomic) UITimeLabel *timeRemaining;
    @property (strong, nonatomic) UIPlayerSeekbarView *seekbarView;
    @property (strong, nonatomic) Player *player;

-(id)initWithFrameAndPlayer:(CGRect)frame player:(Player *)player;
@end
