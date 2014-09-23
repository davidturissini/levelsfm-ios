//
//  LoginViewController.h
//  Levels
//
//  Created by David Turissini on 8/19/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"


@interface LoginViewController : UIViewController <NSURLConnectionDelegate>
    @property (weak, nonatomic) IBOutlet UITextField *userNameField;
    @property (weak, nonatomic) IBOutlet UITextField *passwordField;
    @property (weak, nonatomic) IBOutlet UITextView *debug;
    @property (strong, nonatomic) NSMutableData *responseData;
    @property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end
