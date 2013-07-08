//
//  BirdWatchingEntity.h
//  BirdWatching
//
//  Created by Utilisateur invité on 6/14/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BirdWatchingEntity : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSDate * date;

@end
