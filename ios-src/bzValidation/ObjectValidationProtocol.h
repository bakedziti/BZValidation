//
//  ControlValidationProtocol.h
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/19/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ValidationIncludes.h"

@protocol ObjectValidationProtocol <NSObject>

@required

@property (nonatomic, readonly) NSArray *rules;
@property (nonatomic, readonly) NSArray *validationValues;
@property (nonatomic, assign) id<ObjectValidationDelegate> validationDelegate;

- (void) addRule:(id<ValidationRuleProtocol>)rule;
- (void) removeRule:(id<ValidationRuleProtocol>)rule;

- (BOOL) validate;


@end

