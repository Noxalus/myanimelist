//
//  AddSightingViewController.h
//  BirdWatching
//
//  Created by Céline Cheung on 28/05/13.
//
//

#import <UIKit/UIKit.h>

@protocol AddSightingViewControllerDelegate;

@interface AddSightingViewController : UITableViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *birdNameInput;

@property (weak, nonatomic) IBOutlet UITextField *locationInput;

@property (weak, nonatomic) id <AddSightingViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;

- (IBAction)done:(id)sender;

@end

@protocol AddSightingViewControllerDelegate <NSObject>

- (void) addSightingViewControllerDidCancel: (AddSightingViewController *) controller;

- (void)addSightingViewControllerDidFinish: (AddSightingViewController *) controller name: (NSString*) name location: (NSString *) location;

@end