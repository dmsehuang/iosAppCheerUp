//
//  AddArticleViewController.h
//  CheerUp_V1
//
//  Created by huang huijing on 6/13/14.
//  Copyright (c) 2014 huang huijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface AddArticleViewController : UIViewController <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextField *titleField;

- (IBAction)addImage:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
