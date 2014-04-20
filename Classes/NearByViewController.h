//
//  NearByViewController.h
//  MockUp
//
//  Created by Rowan Walker on 23/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LegendAnnotation.h"


@class StoryViewController;

@interface NearByViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
	IBOutlet MKMapView *myMapView;
	IBOutlet StoryViewController *storyVC;
	CLLocationManager *locationManager;
	NSString *directoryPath;
	NSArray *directoryContents;

}

@property (nonatomic, retain) IBOutlet MKMapView *myMapView;
@property (nonatomic, retain) CLLocationManager *locationManager;


//START:code.FilesystemExplorer.directorypathpropertydeclaration
@property (nonatomic, retain) NSString *directoryPath;
//END:code.FilesystemExplorer.directorypathpropertydeclaration

- (void)loadDirectoryContents;
- (void)startStandardUpdates;


@end
