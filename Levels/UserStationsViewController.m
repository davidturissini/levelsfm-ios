//
//  UserStationsViewController.m
//  Levels
//
//  Created by David Turissini on 9/12/14.
//  Copyright (c) 2014 David Turissini. All rights reserved.
//

#import "UserStationsViewController.h"
#import "StationViewController.h"
#import "LevelsFM.h"
#import "User.h"


@interface UserStationsViewController ()

@end

@implementation UserStationsViewController

@synthesize stationsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        stationsArray = [[NSMutableArray alloc] init];
        [_loadingView startAnimating];
        
        _user = [User shared];
        [_user fetchStations:^(NSDictionary * stationsArrayJSON, NSURLResponse * response, NSError * error) {
            [self jsonDidFinishLoading:stationsArrayJSON];
        }];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < stationsArray.count - 1) {
    Station *station = [stationsArray objectAtIndex:indexPath.row];
    
    
    NSLog(@"Selected %@", [station get:@"title"]);
    
    StationViewController *stationView = [[StationViewController alloc] initWithNibName:@"StationViewController" bundle:nil];
    
    stationView.station = station;
    
    [self.navigationController pushViewController:stationView animated:YES];
    } else {
        [_user logout];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return stationsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"Item";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:
              UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row < stationsArray.count - 1) {
    
        Station *station = [stationsArray objectAtIndex:indexPath.row];
    
        cell.detailTextLabel.text = [station get:@"title"];
        
    } else {
        cell.detailTextLabel.text = @"Logout";
    }
    
    cell.imageView.frame = CGRectMake(0, 0, 80, 70);
    
    return cell;
}

- (void) jsonDidFinishLoading:(id)data {
    int i;
    
    for (i = 0; i < [data count]; i++) {
        NSDictionary *attributes = [data objectAtIndex:i];
        Station *station = [[Station alloc] initWithAttributes:attributes];
        [stationsArray addObject:station];
    }
    
    [stationsArray addObject:@"Logout"];
    
    
    [self.tableView reloadData];
    _tableView.hidden = NO;
    _loadingView.hidden = YES;
    [_loadingView stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
