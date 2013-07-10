//
//  AddMangaViewController.m
//  MyAnimeList
//
//  Created by Utilisateur invité on 7/8/13.
//  Copyright (c) 2013 collin_t. All rights reserved.
//

#import "AddMangaViewController.h"
#import "Manga.h"
#import "MyManga.h"

@interface AddMangaViewController ()
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation AddMangaViewController

@synthesize responseData = _responseData;

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
    
    _items = [[NSMutableArray alloc] init];
    _isSearching = NO;
    _filteredList = [[NSMutableArray alloc] init];
    
    // HTTP Request
    NSLog(@"viewDidLoad");
    self.responseData = [NSMutableData data];
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

- (void)callWS:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];

    
    [_filteredList removeAllObjects]; //clears the array from all the string objects it might contain from the previous searches
    for (NSDictionary *manga in res) {
        MyManga *myManga = [[MyManga alloc] init];
        myManga.name = [manga objectForKey:@"title"];
        myManga.synopsis = [manga objectForKey:@"synopsis"];
        myManga.image_url = [manga objectForKey:@"image_url"];
        
        //NSLog(@"%@", myManga.name);
        [_filteredList addObject:myManga];
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

- (void)filterListForSearchText:(NSString *)searchText
{
    if ([searchText length] > 0){
        
        NSString *urlParameter = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)searchText, NULL, CFSTR("!*'\";$,#[] "), kCFStringEncodingUTF8));
        
        NSLog([@"http://mal-api.com/manga/search?q=" stringByAppendingString:urlParameter]);
        
        NSURLRequest *request2 = [NSURLRequest requestWithURL:
                              [NSURL URLWithString:[@"http://mal-api.com/manga/search?q=" stringByAppendingString:urlParameter]]];
    
        [self callWS:[[NSURLConnection alloc] initWithRequest:request2 delegate:self]];
    }
    
    
    /*
    for (NSString *title in _items) {
        NSRange nameRange = [title rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (nameRange.location != NSNotFound) {
            [_filteredList addObject:title];
        }
    }
    */
}

#pragma mark - UISearchDisplayControllerDelegate

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    //When the user taps the search bar, this means that the controller will begin searching.
    _isSearching = YES;
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    //When the user taps the Cancel Button, or anywhere aside from the view.
    _isSearching = NO;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterListForSearchText:searchString]; // The method we made in step 7
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterListForSearchText:[self.searchDisplayController.searchBar text]]; // The method we made in step 7
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (_isSearching) {
        //If the user is searching, use the list in our filteredList array.
        return [_filteredList count];
    } else {
        return [_items count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    MyManga *manga;
    if (_isSearching && [_filteredList count]) {
        //If the user is searching, use the list in our filteredList array.
        manga = [_filteredList objectAtIndex:indexPath.row];
    } else {
        manga = [_items objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = manga.name;
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    // If you want to push another view upon tapping one of the cells on your table.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    [self done:indexPath.row];
}


- (IBAction)cancel:(id)sender
{
    [[self delegate] addMangaViewControllerDidCancel:self];
}

- (IBAction)done:(NSInteger)sender
{
    NSLog(@"Add selected manga into CoreData database.");
    
    Manga *selectedManga = [_filteredList objectAtIndex:sender];

    NSLog(@"Titre: %@", selectedManga.name);
}

@end
