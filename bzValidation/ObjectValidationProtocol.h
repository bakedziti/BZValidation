//
//  ControlValidationProtocol.h
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/19/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#ifndef __CONTROLVALIDATION_PROTOCOL
#define __CONTROLVALIDATION_PROTOCOL

#import <Foundation/Foundation.h>
#import "ValidationRule.h"

@protocol ObjectValidationDelegate <NSObject>

@optional

- (void)objectWillValidate:(NSObject*)targetObject;
- (BOOL)object:(NSObject*)targetObject didValidateWithResult:(BOOL)valid andMessages:(NSArray*)messages;

@end

@protocol ObjectValidationProtocol <NSObject>

@optional
@property (nonatomic, retain) NSObject *value;

@required
@property (nonatomic, readonly) NSArray* rules;
- (void) addRule:(id<ValidationRuleProtocol>)rule;
- (void) removeRule:(id<ValidationRuleProtocol>)rule;
- (BOOL) validate;


@end

#endif
