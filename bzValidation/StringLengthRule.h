//
//  StringLengthRule.h
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/19/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ValidationRule.h"


@interface StringLengthRule : ValidationRule {
    
}

@property (nonatomic, retain) NSNumber *minLength;
@property (nonatomic, retain) NSNumber *maxLength;

@end
