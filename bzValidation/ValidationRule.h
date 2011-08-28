//
//  ValidationRule.h
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/19/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ValidationRuleProtocol <NSObject>

- (BOOL) validateWithMessages:(NSArray**)errorMessages;

- (NSArray*) valuesForValidation;
//- (NSArray*) getValuesToValidate
//- (id) getObjectValueToValidate; //Should change to (NSArray*)getValuesToValidate

@property (nonatomic, retain) id validationControl;


@end

@interface ValidationRule : NSObject <ValidationRuleProtocol> {
    
}



@end

