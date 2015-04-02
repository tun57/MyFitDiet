//
//  CreateFoodViewController.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 01/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "CreateFoodViewController.h"
#import <Parse/Parse.h>
#import "FoodObject.h"

@interface CreateFoodViewController ()

@end

@implementation CreateFoodViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self removeBackButtonText];
    
    self.title = @"CREATE FOOD";
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createFood)];
    
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void) createFood {
    
    FoodObject *foodObject = self.formController.form;
    
    if ([[foodObject.name stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""] || !foodObject.name) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cannot Add Food"
                                                        message:@"Food does not have a name. Please enter a name for your created food"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    } else {
    
    //self.formController.form;
    
    /*@property (nonatomic, copy) NSString *name;
    @property (nonatomic, copy) NSString *foodDescription;
    @property float servingSize;
    
    @property int calories;
    @property int totalFats;
    @property int saturatedFats;
    @property int sodium;
    @property int totalCarbohydrates;
    @property int protein;*/
    
    FoodObject *obj = (FoodObject*) self.formController.form;
    
    NSLog(@"name = %@", obj.name);
    NSLog(@"name = %@", obj.foodDescription);
    NSLog(@"name = %f", obj.servingSize);
    NSLog(@"name = %d", obj.calories);
    NSLog(@"name = %f", obj.totalFats);
    NSLog(@"name = %f", obj.saturatedFats);
    NSLog(@"name = %f", obj.sodium);
    NSLog(@"name = %f", obj.totalCarbohydrates);
    NSLog(@"name = %f\n\n\n", obj.protein);
    
    /*PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];*/
    }
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
