//
//  CSMAppDelegate.h
//  iBeacons_Demo
//
//  Created by Christopher Mann on 9/5/13.
//  Copyright (c) 2013 Christopher Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSMRootViewController.h"

typedef NS_ENUM(NSUInteger, CSMApplicationMode) {
    CSMApplicationModePeripheral = 0,
    CSMApplicationModeRegionMonitoring
};

#define kUniqueRegionIdentifier @"iBeacon Demo"

#define kAppTintColor [UIColor colorWithRed:0.12 green:0.50 blue:0.15 alpha:1.0]


@interface CSMAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) CSMRootViewController *rootViewController;

@property (nonatomic, strong) NSUUID *myUUID;

@property (nonatomic, assign) CSMApplicationMode applicationMode;

+ (CSMAppDelegate*)appDelegate;

@end
