//
//  BirdsDetailViewController.m
//  BirdWatching
//
//  Created by Céline Cheung on 28/05/13.
//
//

#import "BirdsDetailViewController.h"
#import "BirdWatchingEntity.h"

@interface BirdsDetailViewController ()
- (void)configureView;
@end

@implementation BirdsDetailViewController

#pragma mark - Managing the detail item

- (void)setSighting:(BirdWatchingEntity *) newSighting
{
    if (_sighting != newSighting) {
        _sighting = newSighting;
        [self configureView];
    }
}

- (void)configureView
{
    BirdWatchingEntity *theSighting = self.sighting;
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
    }
    if (theSighting) {
        self.birdNameLabel.text = theSighting.name;
        self.locationLabel.text = theSighting.location;
        self.dateLabel.text = [formatter stringFromDate:(NSDate*) theSighting.date];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
