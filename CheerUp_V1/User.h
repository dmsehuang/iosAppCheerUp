//
//  User.h
//  CheerUp_V1
//
//  Created by huang huijing on 6/13/14.
//  Copyright (c) 2014 huang huijing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSSet *publish;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addPublishObject:(NSManagedObject *)value;
- (void)removePublishObject:(NSManagedObject *)value;
- (void)addPublish:(NSSet *)values;
- (void)removePublish:(NSSet *)values;

@end
