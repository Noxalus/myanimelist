//
//  BirdsMasterViewController.m
//  BirdWatching
//
//  Created by Céline Cheung on 28/05/13.
//
//

#import "BirdsMasterViewController.h"
#import "BirdsDetailViewController.h"
#import "AddSightingViewController.h"
#import "BirdSightingDataController.h"
#import "BirdWatchingEntity.h"

@interface BirdsMasterViewController ()<AddSightingViewControllerDelegate>

@end

@implementation BirdsMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataController countOfList];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BirdSightingCell";
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    BirdWatchingEntity *sightingAtIndex = [self.dataController objectInListAtIndex:indexPath.row];
    [[cell textLabel] setText:sightingAtIndex.name];
    [[cell detailTextLabel] setText:[formatter stringFromDate: (NSDate *)sightingAtIndex.date]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowSightingDetails"]) {
        BirdsDetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.sighting = [self.dataController objectInListAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
    else if ([[segue identifier] isEqualToString:@"ShowAddSightingView"]) {
        AddSightingViewController *addController =
        (AddSightingViewController *)[[[segue destinationViewController] viewControllers] objectAtIndex:0];
        addController.delegate = self;
    }
}

- (void)addSightingViewControllerDidCancel:(AddSightingViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)addSightingViewControllerDidFinish: (AddSightingViewController *)controller name:(NSString *)name location:(NSString *)location {
    if ([name length] || [location length]) {
        [self.dataController addBirdSightingWithName:name location:location];
        [[self tableView] reloadData];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
