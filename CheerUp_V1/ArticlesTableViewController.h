//
//  ArticlesTableViewController.h
//  CheerUp_V1
//
//  Created by huang huijing on 6/13/14.
//  Copyright (c) 2014 huang huijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"
#import "AddArticleViewController.h"
#import "ArticleDetailViewController.h"

@interface ArticlesTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext; // refer to the moc in the app delegate
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultController; // fetch result controller to hold the data

@end
