//
//  MasterViewController.h
//  MyAnimeList
//
//  Created by Utilisateur invi0té on 7/8/13.
//  Copyright (c) 2013 collin_t. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *myMangasArray;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
