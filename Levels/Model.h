//
//  Model.h
//  Levels
//
//  Created by David Turissini on 9/18/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
    @property (strong, nonatomic) NSDictionary *attributes;
    @property (nonatomic) long id;
    - (id)initWithAttributes:(NSDictionary *)attributes;
    - (id)get:(NSString *)prop;
@end
