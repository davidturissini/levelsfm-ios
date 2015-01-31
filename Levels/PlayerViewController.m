//
//  PlayerViewController.m
//  Levels
//
//  Created by David Turissini on 1/25/15.
//  Copyright (c) 2015 David Turissini. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "PlayerViewController.h"
#import "SCUI.h"


@interface PlayerViewController ()

@end


@implementation PlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _player = [[Player alloc] initWithDelegate:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_seekbar addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)canPlay:(id)sender {
    [_player play];
}

- (void)setTrack:(Track *)track {
    _track = track;

    
    NSString *trackId = [NSString stringWithFormat:@"%@", [_track get:@"id"]];
    
    NSString *scTrackPath = [NSString stringWithFormat:@"https://api.soundcloud.com/tracks/%@.json?client_id=99308a0184193d62e064cb770f4c1eae", trackId];
    
    [SCRequest performMethod:SCRequestMethodGET
                  onResource:[NSURL URLWithString:scTrackPath]
             usingParameters:nil
                 withAccount:nil
      sendingProgressHandler:nil
             responseHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                 
                 NSDictionary *trackData = [NSJSONSerialization
                                            JSONObjectWithData:data
                                            options:0
                                            error:&error];
                 
                 NSMutableString *streamUrl = [[NSMutableString alloc] initWithString:[trackData valueForKey:@"stream_url"]];
                 [streamUrl appendString:@"?client_id=99308a0184193d62e064cb770f4c1eae"];
                 NSURL *url = [NSURL URLWithString:streamUrl];
                 _player.src = url;
                 
             }];    
    
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
   // _audioPlayer.currentTime = sender.value;
}

- (void)play {
    NSLog(@"player playing");
}

- (void) _printTrackName:(NSDictionary *)trackData
{
    
    NSString *trackTitle = [trackData valueForKey:@"title"];
    _trackNameLabel.text = trackTitle;
    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
    
    CGSize expectedLabelSize = [trackTitle sizeWithFont:_trackNameLabel.font constrainedToSize:maximumLabelSize lineBreakMode:_trackNameLabel.lineBreakMode];
    
    CGRect newFrame = _trackNameLabel.frame;
    newFrame.size.height = expectedLabelSize.height;
    _trackNameLabel.frame = newFrame;
    
}

- (void) _printArtistName:(NSDictionary *)artistData
{
    NSString *artistName = [artistData valueForKey:@"username"];
    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
    
    CGSize expectedLabelSize = [artistName sizeWithFont:_artistNameLabel.font constrainedToSize:maximumLabelSize lineBreakMode:_artistNameLabel.lineBreakMode];
    
    CGRect newFrame = _artistNameLabel.frame;
    newFrame.size.height = expectedLabelSize.height;
    _artistNameLabel.frame = newFrame;
    
    
    _artistNameLabel.text = artistName;
}

- (void) _showArtistImage:(NSDictionary *)artistData
{
    NSURL *imagePath = [NSURL URLWithString:[artistData valueForKey:@"avatar_url"]];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imagePath];
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    
    _artistImage.image = image;
    _artistImage.contentMode = UIViewContentModeScaleAspectFit;
}

- (void) timeupdate:(Player *)sender
{
    NSLog(@"timeupdate");
    NSString *str = [[NSString alloc] initWithFormat:@"@%", sender.currentTime];
    NSLog(str);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
