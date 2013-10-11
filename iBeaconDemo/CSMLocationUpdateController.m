//
//  CSMLocationUpdateController.m
//  iBeacons_Demo
//
//  Created by Christopher Mann on 10/7/13.
//  Copyright (c) 2013 Christopher Mann. All rights reserved.
//

#import "CSMLocationUpdateController.h"
#import "CSMLocationManager.h"
#import "CSMBeaconRegion.h"
#import <QuartzCore/QuartzCore.h>

#define kDefaultPadding 25
#define kVerticalPadding 15

#define kLocationUpdateNotification @"updateNotification"

#define kLabelText [CSMAppDelegate appDelegate].applicationMode == CSMApplicationModePeripheral ? @"iBeacon Status:" : @"Region Monitoring Status:";

@interface CSMLocationUpdateController ()

@property (nonatomic, strong) UILabel    *titleLabel;
@property (nonatomic, strong) UITextView *statusView;

@end

@implementation CSMLocationUpdateController

- (id)initWithLocationMode:(CSMApplicationMode)appMode {
    
    self = [super init];
    if (self) {
        [CSMAppDelegate appDelegate].applicationMode = appMode;
        
        self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                                  style:UIBarButtonSystemItemCancel
                                                                                 target:self
                                                                                 action:@selector(cancelTapped:)];
    }
    return self;
}


#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.preferredMaxLayoutWidth = self.view.bounds.size.width - 2*kDefaultPadding;
    self.titleLabel.text = kLabelText;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.titleLabel];
    
    self.statusView = [UITextView new];
    self.statusView.textAlignment = NSTextAlignmentCenter;
    self.statusView.font = [UIFont systemFontOfSize:14.0];
    self.statusView.textColor = [UIColor darkGrayColor];
    self.statusView.userInteractionEnabled = NO;
    [self.statusView setTextContainerInset:UIEdgeInsetsMake(30, kDefaultPadding, kDefaultPadding, kDefaultPadding)];
    self.statusView.layer.borderColor = kAppTintColor.CGColor;
    self.statusView.layer.borderWidth = 1;
    self.statusView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.statusView];
    
    // define auto layout constraints
    NSDictionary *constraintMetrics = @{@"horizontalPadding" : @kDefaultPadding,
                                        @"topPadding" : @(2*kDefaultPadding),
                                        @"verticalPadding" : @kVerticalPadding};
    NSDictionary *constraintViews = @{@"label" : self.titleLabel,
                                      @"status" : self.statusView,
                                      @"topGuide" : self.topLayoutGuide};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-horizontalPadding-[label]-horizontalPadding-|"
                                                                      options:0
                                                                      metrics:constraintMetrics
                                                                        views:constraintViews]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-horizontalPadding-[status(>=200)]-horizontalPadding-|"
                                                                      options:0
                                                                      metrics:constraintMetrics
                                                                        views:constraintViews]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topGuide]-topPadding-[label]-verticalPadding-[status]-(<=180)-|"
                                                                      options:0
                                                                      metrics:constraintMetrics
                                                                        views:constraintViews]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // add observer for location notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleStatusUpdate:)
                                                 name:kLocationUpdateNotification
                                               object:nil];
    
    if ([CSMAppDelegate appDelegate].applicationMode == CSMApplicationModePeripheral) {
        
        // initiate peripheral (iBeacon) broadcasting mode
        [self enablePeripheralMode];
        
    } else {
        
        // initate region monitoring monitoring mode
        [self enableRegionMonitoringMode];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if ([CSMAppDelegate appDelegate].applicationMode == CSMApplicationModePeripheral) {
        
        // stop advertising Beacon
        [[CSMLocationManager sharedManager] stopAdvertisingBeacon];
        
    } else {
        
        // stop region monitoring
        [[CSMLocationManager sharedManager] stopMonitoringForRegion:[CSMBeaconRegion targetRegion]];
    }
    
    // remove notifications observer
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLocationUpdateNotification object:nil];
}


#pragma mark - Helpers

- (void)enableRegionMonitoringMode {
    
    [[CSMLocationManager sharedManager] initializeRegionMonitoring];
    
    self.title = @"Monitoring iBeacons";
}

- (void)enablePeripheralMode {
    
    [[CSMLocationManager sharedManager] initializePeripheralManager];
    
    self.title = @"Broadcasting iBeacon";
}


#pragma mark - UIResponse

- (void)cancelTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - Notifications

- (void)handleStatusUpdate:(NSNotification*)notification {
    
    // update status message displayed
    self.statusView.text = notification.userInfo[@"status"];
    
    // log message for debugging
    NSLog(@"%@", notification.userInfo[@"status"]);
}

@end
