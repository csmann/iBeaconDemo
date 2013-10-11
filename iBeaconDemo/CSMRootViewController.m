//
//  CSMRootViewController.m
//  iBeacons_Demo
//
//  Created by Christopher Mann on 9/5/13.
//  Copyright (c) 2013 Christopher Mann. All rights reserved.
//

#import "CSMRootViewController.h"
#import "CSMHomeViewController.h"

@interface CSMRootViewController ()

@property (nonatomic, strong) CSMHomeViewController  *homeController;
@property (nonatomic, strong) UINavigationController *navController;

@end

@implementation CSMRootViewController

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // add home controller
    self.homeController = [[CSMHomeViewController alloc] init];
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.homeController];
    
    [self addChildViewController:self.navController];
    self.navController.view.frame = self.view.frame;
    [self.view addSubview:self.navController.view];
    [self.navController didMoveToParentViewController:self];
}

@end
