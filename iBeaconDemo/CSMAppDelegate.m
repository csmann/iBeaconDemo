//
//  CSMAppDelegate.m
//  iBeacons_Demo
//
//  Created by Christopher Mann on 9/5/13.
//  Copyright (c) 2013 Christopher Mann. All rights reserved.
//

#import "CSMAppDelegate.h"

#define kMyStoreNumber 1
#define kWeeklySpecialItemNumber 1


@implementation CSMAppDelegate

+ (CSMAppDelegate*)appDelegate {
    return (CSMAppDelegate*)[UIApplication sharedApplication].delegate;
}

- (NSUUID*)myUUID {
    if (!_myUUID) {
        // generate unique identifier
        _myUUID = [[NSUUID alloc] initWithUUIDString:@"10D39AE7-020E-4467-9CB2-DD36366F899D"];
    }
    return _myUUID;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.rootViewController = [[CSMRootViewController alloc] init];
    
    // define navbar appearance
    [[UINavigationBar appearance] setBarTintColor:kAppTintColor];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    // set status bar style
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.rootViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.tintColor = kAppTintColor;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
