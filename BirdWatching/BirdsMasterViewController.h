//
//  BirdsMasterViewController.h
//  BirdWatching
//
//  Created by Céline Cheung on 28/05/13.
//
//

#import <UIKit/UIKit.h>

@class BirdSightingDataController;

@interface BirdsMasterViewController : UITableViewController

@property (strong, nonatomic) BirdSightingDataController *dataController;

@end
