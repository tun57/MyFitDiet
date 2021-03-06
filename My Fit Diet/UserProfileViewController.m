//
//  UserProfileViewController.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 03/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserObject.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Parse/Parse.h>
#import "LoginViewController.h"
#import "Constants.h"
#import "NutritionGoalsViewController.h"
#import "NutritionObject.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"USER PROFILE";
    
    [self removeBackButtonText];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(createProfile)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    self.navigationItem.hidesBackButton = YES;
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) createProfile {
    
    if ([self validateFields]) {
        
        UserObject *userObject = self.formController.form;
        
        [userObject syncUserObject];
        
        if (userObject.userCalories) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            
            [self calculateNutritionGoals];
        }
    }
}

- (void) editNutritionGoals {
    
    UserObject *userObject = self.formController.form;
    
    [userObject syncUserObject];
    
    [self calculateNutritionGoals];
}

- (void) calculateNutritionGoals {
    
    NutritionGoalsViewController *nutritionGoalsVC = [[NutritionGoalsViewController alloc] init];
    
    nutritionGoalsVC.formController.form = [[NutritionObject alloc] init];
    
    [self.navigationController pushViewController:nutritionGoalsVC animated:YES];
}

- (BOOL) validateFields {
    
    UserObject *userObject = self.formController.form;
    
    NSString *field = @"";
    
    if (!userObject.height) {
        
        field = @"height";
        
    } else if (!userObject.currentWeight) {
        
        field = @"current weight";
        
    } else if (!userObject.goalWeight) {
        
        field = @"goal weight";
        
    } else if (!userObject.weeklyGoalRate) {
        
        field = @"weekly goal rate";
        
    } else if (!userObject.dateOfBirth) {
        
        field = @"date of birth";
    }
    
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:userObject.dateOfBirth
                                       toDate:[NSDate date]
                                       options:0];
    if ([ageComponents year] < 18) {
        
        [self callAlertView:@"Invalid User" :[NSString stringWithFormat:@"\nYou must be at least 18 years old to use this app"]];
        return NO;
    }
    
    if ([field isEqualToString:@""]) {
        
        return YES;
    }
    
    [self callAlertView:@"Incomplete Profile" :[NSString stringWithFormat:@"\nPlease ensure the %@ field is not empty.", field]];
    
    return NO;
}

- (void) callAlertView:(NSString*)title :(NSString*)message {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void) logUserOut {
    
    [[FBSDKLoginManager alloc] logOut];
    
    [PFUser logOut];
    
    [PFObject unpinAllObjectsInBackground];
    
    [[UserObject alloc] removeUserObject];
    
    [self.navigationController removeFromParentViewController];
    
    [self presentViewController:[LoginViewController alloc] animated:NO completion:nil];
}

@end
