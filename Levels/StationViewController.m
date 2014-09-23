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

@interface StationViewController ()

@end

@implementation StationViewController

@synthesize station;
AVPlayer* player;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *title = [self.station get:@"title"];
    
    NSLog(@"Selected %@", title);
    [self.stationTitle setText:title];
    
    LevelsFM *levels = [[LevelsFM alloc] init];
    levels.delegate = self;
    
    [levels request:@"/stations/534644e1e5b5f80200000007/tracks/next" params:nil];
}

- (void) jsonDidFinishLoading:(LevelsFM *) sender json:(id)data {
    //Track *track = [[Track alloc] initWithAttributes:data];

    NSString *path = @"https://api.soundcloud.com/tracks/135573147/stream?client_id=99308a0184193d62e064cb770f4c1eae";
    
    NSURL *audioURL = [NSURL URLWithString:path];
    NSError *playerError;
    
    player = [[AVPlayer alloc] initWithURL:audioURL];
    
    
    if (playerError)
        
    {
        
        NSLog(@"Error in audioPlayer: %@",
              
              
              [playerError localizedDescription]);
        
    }
    
    
    [player play];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
