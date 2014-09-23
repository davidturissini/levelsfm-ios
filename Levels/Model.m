//
//  Model.m
//  Levels
//
//  Created by David Turissini on 9/18/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import "Model.h"

@implementation Model

@synthesize id;

- (id)initWithAttributes:(NSDictionary *)attributes {
    
    self = [super init];
    
    if(self) {
        _attributes = attributes;
    }
    
    return self;
}

- (id)get:(NSString *)prop {
    return [_attributes objectForKeyedSubscript:prop];
}

- (long) getId {
    return [_attributes objectForKeyedSubscript:@"id"];
}

@end
