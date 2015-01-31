//
//  Queue.m
//  Levels
//
//  Created by David Turissini on 1/18/15.
//  Copyright (c) 2015 David Turissini. All rights reserved.
//

#import "Queue.h"

@implementation Queue

- (id) init {
    self = [super init];
    
    _array = [[NSMutableArray alloc] init];
    
    return self;
}

- (NSUInteger) count {
    return [_array count];
}

- (id) dequeue {
    if ([_array count] == 0) {
        return nil; // to avoid raising exception (Quinn)
    }
    
    id headObject = [_array objectAtIndex:0];
    if (headObject != nil) {
        [_array removeObjectAtIndex:0];
    }
    return headObject;
}

- (void) enqueue:(id) obj {
    [_array addObject:obj];
}


@end
