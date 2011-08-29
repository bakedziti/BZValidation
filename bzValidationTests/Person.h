//
//  Person.h
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/28/11.
//  Copyright (c) 2011 Baked Ziti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * FirstName;
@property (nonatomic, retain) NSString * LastName;
@property (nonatomic, retain) NSString * MiddleName;
@property (nonatomic, retain) NSNumber * Age;
@property (nonatomic, retain) NSDate * BirthDate;

@end
