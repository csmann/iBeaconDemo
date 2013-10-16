iBeaconDemo
===========

This app provides a basic demo of the new iBeacons API available on iOS 7 and accompanies the blog post <a href="http://www.captechconsulting.com/blog/christopher-mann/ios-7-tutorial-series-core-location-beacons">iOS Tutorial Series: Core Location Beacons</a>.  To run the application requires two iOS 7 devices supporting Bluetooth 4.0.  One instance uses CBPeripheralManager to advertise an instance of CLBeaconRegion using the device's Bluetooth LE signal.  The other instance monitors for the same defined CLBeaconRegion and displays updates regarding the region state and the user's proximity to the advertised beacon.
