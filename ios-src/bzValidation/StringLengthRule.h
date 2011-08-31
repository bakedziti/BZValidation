//
//  StringLengthRule.h
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/19/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ValidationIncludes.h"

@interface StringLengthRule : NSObject <ValidationRuleProtocol> {
    
}

@property (nonatomic, retain) NSNumber *minLength;
@property (nonatomic, retain) NSNumber *maxLength;

@end
