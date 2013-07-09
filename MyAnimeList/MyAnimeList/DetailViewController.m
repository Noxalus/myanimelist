//
//  DetailViewController.m
//  MyAnimeList
//
//  Created by Utilisateur invité on 7/8/13.
//  Copyright (c) 2013 collin_t. All rights reserved.
//

#import "DetailViewController.h"
#import "Manga.h"

@interface DetailViewController ()
-(void)configureView;
@end

@implementation DetailViewController

-(void)setManga:(Manga *) newManga
{
    if (_manga != newManga) {
        _manga = newManga;
        [self configureView];
    }
}

-(void) configureView
{
    
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
