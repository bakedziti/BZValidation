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
- (id) getObjectValueToValidate;

@property (nonatomic, retain) id validationControl;


@end

@interface ValidationRule : NSObject <ValidationRuleProtocol> {
    
}



@end

