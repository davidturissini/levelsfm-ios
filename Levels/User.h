//
//  User.h
//  Levels
//
//  Created by David Turissini on 9/18/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import "Model.h"

@interface User : Model
- (NSURLConnection *)login:(NSString *)username password:(NSString *)password requestDelegate:delegateOrNil;
+ (id)shared;
@end
