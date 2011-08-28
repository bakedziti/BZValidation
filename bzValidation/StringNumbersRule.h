//
//  OnlyNumbersInStringRule.h
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/21/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ValidationIncludes.h"

typedef enum {
    
    kInteger = 0,
    kFloat = 1 << 0,
    kWithinRange = 2 << 1,
    kPositive = 3 << 2,
    kNegative = 4 << 3
    
} numbersRules;

@interface StringNumbersRule : NSObject <ValidationRuleProtocol> {
    
}

- (id)initWithNumbersRule:(numbersRules)rule; //Defaults to kInteger

- (void) setIntegerRangeMinimum:(NSInteger)min andMaximum:(NSInteger)max;
- (void) setFloatRangeMinimum:(float)min andMaximum:(float)max;

@end
