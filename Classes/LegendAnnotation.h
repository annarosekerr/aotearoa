//
//  LegendAnnotation.h
//  MockUp
//
//  Created by Rowan Walker on 27/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LegendAnnotation : NSObject <MKAnnotation> {

	NSString *place;
    NSString *legendName;
    NSNumber *latitude;
    NSNumber *longitude;
    CLLocationCoordinate2D coordinate;
	
}

@property (nonatomic, retain) NSString *place;
@property (nonatomic, retain) NSString *legendName;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;



@end
