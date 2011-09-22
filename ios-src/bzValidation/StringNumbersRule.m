//
//  OnlyNumbersInStringRule.m
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/21/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import "StringNumbersRule.h"

@interface StringNumbersRule()

@property (nonatomic, assign) NSInteger numberRule;
@property (nonatomic, retain) NSNumber *minNumber;
@property (nonatomic, retain) NSNumber *maxNumber;


- (BOOL) validateIntegerInString:(NSString*)string;
- (BOOL) validateFloatInString:(NSString*)string;
- (BOOL) validatePostiveNegative:(NSNumber*)number;
- (BOOL) validateRange:(NSNumber*)number;

@end

@implementation StringNumbersRule

@synthesize targetObject;
@synthesize numberRule;
@synthesize minNumber, maxNumber;

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Initialization and Deallocation

- (id) initWithNumbersRule:(numbersRules)rule {
    
    self = [super init];
    if (self) {
        
        self.numberRule = rule;
    }
    return self;
}

- (id)init {
    
    return [self initWithNumbersRule:kInteger];
}

- (void)dealloc {
    
    self.minNumber = nil;
    self.maxNumber = nil;
    
    [super dealloc];
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Public Methods

- (void) setIntegerRangeMinimum:(NSInteger)min andMaximum:(NSInteger)max {
    
    self.minNumber = [NSNumber numberWithInt:min];
    self.maxNumber = [NSNumber numberWithInt:max];
}

- (void) setFloatRangeMinimum:(float)min andMaximum:(float)max {
    
    self.minNumber = [NSNumber numberWithFloat:min];
    self.maxNumber = [NSNumber numberWithFloat:max];
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - ValidationRule

- (BOOL) validateWithMessages:(NSArray **)errorMessages {

    BOOL valid = YES;
    
    BOOL conformsToProtocol = [self.targetObject conformsToProtocol:@protocol(ObjectValidationProtocol)];
    
    NSAssert(conformsToProtocol, @"Cannot validate for target object because it does not conform to the ObjectValidationProtocol");
    
    if (conformsToProtocol) {
        
        id<ObjectValidationProtocol> ovp = (id<ObjectValidationProtocol>)self.targetObject;
        
        for (ValidationValue *valVaue in [ovp validationValues]) {
            
            NSString *textValue = valVaue.fieldValue;
            
            if ((self.numberRule & kInteger) == kInteger) {
                
                NSLog(@"kInteger");
                
                valid = [self validateIntegerInString:textValue];
                
            } else if ((self.numberRule & kFloat) == kFloat) {
                
                valid = [self validateFloatInString:textValue];
            }            
        }
        
    }
    
    return valid;   
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Utility Methods

- (BOOL) validateIntegerInString:(NSString *)string {
    
    BOOL valid = NO;
    
    NSScanner * scanner = [NSScanner scannerWithString:string];
    NSInteger num;

    if([scanner scanInteger:&num]) {
        
        NSLog(@"Is Integer");
        
        NSNumber *number = [NSNumber numberWithInt:num];
        
        valid = [self validatePostiveNegative:number];
        
        if (valid) {
            
            valid = [self validateRange:number];
        }
    }
    
    return valid;
}

- (BOOL) validateFloatInString:(NSString *)string {
    
    BOOL valid = NO;
    
    NSScanner * scanner = [NSScanner scannerWithString:string];
    float num;
    
    if([scanner scanFloat:&num]) {
        
        NSNumber *number = [NSNumber numberWithFloat:num];
        
        valid = [self validatePostiveNegative:number];
        
        if (valid) {
            
            valid = [self validateRange:number];
        }
    }    
    return valid;
}

- (BOOL) validatePostiveNegative:(NSNumber *)number {
    
    BOOL valid = YES;
    
    if (valid && (self.numberRule & kPositive) == kPositive) {
        
        NSLog(@"kPositive");
        
        NSNumber *zero = [NSNumber numberWithInt:0];
        
        NSLog(@"Comparing number:%@ with %@", number, zero);
        valid = ([number compare:zero] == NSOrderedDescending);
//        valid = (number > [NSNumber numberWithInt:0]);
        
    } else if (valid && (self.numberRule & kNegative) == kNegative) {
        
        valid = (number < [NSNumber numberWithInt:0]);
    }
    
    return valid;
}

- (BOOL) validateRange:(NSNumber *)number {
    
    BOOL valid = YES;
    
    if ((self.numberRule & kWithinRange) == kWithinRange) {
        
        NSComparisonResult result = [number compare:self.minNumber];
        
        valid = ( result == NSOrderedDescending || result == NSOrderedSame);
        
        if (valid) {
        
            result = [number compare:self.maxNumber];
            valid = (result == NSOrderedAscending || result == NSOrderedSame);
        }
    }
    
    return valid;
}



@end
