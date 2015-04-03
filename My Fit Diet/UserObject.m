//
//  UserObject.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 02/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "UserObject.h"
#import "Constants.h"
#import <Parse/Parse.h>

typedef NS_ENUM(BOOL, weightGoal) {
    
    gainWeight = true,
    loseWeight = false,
};

@implementation UserObject

@synthesize _id, email, gender, name, currentWeight, goalWeight, dateOfBirth, height, userSetGainWeight, weeklyGoalRate;

- (id) init {
    
    self = [super init];
    
    if (self) {
        
        UserObject *userObject = [self loadCustomObjectWithKey:USER_OBJECT];
        
        if (userObject) {
            
            _id = userObject._id;
            email = userObject.email;
            name = userObject.name;
            gender = userObject.gender;
            
            currentWeight = userObject.currentWeight;
            goalWeight = userObject.goalWeight;
            dateOfBirth = userObject.dateOfBirth;
            height = userObject.height;
            
            userSetGainWeight = userObject.userSetGainWeight;
            weeklyGoalRate = userObject.weeklyGoalRate;
        }
    }
    
    return self;
}

- (void) removeUserObject {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_OBJECT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) syncUserObject {
    
    [self updateObject];
    
    PFUser *user = [PFUser currentUser];
    
    if (user) {
        
        user.username = _id;
        user.password = _id;
        user.email = email;
        
        user[@"DateOfBirth"] = dateOfBirth;
        user[@"Height"] = [NSNumber numberWithFloat:height];
        user[@"CurrentWeight"] = [NSNumber numberWithFloat:currentWeight];
        user[@"GoalWeight"] = [NSNumber numberWithFloat:goalWeight];
        user[@"isUserLosingWeight"] = [NSNumber numberWithBool:!userSetGainWeight];
        user[@"WeeklyGoalRate"] = [NSNumber numberWithFloat:weeklyGoalRate];
        
        [user saveEventually];
    }
}

- (void) encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:_id forKey:@"_id"];
    [encoder encodeObject:email forKey:@"email"];
    [encoder encodeObject:name forKey:@"first_name"];
    [encoder encodeObject:gender forKey:@"gender"];
    
    [encoder encodeFloat:currentWeight forKey:@"currentWeight"];
    [encoder encodeFloat:goalWeight forKey:@"goalWeight"];
    [encoder encodeObject:dateOfBirth forKey:@"dateOfBirth"];
    [encoder encodeFloat:height forKey:@"height"];
    
    [encoder encodeBool:userSetGainWeight forKey:@"userSetGainWeight"];
    [encoder encodeFloat:weeklyGoalRate forKey:@"weeklyGoalRate"];
}

- (id) initWithCoder:(NSCoder *)decoder {
    
    self = [super init];
    
    if (self) {
        
        _id = [decoder decodeObjectForKey:@"_id"];
        email = [decoder decodeObjectForKey:@"email"];
        name = [decoder decodeObjectForKey:@"first_name"];
        gender = [decoder decodeObjectForKey:@"gender"];
        
        currentWeight = [decoder decodeFloatForKey:@"currentWeight"];
        goalWeight = [decoder decodeFloatForKey:@"goalWeight"];
        dateOfBirth = [decoder decodeObjectForKey:@"dateOfBirth"];
        height = [decoder decodeFloatForKey:@"height"];
        
        userSetGainWeight = [decoder decodeBoolForKey:@"userSetGainWeight"];
        weeklyGoalRate = [decoder decodeFloatForKey:@"weeklyGoalRate"];
    }
    
    return self;
}

- (NSArray *) fields {
    
    NSMutableArray *heightArray = [[NSMutableArray alloc] init];
    
    for (int i = 60; i <= 250; i++)
        [heightArray addObject:[NSNumber numberWithInt:i]];
    
    NSMutableArray *weightArray = [[NSMutableArray alloc] init];
    
    for (int i = 30; i <= 1000; i++)
        [weightArray addObject:[NSNumber numberWithInt:i]];
    
    return @[
             // User Details
             @{FXFormFieldKey: @"name", FXFormFieldTitle: @"Name", FXFormFieldType: @"text", FXFormFieldDefaultValue: @"User", FXFormFieldHeader: @"USER DETAILS"},
             
             @{FXFormFieldKey: @"gender", FXFormFieldType: @"text", FXFormFieldTitle: @"Gender", FXFormFieldOptions: @[@"Male", @"Female"]},
             
             @{FXFormFieldKey: @"email", FXFormFieldTitle: @"Email", FXFormFieldType: @"text"},
             
             @{FXFormFieldKey: @"dateOfBirth", FXFormFieldDefaultValue: [NSDate date],FXFormFieldTitle: @"Date Of Birth", FXFormFieldType: @"date"},
             
             
             // Weight Details
             
             @{FXFormFieldKey: @"height", FXFormFieldTitle: @"Height (cm)", FXFormFieldOptions: heightArray,
               FXFormFieldHeader: @"WEIGHT DETAILS", FXFormFieldType: @"float"},
             
             @{FXFormFieldKey: @"currentWeight", FXFormFieldTitle: @"Current Weight (lbs)", FXFormFieldOptions: weightArray, FXFormFieldType: @"float"},
             
             @{FXFormFieldKey: @"goalWeight", FXFormFieldTitle: @"Goal Weight (lbs)", FXFormFieldOptions: weightArray, FXFormFieldType: @"float"},
             
             @{FXFormFieldKey: @"userSetGainWeight", FXFormFieldTitle: @"Weight Goal", FXFormFieldType: @"boolean", FXFormFieldOptions: @[@(loseWeight), @(gainWeight)],
               
               FXFormFieldValueTransformer: ^(id input) {
                   
                   return @{@(loseWeight): @"Lose Weight",
                            @(gainWeight): @"Gain Weight"}[input];}},
             
             @{FXFormFieldKey: @"weeklyGoalRate", FXFormFieldTitle: @"Weekly Goal Rate (lbs)", FXFormFieldOptions: @[@0.5, @1.0, @1.5, @2.0], FXFormFieldType: @"float"},
             ];
}

- (NSArray *) extraFields {
    
    PFUser *user = [PFUser currentUser];
    
    if (user) {
    
    // Account Details
    
    return @[
             @{FXFormFieldTitle: @"Log Out", FXFormFieldHeader: @"ACCOUNT DETAILS", FXFormFieldAction: @"logUserOut"},
             ];
    }
    
    return nil;
}

- (void) updateObject {
    
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:USER_OBJECT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (UserObject*) loadCustomObjectWithKey:(NSString *)key {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    UserObject *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    
    return object;
}

@end
