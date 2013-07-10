//
//  MasterViewController.m
//  MyAnimeList
//
//  Created by Utilisateur invité on 7/8/13.
//  Copyright (c) 2013 collin_t. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AddMangaViewController.h"
#import "Manga.h"
#import "MyManga.h"

@interface MasterViewController () <AddMangaViewControllerDelegate>
@end



@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Manga" inManagedObjectContext:_managedObjectContext];
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[_managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        // Handle the error.
    }
    
    [self setMyMangasArray:mutableFetchResults];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_myMangasArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Manga *manga= (Manga *)[_myMangasArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = manga.name;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        DetailViewController *details = [segue destinationViewController];
        NSIndexPath *index = [self.tableView indexPathForSelectedRow];
        details.managedObjectContext = _managedObjectContext;
        details.manga = (Manga *)[_myMangasArray objectAtIndex:index.row];
    }
    else if ([[segue identifier] isEqualToString:@"ShowAddMangaView"]) {
        AddMangaViewController *addController = (AddMangaViewController *)[[[segue destinationViewController] viewControllers] objectAtIndex:0];
        addController.delegate = self;
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    return nil;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */


-(void)addMangaViewControllerDidCancel:(AddMangaViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)addMangaViewControllerDidFinish:(AddMangaViewController *)controller manga:(MyManga *) manga {
    Manga *newManga = [NSEntityDescription insertNewObjectForEntityForName:@"Manga" inManagedObjectContext:_managedObjectContext];
    
    newManga.name = manga.name;
    newManga.synopsis = manga.synopsis;
    newManga.imageUrl = manga.image_url;
    newManga.grade = manga.members_score;
    
    NSError *error = nil;
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    else {
        NSComparator comparator = ^(id obj1, id obj2)
        {
            return [((Manga *) obj1).name caseInsensitiveCompare: ((Manga *) obj2).name];
        };
        
        NSUInteger index = [_myMangasArray indexOfObject:newManga
                                           inSortedRange:(NSRange) {0, [_myMangasArray count]}
                                           options:NSBinarySearchingInsertionIndex
                                           usingComparator:comparator];
        
        
        [_myMangasArray insertObject:newManga atIndex:index];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
