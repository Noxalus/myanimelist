//
//  Manga.h
//  MyAnimeList
//
//  Created by Utilisateur invité on 7/9/13.
//  Copyright (c) 2013 collin_t. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Manga : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * grade;

@end
