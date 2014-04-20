//
//  NearByViewController.m
//  MockUp
//
//  Created by Rowan Walker on 23/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NearByViewController.h"
#import "LegendAnnotation.h"
#import "StoryViewController.h"


@implementation NearByViewController


@synthesize myMapView, locationManager;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:211.0/256.0 green:61.0/256.0 blue:2.0/256.0 alpha:1.0];

	
	NSBundle* bundle = [NSBundle mainBundle];
	NSArray* tempArray = [bundle pathsForResourcesOfType:@"txt" inDirectory:NULL];
	NSMutableArray* tempContents = [[NSMutableArray alloc] init];;
	
	//NSLog(@"length = %d", [tempArray count]);
	for (int i = 0; i < [tempArray count] ; i++) {
		//NSLog([tempArray objectAtIndex:i]);
		
		NSArray* splitString = [[tempArray objectAtIndex:i] componentsSeparatedByString:@" "];
		NSString* type = [splitString objectAtIndex:[splitString count]-1 ];
		//NSLog(type);
		if ([type isEqualToString:@"legend.txt"]) {
			[tempContents addObject:[tempArray objectAtIndex:i] ];
			//NSLog(@"HELLO");
		}
		
	}
	
	[directoryContents release];
    directoryContents = tempContents;//[bundle pathsForResourcesOfType:@"txt" inDirectory:NULL];
	[directoryContents retain];
	
	//self.directoryPath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/Legends"];//[[NSBundle mainBundle] bundlePath];//[NSHomeDirectory() stringByAppendingPathComponent:@"/Resources/Legends"];

	
	//if ([locationManager locationServicesEnabled]) {
	[self startStandardUpdates];
	/*}else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Legends Error Message" 
														message:@"auth Sorry we can’t display a legend associated with your current location. Please ensure you have GPS switched on and have allowed Aotearoa to access your location. \n By looking at the map you can view nearby legends and see which regions we have covered. You can help us cover more regions by emailing myths & legends you know to aotearoa@annarosekerr.com."
													   delegate:nil 
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		
	}*/

	
	MKCoordinateRegion theRegion = myMapView.region;
	
	
	
	// Zoom in to NZ
	
	theRegion.center.latitude = -41.292494;
	
    theRegion.center.longitude = 174.773235;
	
	theRegion.span.longitudeDelta /= 16.0;
	
	theRegion.span.latitudeDelta /= 16.0;
	
	[myMapView setRegion:theRegion animated:YES];
	
	NSString *tempPath; 	
	for (int i=0; i < ([directoryContents count]); i++) {
		LegendAnnotation* annotation = [[LegendAnnotation alloc] init];
		
		
		NSArray* splitString = [[directoryContents objectAtIndex:i] componentsSeparatedByString:@" legend.txt"];
		tempPath = [[splitString objectAtIndex:0 ] stringByAppendingString:@" latitude.txt"];
		//tempPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/Legends"] 
		//			stringByAppendingPathComponent:[[directoryContents objectAtIndex:(i + 1)] stringByAppendingPathComponent:@"/latitude.txt"]];
		
		annotation.latitude = [NSNumber numberWithDouble:[[NSString stringWithContentsOfFile:tempPath
								   encoding:NSUTF8StringEncoding
									  error:NULL] doubleValue] ];
		
		//NSLog(tempPath);
		
		
		
		
		tempPath = [[splitString objectAtIndex:0 ] stringByAppendingString:@" longitude.txt"];
		
		//tempPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/Legends"] 
		//			stringByAppendingPathComponent:[[directoryContents objectAtIndex:(i+ 1)] stringByAppendingPathComponent:@"/longitude.txt"]];
		
		
		annotation.longitude = [NSNumber numberWithDouble:[[NSString stringWithContentsOfFile:tempPath
														  encoding:NSUTF8StringEncoding
															 error:NULL] doubleValue]];
		
		//annotation.legendName = @"Maori Legend";
		//NSLog([directoryContents objectAtIndex:(i + 1)]);
		
		splitString = [[directoryContents objectAtIndex:i] componentsSeparatedByString:@"/"];
		NSString* text = [splitString objectAtIndex:[splitString count]-1 ];
		splitString = [text componentsSeparatedByString:@" legend.txt"];
		annotation.place = [splitString objectAtIndex:0];
		
		//[legendAnnotations arrayByAddingObject: annotation];
		
		[myMapView addAnnotation:annotation];
	}
	
		

	self.myMapView.showsUserLocation = YES;
	
	//aView.image = [UIImage imageNamed:@"myimage.png"];
	
	//aView.centerOffset = CGPointMake(10, -20);
	
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}



#pragma mark MapKit Delegate Methods

- (void)mapView:(MKMapView *)mapView 
 annotationView:(MKAnnotationView *)view 
