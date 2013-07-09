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

@interface MasterViewController () <AddMangaViewControllerDelegate>

@property (nonatomic, strong) NSMutableData *responseData;

@end



@implementation MasterViewController

@synthesize responseData = _responseData;

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

    
    
    // HTTP Request
    NSLog(@"viewDidLoad");
    self.responseData = [NSMutableData data];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"http://mal-api.com/manga/search?q=berserk"]];
    
    [[NSURLConnection alloc] initWithRequest:request2 delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    NSMutableArray *titles = [NSMutableArray array];
    for (NSDictionary *manga in res) {
        [titles addObject:[manga objectForKey:@"title"]];
    }
    
    // Display manga titles
    for (NSString *title in titles) {
        NSLog(@"%@", title);
    }
    
    /*
    // show all values
    for(id key in res) {
        id value = [res objectForKey:key];
        
        NSString *keyAsString = (NSString *)key;
        NSString *valueAsString = (NSString *)value;
        
        if ([keyAsString isEqualToString:@"synopsis"] || [keyAsString isEqualToString:@"title"]){
            NSLog(@"%@", keyAsString);
            NSLog(@"%@", valueAsString);
        }
    }
    
    // extract specific value...
    NSArray *results = [res objectForKey:@"results"];
    
    for (NSDictionary *result in results) {
        NSString *icon = [result objectForKey:@"icon"];
        NSLog(@"icon: %@", icon);
    }
    */
}

- (void)viewDidUnload {
    [super viewDidUnload];
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
    cell.textLabel.text = @"Manga";
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

-(void)addMangaViewControllerDidFinish:(AddMangaViewController *)controller {
    
}

@end
