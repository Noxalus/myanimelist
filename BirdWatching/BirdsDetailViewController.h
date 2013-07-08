//
//  BirdsDetailViewController.h
//  BirdWatching
//
//  Created by Céline Cheung on 28/05/13.
//
//

#import <UIKit/UIKit.h>
#import "BirdWatchingEntity.h"

@class BirdSighting;

@interface BirdsDetailViewController : UITableViewController

@property (strong, nonatomic) BirdWatchingEntity *sighting;

@property (weak, nonatomic) IBOutlet UILabel *birdNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
