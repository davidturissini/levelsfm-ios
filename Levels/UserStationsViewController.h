//
//  UserStationsViewController.h
//  Levels
//
//  Created by David Turissini on 9/12/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LevelsFM.h"
#import <CoreLocation/CoreLocation.h>
#import "User.h"

@interface UserStationsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
    @property (strong) IBOutlet UITableView *tableView;
    @property (strong) IBOutlet UIActivityIndicatorView *loadingView;
    @property (strong) NSString *userId;
    @property (strong) NSMutableArray *stationsArray;
    @property (weak) User *user;
@end
