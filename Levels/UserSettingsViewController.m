//
//  UserSettingsViewController.m
//  Levels
//
//  Created by David Turissini on 1/25/15.
//  Copyright (c) 2015 David Turissini. All rights reserved.
//

#import "UserSettingsViewController.h"

@interface UserSettingsViewController ()

@end

@implementation UserSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.logoutButton addTarget:self
                         action:@selector(logout:)
               forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logout:(id) sender {
    User *user = [User shared];
    [user logout];
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
