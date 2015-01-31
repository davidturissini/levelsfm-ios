//
//  StationViewController.m
//  Levels
//
//  Created by David Turissini on 9/18/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import "StationViewController.h"
#import "LevelsFM.h"
#import "Track.h"
#import <AVFoundation/AVFoundation.h>
#import "SCUI.h"


@interface StationViewController ()

@end

@implementation StationViewController

@synthesize station, currentTrack;

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_trackLoading startAnimating];
    
    [self _initPlayer];
    [self _initPlaylist];

}

- (void)setStation:(Station *)incomingStation {
    station = incomingStation;
    station.delegate = self;
    [station getNextTrack];
    [self setTitle:[station get:@"title"]];
}

- (void)stationNextTrackDidLoad:(Track *)track {
    [_playlist enqueue:track];
    
    if (currentTrack == nil) {
        [self _playNext];
    }
}

- (void)_playNext {
    currentTrack = [_playlist dequeue];
    [currentTrack fetchSCData:^(NSDictionary* scTrackData){
        [self.trackLoading removeFromSuperview];
        NSMutableString *streamURL = [[NSMutableString alloc] initWithString:[scTrackData valueForKey:@"stream_url"]];
        
        NSDictionary *artistData = [scTrackData valueForKey:@"user"];
        
        NSData *artistImageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[artistData valueForKey:@"avatar_url"]]];
        UIImage *image = [[UIImage alloc] initWithData:artistImageData];
        [_artistImageView setImage:image];
        _artistName.text = [artistData valueForKey:@"username"];
        _trackName.text = [scTrackData valueForKey:@"title"];
        
        [streamURL appendString:@"?client_id=99308a0184193d62e064cb770f4c1eae"];
        
        _player.src = [NSURL URLWithString:streamURL];
        
    }];
}

- (void) _initPlaylist {
    _playlist = [[Queue alloc] init];
}

- (void)_initPlayer {
    _player = [[Player alloc] init];
    
    CGRect playerViewRect = CGRectMake(0, self.view.frame.size.height - 70, self.view.frame.size.width, 50);
    
    _playerView = [[UIPlayerView alloc] initWithFrameAndPlayer:playerViewRect player:_player];
    [_playerView setPlayer:_player];
    [self.view addSubview:_playerView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPlayerCanPlay:) name:@"canplay" object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPlayerPlay:) name:@"play" object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPlayerEnded:) name:@"ended" object:_player];
}

- (void)onPlayerEnded:(NSNotificationCenter *)notificationCenter {
    NSLog(@"player ended");
    [self _playNext];
}

-(void)onPlayerPlay:(NSNotificationCenter *)notificationCenter {
    [station getNextTrack];
}

-(void)onPlayerCanPlay:(NSNotificationCenter *)notificationCenter {
    [_player play];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //End recieving events
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

- (BOOL) canBecomeFirstResponder {
    return YES;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    //Once the view has loaded then we can register to begin recieving controls and we can become the first responder
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}


- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
