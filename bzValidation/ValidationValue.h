//
//  ValidationValue.h
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/28/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ValidationValue : NSObject {
    
}

@property (nonatomic, retain) NSString* fieldName;
@property (nonatomic, retain) id fieldValue;

+ (ValidationValue*) validationValue:(id)value andFieldName:(NSString*)name;

@end
