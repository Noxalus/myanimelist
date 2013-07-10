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
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"Manga" inManagedObjectContext:_managedObjectContext]];
        
        NSError *error = nil;
        NSArray *results = [_managedObjectContext executeFetchRequest:request error:&error];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", newManga.name];
        [request setPredicate:predicate];
        
        _manga = [results objectAtIndex:0];
        [self configureView];
    }
}

-(void) configureView
{
    Manga *theManga = self.manga;
    if (theManga)
    {
        self.navigationItem.title = theManga.name;
        self.mangaNameLabel.text =  theManga.name;
        self.mangaSynopsis.text = theManga.synopsis;
        NSURL * imageURL = [NSURL URLWithString:theManga.imageUrl];
        NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage * image = [UIImage imageWithData:imageData];
        self.mangaImage.image = image;
        self.mangaNoteSlider.minimumValue = 0;
        self.mangaNoteSlider.maximumValue = 10;
        self.mangaNoteSlider.value = [theManga.grade floatValue];
        
        NSNumberFormatter *doubleValueWithMaxTwoDecimalPlaces = [[NSNumberFormatter alloc] init];
        [doubleValueWithMaxTwoDecimalPlaces setMaximumFractionDigits:1];
        
        self.mangaNoteNumber.text = [NSString stringWithFormat: @"%.01f/10", self.mangaNoteSlider.value];
    }
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

- (IBAction)sliderValueChanged:(UISlider *)sender
{
    self.mangaNoteNumber.text = [NSString stringWithFormat: @"%.01f/10", sender.value];
    _manga.grade = [NSNumber numberWithFloat:sender.value];
    NSError *error;
    [self.managedObjectContext save:&error];
}
@end
