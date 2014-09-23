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

@interface StationViewController : UIViewController <LevelsFMDelegate>
    @property (weak, nonatomic) IBOutlet UILabel *stationTitle;
    @property (weak, nonatomic) Station *station;
@end
