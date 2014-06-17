//
//  ArticlesTableViewController.m
//  CheerUp_V1
//
//  Created by huang huijing on 6/13/14.
//  Copyright (c) 2014 huang huijing. All rights reserved.
//

#import "ArticlesTableViewController.h"

@interface ArticlesTableViewController ()

@end

@implementation ArticlesTableViewController

@synthesize fetchedResultController = _fetchedResultController; // alloc and init the controller in a correct way

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSError *err = nil;
    if (![self.fetchedResultController performFetch:&err]) {
        NSLog(@"Error! %@", err);
        abort();
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - fetechedResultController
-(NSFetchedResultsController *)fetchedResultController{
    if (_fetchedResultController != nil) {
        return _fetchedResultController;
    }
    // create a fetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"Article" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    // using fetch request to create a fetch result controller
    _fetchedResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedResultController.delegate = self; // delegate itself
    
    return _fetchedResultController;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.fetchedResultController.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.fetchedResultController.sections objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ArticleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Article * article = [self.fetchedResultController objectAtIndexPath:indexPath];
    cell.textLabel.text = article.title;
    cell.detailTextLabel.text = article.tag;
    
    return cell;
}

#pragma mark - core data set up
// lazy instatiation
-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *moc = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        moc = [delegate managedObjectContext];
    }
    return moc;
}

#pragma mark - fetched result controller
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    // insert, delete, move
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Article *article = [self.fetchedResultController objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject:article];
        
        NSError *err = nil;
        if (![self.managedObjectContext save:&err]) {
            NSLog(@"Error! %@", err);
        }
    }
}

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"addArticle"]) {
        AddArticleViewController *addArticleVC = segue.destinationViewController;
        addArticleVC.managedObjectContext = self.managedObjectContext;
    }
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        ArticleDetailViewController *articleDetailVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Article *article = (Article *)[self.fetchedResultController objectAtIndexPath:indexPath];
//        articleDetailVC.currentArticle = article;
        
        articleDetailVC.content = article.content;
        articleDetailVC.tag = article.tag;
        articleDetailVC.title = article.title;
        articleDetailVC.image = [UIImage imageWithData: article.image];
    }
}


@end
