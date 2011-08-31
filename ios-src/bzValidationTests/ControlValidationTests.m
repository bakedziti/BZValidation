//
//  ControlValidationTests.m
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/30/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import "ControlValidationTests.h"
#import "UITextField+Validation.h"
#import "StringLengthRule.h"

@implementation ControlValidationTests

#if USE_APPLICATION_UNIT_TEST

- (void) testTextFieldStringLength {
    
    UITextField *textField = [[UITextField alloc]init];
    
    StringLengthRule *rule = [[StringLengthRule alloc]init];
    
    rule.maxLength = [NSNumber numberWithInt:5];
    
    [textField addRule:rule];
    
    textField.text = @"123456";
    
    BOOL result = [textField validate];
    
    STAssertFalseNoThrow(result, @"UITextField validate should have returned false due to the string length rule");
}

#endif

@end
