//
//  UserStationsViewController.h
//  Levels
//
//  Created by David Turissini on 9/12/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LevelsFM.h"

@interface UserStationsViewController : UIViewController <LevelsFMDelegate, UITableViewDataSource, UITableViewDelegate>
    @property (strong, nonatomic) IBOutlet UITableView *tableView;
    @property (strong, nonatomic) NSString *userId;
    @property (strong, nonatomic) NSMutableArray *stationsArray;
@end
