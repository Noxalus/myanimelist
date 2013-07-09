//
//  DetailViewController.h
//  MyAnimeList
//
//  Created by Utilisateur invité on 7/8/13.
//  Copyright (c) 2013 collin_t. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Manga;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Manga *manga;

@end
