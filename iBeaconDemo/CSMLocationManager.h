//
//  CSMLocationManager.h
//  iBeacons_Demo
//
//  Created by Christopher Mann on 9/5/13.
//  Copyright (c) 2013 Christopher Mann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface CSMLocationManager : NSObject<CLLocationManagerDelegate>

+ (instancetype)sharedManager;

- (void)initializePeripheralManager;

- (void)initializeRegionMonitoring;

- (void)stopMonitoringForRegion:(CLBeaconRegion*)region;

- (void)stopAdvertisingBeacon;

@end
