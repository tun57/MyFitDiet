//
//  FoodObject.h
//  My Fit Diet
//
//  Created by Stephen Sowole on 01/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXForms.h"
#import <Parse/Parse.h>

@interface FoodObject : NSObject <FXForm>

// used for FatSecret API Search
@property NSInteger fatSecretId;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *foodDescription;
@property float servingSize;

@property int calories;
@property float totalFats;
@property float saturatedFats;
@property float sodium;
@property float totalCarbohydrates;
@property float protein;

- (void) createFoodObject;

- (void) convertPFObjectToFoodObject:(PFObject*)foodPFObject;

- (void) updateFoodObject:(PFObject*)foodPFObject;

- (void) deleteFoodObject:(PFObject*)foodPFObject;

@end
