//
//  Article.h
//  CheerUp_V1
//
//  Created by huang huijing on 6/13/14.
//  Copyright (c) 2014 huang huijing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Article : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * tag;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) User *user;

@end
