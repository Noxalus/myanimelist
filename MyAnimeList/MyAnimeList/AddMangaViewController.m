//
//  AddMangaViewController.m
//  MyAnimeList
//
//  Created by Utilisateur invité on 7/8/13.
//  Copyright (c) 2013 collin_t. All rights reserved.
//

#import "AddMangaViewController.h"
#import "Manga.h"

@interface AddMangaViewController ()

@end

@implementation AddMangaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender
{
    [[self delegate] addMangaViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender
{
    Manga *manga = [[Manga alloc] init];
    manga.name = @"Bokurano";
    [[self delegate] addMangaViewControllerDidFinish:self manga:manga];
}

@end
