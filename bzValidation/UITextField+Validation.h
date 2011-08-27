//
//  UITextField+Validation.h
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/19/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ObjectValidationProtocol.h"


@interface UITextField (Validation) <ObjectValidationProtocol>

@property (nonatomic, assign) id<ObjectValidationDelegate> validationDelegate;

@end

//@interface UITextFieldValidationCompanion : NSObject <UITextFieldDelegate> {
//    
//}
//
//@property (nonatomic, assign) id<UITextFieldDelegate> trueDelegate;
//
//@end


