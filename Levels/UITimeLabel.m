//
//  UITimeLabel.m
//  Levels
//
//  Created by David Turissini on 1/31/15.
//  Copyright (c) 2015 David Turissini. All rights reserved.
//

#import "UITimeLabel.h"

@implementation UITimeLabel

- (NSString *) formatWithLeadingZero: (int)value {
    
    NSString *format;
    
    if (value < 10) {
        format = @"0%i";
    } else {
        format = @"%i";
    }
    
    return [[NSString alloc] initWithFormat:format, value];;
}

- (NSString *) formatInterval: (float) seconds {
    int minutes = seconds / 60;
    int secondsRemainder = seconds - (minutes * 60);
    
    NSString *minutesStr = [self formatWithLeadingZero:minutes];
    NSString *secondsStr = [self formatWithLeadingZero:secondsRemainder];
    
    
    return [[NSString alloc] initWithFormat:@"%@:%@", minutesStr, secondsStr];
    
}

- (void) printFormattedSeconds:(float)seconds {
    self.text = [self formatInterval:seconds];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
