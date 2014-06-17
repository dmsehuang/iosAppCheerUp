//
//  RecentArticleTableViewController.m
//  CheerUp_V1
//
//  Created by huang huijing on 6/15/14.
//  Copyright (c) 2014 huang huijing. All rights reserved.
//

#import "RecentArticleTableViewController.h"

@interface RecentArticleTableViewController ()

@end

@implementation RecentArticleTableViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PFQuerytable view controller
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.parseClassName = @"Article";
        self.textKey = @"title";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 5;
    }
    return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    static NSString * cellIdentifier = @"recentArticleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:cellIdentifier];
    }
    // confiture the cell
    cell.textLabel.text = [object objectForKey:@"title"];
    cell.detailTextLabel.text = [object objectForKey:@"tag"];
    
    return cell;
}

-(PFQuery *)queryForTable{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    return query;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"recentShowDetail"]) {
        // get the pfobject
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        ArticleDetailViewController *articleDetailVC = segue.destinationViewController;
        
        // assign value to the destination controller
        articleDetailVC.title =[object objectForKey:@"title"];
        
        PFFile *theImage = object[@"image"];
        articleDetailVC.image = [UIImage imageWithData:[theImage getData]];

        articleDetailVC.tag = [object objectForKey:@"tag"];
        articleDetailVC.content = [object objectForKey:@"content"];
    }
}


@end
