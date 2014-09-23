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



@interface UserStationsViewController ()

@end

@implementation UserStationsViewController

@synthesize stationsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        stationsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    LevelsFM *levels = [[LevelsFM alloc] init];
    levels.delegate = self;
    
    [levels request:@"/users/daveturissini/stations" params:nil];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Station *station = [stationsArray objectAtIndex:indexPath.row];
    
    
    NSLog(@"Selected %@", [station get:@"title"]);
    
    StationViewController *stationView = [[StationViewController alloc] initWithNibName:@"StationViewController" bundle:nil];
    
    stationView.station = station;
    
    [self.navigationController pushViewController:stationView animated:YES];
    
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
    
    Station *station = [stationsArray objectAtIndex:indexPath.row];
    
    cell.detailTextLabel.text = [station get:@"title"];
    cell.imageView.frame = CGRectMake(0, 0, 80, 70);
    
    return cell;
}

- (void) jsonDidFinishLoading:(LevelsFM *) sender json:(id)data {
    int i;
    
    for (i = 0; i < [data count]; i++) {
        NSDictionary *attributes = [data objectAtIndex:i];
        Station *station = [[Station alloc] initWithAttributes:attributes];
        [stationsArray addObject:station];
    }
    
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
