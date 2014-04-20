//
//  LegendAnnotation.m
//  MockUp
//
//  Created by Rowan Walker on 27/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LegendAnnotation.h"

@implementation LegendAnnotation

@synthesize place, legendName, longitude, latitude, coordinate;

- (CLLocationCoordinate2D)coordinate;
{
    //CLLocationCoordinate2D theCoordinate;
    coordinate.latitude = [latitude doubleValue];
    coordinate.longitude = [longitude doubleValue];
    return coordinate; 
}

// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
- (NSString *)title
{

    return place;
}

/*
// optional
- (NSString *)subtitle
{
    return place;
}*/

- (void)dealloc
{
    [super dealloc];
}

@end
