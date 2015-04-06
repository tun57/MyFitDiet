//
//  AddFoodToDiaryViewController.h
//  My Fit Diet
//
//  Created by Stephen Sowole on 04/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodObject.h"
#import "DiaryObject.h"

@interface AddFoodToDiaryViewController : FXFormViewController

@property (strong, nonatomic) PFObject *foodPFObject;
@property (strong, nonatomic) NSString *diaryDate;

@end