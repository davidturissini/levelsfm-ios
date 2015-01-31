//
//  UIPlayerSeekbarView.h
//  Levels
//
//  Created by David Turissini on 1/31/15.
//  Copyright (c) 2015 David Turissini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface UIPlayerSeekbarView : UISlider
    @property (strong, nonatomic) Player *player;
    @property bool isTouchDownOnSeekbar;

-(id)initWithFrameAndPlayer:(CGRect)frame player:(Player *)player;
@end
