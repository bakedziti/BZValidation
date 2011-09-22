//
//  StringDateCompareRule.m
//  bzValidation
//
//  Created by Joseph DeCarlo on 9/2/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import "StringDateCompareRule.h"

@interface StringDateCompareRule()

@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSDate *endDate;

@end

@implementation StringDateCompareRule

@synthesize targetObject;
@synthesize startDate = _startDate;
@synthesize endDate = _endDate;

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Initialization and Deallocation

- (id) initWithStartDate:(NSDate*) startDate {
    
    return [self initWithStartDate:startDate andEndDate:nil];
}

- (id) initWithEndDate:(NSDate*) endDate {

    return [self initWithStartDate:nil andEndDate:endDate];
}

- (id) initWithStartDate:(NSDate*) startDate andEndDate:(NSDate*) endDate {

    id weakSelf = [self init];
    
    if (weakSelf) {
    
        self.startDate = startDate;
        self.endDate = endDate;
        
    }
    
    return weakSelf;
    
}

- (id)init {
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    
    self.startDate = nil;
    self.endDate = nil;
    self.targetObject = nil;
    
    [super dealloc];
}


//--------------------------------------------------------------------------------------------------------------
#pragma mark - ValidationRuleProtocol


- (BOOL) validateWithMessages:(NSArray **)errorMessages {
    
    return NO;
}

@end
