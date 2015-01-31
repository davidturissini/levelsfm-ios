//
//  PlayerViewController.h
//  Levels
//
//  Created by David Turissini on 1/25/15.
//  Copyright (c) 2015 David Turissini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Track.h"
#import "Player.h"
#import <AVFoundation/AVFoundation.h>

@interface PlayerViewController : UIViewController <PlayerDelegate>
    @property (strong, nonatomic) IBOutlet UILabel *artistNameLabel;
    @property (strong, nonatomic) IBOutlet UILabel *trackNameLabel;
    @property (strong, nonatomic) IBOutlet UIImageView *artistImage;
    @property (strong, nonatomic) IBOutlet UISlider *seekbar;
    @property (strong, nonatomic) IBOutlet UILabel *timeElapsed;
    @property (strong, nonatomic) IBOutlet UILabel *timeRemaining;
    @property (strong, nonatomic) Track *track;
    @property (strong, nonatomic) Player *player;
@end
