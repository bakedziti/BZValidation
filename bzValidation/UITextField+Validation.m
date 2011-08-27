//
//  UITextField+Validation.m
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/19/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import "UITextField+Validation.h"
#import "ValidationRule.h"
#import <objc/runtime.h>

@interface UITextField()

//@property (nonatomic, retain) UITextFieldValidationCompanion *companion;
//@property (nonatomic, retain) id<UITextFieldDelegate> trueDelegate;
@property (nonatomic, retain) NSMutableArray* writableRules;


@property (nonatomic, retain) UIColor *validTextColor;
- (void) showInvalidState;
- (void) hideInvalidState;

@end

@implementation UITextField (Validation)

//static char companionKey;
//static char trueDelegateKey;
static char validTextColorKey;

static char validationDelegateKey;
static char rulesKey;
static char valueKey;

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Initialization and Deallocation

- (void)dealloc {
    
//    self.companion = nil;
    self.value = nil;
//    self.trueDelegate = nil;
    self.validationDelegate = nil;
    self.validTextColor = nil;
    
    [super dealloc];
}


//--------------------------------------------------------------------------------------------------------------
#pragma mark - Properties

- (void) setValidationDelegate:(id<ObjectValidationDelegate>)validationDelegate {
    
    objc_setAssociatedObject(self, &validationDelegateKey, validationDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<ObjectValidationDelegate>)validationDelegate {
    
    return objc_getAssociatedObject(self, &validationDelegateKey);
}

- (void) setValidTextColor:(UIColor *)validTextColor {
    
    objc_setAssociatedObject(self, &validTextColorKey, validTextColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor*) validTextColor {
    
    return objc_getAssociatedObject(self, &validTextColorKey);
}

//- (void) setCompanion:(UITextFieldValidationCompanion *)companion {
//    
//    objc_setAssociatedObject(self, &companionKey, companion, OBJC_ASSOCIATION_RETAIN);
//}
//
//- (UITextFieldValidationCompanion*) companion {
//    
//    UITextFieldValidationCompanion *localCompanion = objc_getAssociatedObject(self, &companionKey);
//    
//    if (!localCompanion) {
//        
//        localCompanion = [[UITextFieldValidationCompanion alloc]init];
//        
//        [self setCompanion:localCompanion];
//    }
//    
//    return localCompanion;
//}
//
//- (void) setTrueDelegate:(id<UITextFieldDelegate>)trueDelegate {
//    
//    objc_setAssociatedObject(self, &trueDelegateKey, trueDelegate, OBJC_ASSOCIATION_RETAIN);
//}
//
//- (id<UITextFieldDelegate>) trueDelegate {
//    
//    return objc_getAssociatedObject(self, &trueDelegateKey);
//}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Overrides

//- (void) setDelegate:(id<UITextFieldDelegate>)aDelegate {
//    
//    //Set the companion as the delegate and store
//    //the actual delegate instance so calls can be forwarded
//    self.trueDelegate = aDelegate;
//    self.companion.trueDelegate = aDelegate;
//    
//    [self setValue:self.companion forKey:@"_delegate"];
//}
//
//- (id<UITextFieldDelegate>)delegate {
//    
//    return self.companion;
//}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - ControlValidationProtocol

- (BOOL) validate {
    
    if ([self.validationDelegate respondsToSelector:@selector(objectWillValidate:)]) {
        
        [self.validationDelegate objectWillValidate:self];
    }
    
    NSMutableArray *validationErrors = [[NSMutableArray alloc]init];
    
    BOOL valid = YES;
    
    for (id<ValidationRuleProtocol> rule in self.rules) {
        
        NSArray *ruleErrors = nil;
        
        if (![rule validateWithMessages:&ruleErrors]) {
            
            valid = NO;
            
            if (ruleErrors) {

                [validationErrors addObjectsFromArray:ruleErrors];
            }
        }
    }
    
    BOOL override = NO;
    
    if ([self.validationDelegate respondsToSelector:@selector(object:didValidateWithResult:andMessages:)]) {
        
        override = [self.validationDelegate object:self didValidateWithResult:valid andMessages:validationErrors];
    } 
    
    if (!override) {
        
        if (valid) {
            
            [self hideInvalidState];
        } else {
            
            [self showInvalidState];
        }
    }
    
    [validationErrors release];
    
    return valid;
}

- (NSMutableArray*) writableRules {
    
    NSMutableArray *rulesArray = (NSMutableArray*)objc_getAssociatedObject(self, &rulesKey);
    
    if (!rulesArray) {
        
        rulesArray = [NSMutableArray array];
        
        [self setWritableRules:rulesArray];
    }
    
    return rulesArray;
}

- (void) setWritableRules:(NSMutableArray *)writableRules {
    
    objc_setAssociatedObject (self, &rulesKey, writableRules, OBJC_ASSOCIATION_RETAIN);
}

- (NSArray*) rules {
    
    return self.writableRules;
}

- (NSObject*) value {

    NSObject *v = (NSObject*)objc_getAssociatedObject(self, &valueKey);

    return v;
}

- (void) setValue:(NSObject *)value {
    
    objc_setAssociatedObject(self, &valueKey, value, OBJC_ASSOCIATION_RETAIN);
}

- (void) addRule:(id<ValidationRuleProtocol>)rule {
    
    [rule setValidationControl:self];
    [self.writableRules addObject:rule];
}

- (void) removeRule:(id<ValidationRuleProtocol>)rule {
    
    if ([self.writableRules containsObject:rule]) {
        
        [self.writableRules removeObject:rule];
    }
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Utility Methods

- (void) showInvalidState {
    
    if (!self.validTextColor) {

        self.validTextColor = self.textColor;
    }

    self.textColor = [UIColor redColor];
}

- (void) hideInvalidState {
    
    self.textColor = self.validTextColor;
}


@end


/************** UITextFieldValidationCompanion **************/

//@interface UITextFieldValidationCompanion()
//
//
//
//@end
//
//@implementation UITextFieldValidationCompanion
//@synthesize trueDelegate;
//
////--------------------------------------------------------------------------------------------------------------
//#pragma mark - Initialization and Deallocation
//
//- (void)dealloc {
//    
//    self.trueDelegate = nil;
//    
//    [super dealloc];
//}
//
////--------------------------------------------------------------------------------------------------------------
//#pragma mark - UITextFieldDelegate
//
//
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    
//    BOOL result = YES;
//    
//    if ([self.trueDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
//        
//        result = [self.trueDelegate textFieldShouldBeginEditing:textField];
//    }
//    
//    return result;
//}
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    
//    if ([self.trueDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
//        
//        [self.trueDelegate textFieldDidEndEditing:textField];
//    }
//}
//
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//    
//    BOOL result = YES;
//    
//    if ([self.trueDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
//        
//        [self.trueDelegate textFieldShouldEndEditing:textField];
//    }
//    
//    return result;
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    
//    if ([self.trueDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
//        
//        [self.trueDelegate textFieldDidEndEditing:textField];
//    }
//}
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//
//    BOOL result = YES;
//    
////    if ([textField validate]) {
////        
////        NSLog(@"Autovalidate: Valid");
////    } else {
////        
////        NSLog(@"Autovalidate: Not Valid");
////    }
////    
//    if ([self.trueDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
//        
//        [self.trueDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
//    }
//    
//    return result;
//}
//
//- (BOOL)textFieldShouldClear:(UITextField *)textField {
//    
//    BOOL result = YES;
//    
//    if ([self.trueDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
//        
//        [self.trueDelegate textFieldShouldClear:textField];
//    }
//    
//    return result;
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    
//    BOOL result = YES;
//    
//    if ([self.trueDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
//        
//        [self.trueDelegate textFieldShouldReturn:textField];
//    }
//    
//    return result;
//}
//
//@end

