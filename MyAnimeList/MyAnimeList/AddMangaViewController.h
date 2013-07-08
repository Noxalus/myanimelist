//
//  AddMangaViewController.h
//  MyAnimeList
//
//  Created by Utilisateur invité on 7/8/13.
//  Copyright (c) 2013 collin_t. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddMangaViewControllerDelegate;

@interface AddMangaViewController : UIViewController

@property (weak, nonatomic) id <AddMangaViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
@end

@protocol AddMangaViewControllerDelegate <NSObject>

-(void)addMangaViewControllerDidCancel:(AddMangaViewController *)controller;

-(void)addMangaViewControllerDidFinish:(AddMangaViewController *)controller;

@end