//
//  AddSightingViewController.m
//  BirdWatching
//
//  Created by Céline Cheung on 28/05/13.
//
//

#import "AddSightingViewController.h"

@interface AddSightingViewController ()

@end

@implementation AddSightingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancel:(id)sender {
    [[self delegate] addSightingViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    [[self delegate] addSightingViewControllerDidFinish:self name:self.birdNameInput.text location:self.locationInput.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ((textField == self.birdNameInput) || (textField == self.locationInput)) {
        [textField resignFirstResponder];
    }
    return YES;
}

@end
