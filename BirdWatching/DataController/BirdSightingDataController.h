//
//  BirdSightingDataController.h
//  BirdWatching
//
//  Created by Céline Cheung on 28/05/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class BirdSighting;

@interface BirdSightingDataController : NSObject

@property (nonatomic, strong) NSMutableArray *eventsArray;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UIBarButtonItem *addButton;

@property (nonatomic, copy) NSMutableArray *masterBirdSightingList;

- (id) initContext:(NSManagedObjectContext *) manageObj;

- (NSUInteger)countOfList;

- (BirdSighting *)objectInListAtIndex:(NSUInteger)theIndex;

- (void)addBirdSightingWithName:(NSString *)inputBirdName
                       location:(NSString *)inputLocation;

@end
