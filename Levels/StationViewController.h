//
//  StationViewController.h
//  Levels
//
//  Created by David Turissini on 9/18/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Station.h"
#import "LevelsFM.h"
#import "UIPlayerView.h"
#import "Player.h"
#import "Queue.h"

@interface StationViewController : UIViewController <StationDelegate>
    @property (weak, nonatomic) IBOutlet UILabel *artistName;
    @property (weak, nonatomic) IBOutlet UILabel *trackName;
    @property (weak, nonatomic) IBOutlet UIActivityIndicatorView *trackLoading;
    @property (weak, nonatomic) IBOutlet UIImageView *artistImageView;
    @property (strong, nonatomic) IBOutlet UIPlayerView *playerView;
    @property (weak, nonatomic) Station *station;
    @property (weak, nonatomic) Player *player;
    @property (strong, nonatomic) Queue *playlist;
    @property (strong, nonatomic, readonly) Track *currentTrack;
@end
