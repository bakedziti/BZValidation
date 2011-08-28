//
//  ObjectValidationDelegate.h
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/28/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ObjectValidationDelegate <NSObject>

@optional

- (void)objectWillValidate:(NSObject*)targetObject;
- (BOOL)object:(NSObject*)targetObject didValidateWithResult:(BOOL)valid andMessages:(NSArray*)messages;


@end