calloutAccessoryControlTapped:(UIControl *)control
{

    if (view.annotation == mapView.userLocation)
        return;
	
    LegendAnnotation *annotation = (LegendAnnotation *)view.annotation;
	//NSLog(annotation.place);
	NSArray* splitString;
	NSString* tempPath;
	for (int i=0; i < ([directoryContents count]); i++) {

		splitString = [[directoryContents objectAtIndex:i] componentsSeparatedByString:@"/"];
		NSString* text = [splitString objectAtIndex:[splitString count]-1 ];
		splitString = [text componentsSeparatedByString:@" legend.txt"];
		if ([[splitString objectAtIndex:0] isEqualToString:annotation.place]) {
			tempPath = [directoryContents objectAtIndex:i];
			break;
		}
		
	}
	
	//tempPath = [[splitString objectAtIndex:0 ] stringByAppendingPathComponent:@" latitude.txt"];

	
	//NSString *tempPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/Legends"] 
	//					  stringByAppendingPathComponent:[annotation.place stringByAppendingPathComponent:@"/legend.txt"]];

	
	storyVC.place = annotation.place;
	
	storyVC.legendStory =[NSString stringWithContentsOfFile:tempPath
												   encoding:NSUTF8StringEncoding
													  error:NULL];

	[self.navigationController pushViewController:storyVC animated:YES];

	
	
    //show detail view using buttonDetail...
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	
	// If it's the user location, just return nil.
	
    if ([annotation isKindOfClass:[MKUserLocation class]])
		return nil;
	

		
	if ([annotation isKindOfClass:[LegendAnnotation class]]){	
		
		// Try to dequeue an existing pin view first.
        MKPinAnnotationView* pinView = (MKPinAnnotationView*)[mapView
															  dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotation"];
		
        if (!pinView)
			
        {
			
            // If an existing pin view was not available, create one.
			
			pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation
						
													   reuseIdentifier:@"CustomPinAnnotation"]
					   
					   autorelease];
			
            pinView.pinColor = MKPinAnnotationColorRed;
			
            pinView.animatesDrop = YES;
			
            pinView.canShowCallout = YES;
			
			
			
            // Add a detail disclosure button to the callout.
			
            UIButton* rightButton = [UIButton buttonWithType:
									 
									 UIButtonTypeDetailDisclosure];
			
            //[rightButton addTarget:self action:@selector(showDetails:)
			 
			//	  forControlEvents:UIControlEventTouchUpInside];
			
            pinView.rightCalloutAccessoryView = rightButton;
			
        }else
			pinView.annotation = annotation;
		
        return pinView;
		
	}
	
	return nil;
		
    
}

#pragma mark Location Methods
- (void)startStandardUpdates

{
	
    // Create the location manager if this object does not
	
    // already have one.
	
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
	
	
	
    locationManager.delegate = self;
	
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
	
	
    // Set a movement threshold for new events.
	
    locationManager.distanceFilter = 5;
	
	
	
    [locationManager startUpdatingLocation];
	
}

// Delegate method from the CLLocationManagerDelegate protocol.

- (void)locationManager:(CLLocationManager *)manager

    didUpdateToLocation:(CLLocation *)newLocation

		   fromLocation:(CLLocation *)oldLocation {
	
    // If it's a relatively recent event, turn off updates to save power
	
    //NSDate* eventDate = newLocation.timestamp;
	
	//NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
	
    //if (abs(howRecent) < 15.0){
		
        /*NSLog(@"latitude %+.6f, longitude %+.6f\n",
			  
			  newLocation.coordinate.latitude,
			  
			  newLocation.coordinate.longitude);*/
	
	
	
	NSString *tempPath; 	
	for (int i=0; i < ([directoryContents count] - 1); i++) {

		
		NSArray* splitString = [[directoryContents objectAtIndex:i] componentsSeparatedByString:@" legend.txt"];
		tempPath = [[splitString objectAtIndex:0 ] stringByAppendingString:@" latitude.txt"];
		
		//tempPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/Legends"] 
		//			stringByAppendingPathComponent:[[directoryContents objectAtIndex:(i + 1)] stringByAppendingPathComponent:@"/latitude.txt"]];
		
		CLLocationDegrees lat = [[NSNumber numberWithDouble:[[NSString stringWithContentsOfFile:tempPath
																					encoding:NSUTF8StringEncoding
																					   error:NULL] doubleValue] ] doubleValue] ;
		
		
		
		tempPath = [[splitString objectAtIndex:0 ] stringByAppendingString:@" longitude.txt"];
		
		//tempPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/Legends"] 
		//			stringByAppendingPathComponent:[[directoryContents objectAtIndex:(i+ 1)] stringByAppendingPathComponent:@"/longitude.txt"]];
		
		CLLocationDegrees lon = [[NSNumber numberWithDouble:[[NSString stringWithContentsOfFile:tempPath
																					 encoding:NSUTF8StringEncoding
																						error:NULL] doubleValue]] doubleValue];
		
		
		CLLocation *anoLoc = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
		
		
		
		if ( 5000.0 > [newLocation distanceFromLocation:anoLoc]) {
			// On the first location update only, zoom map to user location
			MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 35000, 35000);
			[myMapView setRegion:region animated:YES];
		}
		
		[anoLoc release];
		


	}
	


	

		
    //}
	
    // else skip the event and process the next one.
	
}

#pragma mark File management
//START:code.FilesystemExplorer.directorypathpropertyimpl
-(NSString*) directoryPath {
	return directoryPath;
}

-(void) setDirectoryPath: (NSString*) p {
	[p retain];
	[directoryPath release];
	directoryPath = p;
	[p release];
	[self loadDirectoryContents];
	// also set title of nav controller with last path element
	//NSString *pathTitle= [directoryPath lastPathComponent];
	//self.title = pathTitle;
}
//END:code.FilesystemExplorer.directorypathpropertyimpl

//START:code.FilesystemExplorer.loadDirectoryContents
- (void) loadDirectoryContents {
	[directoryContents release];
	directoryContents = [[NSFileManager defaultManager]
						 contentsOfDirectoryAtPath:directoryPath error:NULL];
	[directoryContents retain];
}
//END:code.FilesystemExplorer.loadDirectoryContents


@end
