//
//  ArticleDetailViewController.h
//  CheerUp_V1
//
//  Created by huang huijing on 6/13/14.
//  Copyright (c) 2014 huang huijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface ArticleDetailViewController : UIViewController

@property (strong, nonatomic) Article *currentArticle; // hold the current object
@property (strong, nonatomic) NSString *tag;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) UIImage *image;

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end
