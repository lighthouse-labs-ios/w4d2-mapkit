//
//  ViewController.m
//  W4D2-MapKit
//
//  Created by Kareem Sabri on 2017-05-23.
//  Copyright © 2017 Kareem Sabri. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic) MKMapView *           mapView;
@property (nonatomic) CLLocationManager *   locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Set up location manager
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 5;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.mapView.showsUserLocation = YES;
    self.mapView.showsBuildings = YES;
    self.mapView.showsTraffic = YES;
    self.mapView.showsPointsOfInterest = YES;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    MKPointAnnotation *myPoint = [[MKPointAnnotation alloc]init];
    myPoint.title = @"Lighthouse Labs";
    myPoint.subtitle = @"Toronto, ON";
    myPoint.coordinate = CLLocationCoordinate2DMake(43.644645, -79.394999);
    [self.mapView addAnnotation:myPoint];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *lastLocation = [locations lastObject];
    [self.mapView setRegion:MKCoordinateRegionMake(lastLocation.coordinate, MKCoordinateSpanMake(0.01, 0.01)) animated:YES];
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
    } else {
        pin.annotation = annotation;
    }
    [pin setCanShowCallout:YES];
    
    return pin;
}

@end
