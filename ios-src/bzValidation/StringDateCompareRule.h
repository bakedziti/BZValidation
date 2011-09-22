//
//  StringDateCompareRule.h
//  bzValidation
//
//  Created by Joseph DeCarlo on 9/2/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ValidationIncludes.h"


@interface StringDateCompareRule : NSObject <ValidationRuleProtocol>{
    
}

- (id) initWithStartDate:(NSDate*) startDate;
- (id) initWithEndDate:(NSDate*) endDate;
- (id) initWithStartDate:(NSDate*) startDate andEndDate:(NSDate*) endDate;

@end
