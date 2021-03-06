//
//  AddToFoodForm.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 04/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "AddToFoodForm.h"

@implementation AddToFoodForm

@synthesize servingSize, foodAlreadyAdded;

- (NSArray *) fields {
    
    if (!foodAlreadyAdded) {
        
        servingSize = 1;
    }
    
    return @[
             // Number Of Servings
             @{FXFormFieldKey: @"servingSize", FXFormFieldTitle: @"Number Of Servings", FXFormFieldType: @"number", FXFormFieldDefaultValue: @"1.0", FXFormFieldHeader: @"NUMBER OF SERVINGS", FXFormFieldAction: @"setNutritionLabels"},
             ];
}

- (NSArray*) extraFields {
    
    if (!foodAlreadyAdded) {
        
        return @[
                 // Select A Meal Occassion
                 @{FXFormFieldAction: @"addToBreakfast", FXFormFieldTitle: @"Add To Breakfast", FXFormFieldHeader: @"SELECT A MEAL OCCASION"},
                 
                 @{FXFormFieldAction: @"addToLunch", FXFormFieldTitle: @"Add To Lunch"},
                 
                 @{FXFormFieldAction: @"addToDinner", FXFormFieldTitle: @"Add To Dinner"},
                 
                 @{FXFormFieldAction: @"addToSnacks", FXFormFieldTitle: @"Add To Snacks"},
                 
                 // Settings
                 @{FXFormFieldAction: @"editFoodObject", FXFormFieldTitle: @"Edit", FXFormFieldHeader: @"FOOD SETTINGS"},
                 
                 @{FXFormFieldAction: @"deleteFoodObject", FXFormFieldTitle: @"Delete"},
                 ];
    }
    
    return nil;
}

@end
