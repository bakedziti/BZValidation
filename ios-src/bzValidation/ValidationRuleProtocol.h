//
//  ValidationRuleProtocol.h
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/28/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ValidationIncludes.h"

@protocol ValidationRuleProtocol <NSObject>

@property (nonatomic, assign) NSObject *targetObject;
- (BOOL) validateWithMessages:(NSArray**)errorMessages;

@end
