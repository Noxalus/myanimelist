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
@property (weak, nonatomic) IBOutlet UILabel *mangaNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mangaImage;
@property (weak, nonatomic) IBOutlet UITextView *mangaSynopsis;
@property (weak, nonatomic) IBOutlet UISlider *mangaNoteSlider;
@property (weak, nonatomic) IBOutlet UILabel *mangaNoteNumber;
- (IBAction)sliderValueChanged:(UISlider *)sender;

@end
