//
//  BirdSightingDataController.m
//  BirdWatching
//
//  Created by Céline Cheung on 28/05/13.
//
//

#import "BirdSightingDataController.h"
#import "BirdWatchingEntity.h"

@interface BirdSightingDataController ()

- (void)initializeDefaultDataList;

@end

@implementation BirdSightingDataController

@synthesize eventsArray;
@synthesize managedObjectContext;
@synthesize addButton;
@synthesize locationManager;

- (id) initContext:(NSManagedObjectContext *) manageObj {
    if (self = [super init]) {
        self.managedObjectContext = manageObj;
        [self initializeDefaultDataList];
        return self;
    }
    return nil;
}

- (void) initializeDefaultDataList {
    self.masterBirdSightingList = [[NSMutableArray alloc] init];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"BirdWatchingEntity"
                                   inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"date" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc]
                                initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    self.masterBirdSightingList = [[managedObjectContext
                                            executeFetchRequest:request error:&error] mutableCopy];
    if (self.masterBirdSightingList == nil) {
        // Handle the error.
    }
}

- (void) setMasterBirdSightingList:(NSMutableArray *) newList {
    if (_masterBirdSightingList != newList) {
        _masterBirdSightingList = [newList mutableCopy];
    }
}

- (NSUInteger) countOfList {
    return [self.masterBirdSightingList count];
}

- (BirdSighting *) objectInListAtIndex:(NSUInteger)theIndex {
    return [self.masterBirdSightingList objectAtIndex:theIndex];
}

- (void)addBirdSightingWithName:(NSString *)inputBirdName
                       location:(NSString *)inputLocation {
    NSDate *today = [NSDate date];
    BirdWatchingEntity *sighting = (BirdWatchingEntity *)[NSEntityDescription insertNewObjectForEntityForName:@"BirdWatchingEntity" inManagedObjectContext:managedObjectContext];
    
    [sighting setDate: today];
    [sighting setLocation: inputLocation];
    [sighting setName: inputBirdName];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        // Handle the error.
    }

    
    [self.masterBirdSightingList addObject:sighting];
}

@end
