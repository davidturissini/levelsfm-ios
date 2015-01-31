//
//  Queue.h
//  Levels
//
//  Created by David Turissini on 1/18/15.
//  Copyright (c) 2015 David Turissini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject
    @property (nonatomic, retain) NSMutableArray *array;
    - (id) dequeue;
    - (NSUInteger) count;
    - (void) enqueue:(id)obj;
@end
