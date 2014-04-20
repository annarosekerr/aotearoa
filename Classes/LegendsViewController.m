//
//  LegendsViewController.m
//  MockUp
//
//  Created by Rowan Walker on 23/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LegendsViewController.h"
#import "StoryViewController.h"
#import "ErrorMessageViewController.h"

@implementation LegendsViewController

@synthesize locationManager;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:211.0/256.0 green:61.0/256.0 blue:2.0/256.0 alpha:1.0];
	
	CGRect frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, 50);
	UIView *myTabView = [ [UIView alloc] initWithFrame:frame];
	[myTabView setBackgroundColor:[UIColor colorWithRed:82.0/256.0 green:93.0/256.0 blue:106.0/256.0 alpha:1.0]];
	//[myTabView setAlpha:0.5];
	[[self.tabBarController tabBar] insertSubview:myTabView atIndex:0];
	[myTabView release];
	
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
	
	/*NSLog(@"length = %d", [directoryContents count]);
	for (int i = 0; i < [directoryContents count] ; i++) {
		NSLog([directoryContents objectAtIndex:i]);
	}*/
	
	/*
	NSLog(pathBundle);
	
	self.directoryPath = pathBundle;//[pathBundle stringByAppendingPathComponent:@"/Resources/Legends"];//[NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/Legends"];//[[NSBundle mainBundle] bundlePath];//[NSHomeDirectory() stringByAppendingPathComponent:@"/Resources/Legends"];
	NSLog(self.directoryPath);
	NSLog(@"length = %d", [directoryContents count]);
	for (int i = 0; i < [directoryContents count] ; i++) {
		NSLog([directoryContents objectAtIndex:i]);
	}*/
	
	//if ([locationManager locationServicesEnabled]) {
	[self startStandardUpdates];
	//}else {
	if (![CLLocationManager locationServicesEnabled] || !([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)) {
	  /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Legends Error Message" 
	  message:@"Uh oh! We can’t display a legend associated with your current location. Either because we don't know where you are, or we don't know a legend about this place. \n \n Please ensure you have GPS switched on and have allowed Aotearoa to access your location. \n \n Try looking on the map for nearby legends and see which regions we have covered. You can help us cover more places by emailing New Zealand legends to aotearoa@annarosekerr.com."
	  delegate:nil 
	  cancelButtonTitle:@"OK"
	  otherButtonTitles:nil];
	  [alert show];
	  [alert release];*/
		[self.navigationController pushViewController:errorVC animated:YES];

	}
	
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


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

#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [directoryContents count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	
		
	NSArray* splitString = [[directoryContents objectAtIndex:indexPath.row] componentsSeparatedByString:@"/"];
	NSString* text = [splitString objectAtIndex:[splitString count]-1 ];
	splitString = [text componentsSeparatedByString:@" legend.txt"];
	//NSLog(type);

	
	cell.textLabel.text = [splitString objectAtIndex:0];//[directoryContents objectAtIndex:(indexPath.row)];
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
	//NSLog([[NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/Legends"] 
	//	   stringByAppendingPathComponent:[[directoryContents objectAtIndex:(indexPath.row + 1)] stringByAppendingPathComponent:@"/legends.txt"]]);
	NSString *tempPath = [directoryContents objectAtIndex:(indexPath.row )];
	//NSLog(tempPath);
	//NSStringEncoding *enc;
	//NSLog([NSString stringWithContentsOfFile:tempPath]);
	
	NSArray* splitString = [[directoryContents objectAtIndex:indexPath.row] componentsSeparatedByString:@"/"];
	NSString* text = [splitString objectAtIndex:[splitString count]-1 ];
	splitString = [text componentsSeparatedByString:@" legend.txt"];
	
	storyVC.place = [splitString objectAtIndex:0];
	
	storyVC.legendStory =[NSString stringWithContentsOfFile:tempPath
							  encoding:NSUTF8StringEncoding
													  error:NULL];
	
	//storyVC.legendStory = [NSString stringWithContentsOfFile: tempPath];
	//[tempPath dealloc];
	[self.navigationController pushViewController:storyVC animated:YES];
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[storyVC dealloc];
    [super dealloc];
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
	
	// NSLog(@"latitude %+.6f, longitude %+.6f\n",
	
	// newLocation.coordinate.latitude,
	
	// newLocation.coordinate.longitude);
	
	//[locationManager stopUpdatingLocation];
	
	NSString *tempPath; 	
	for (int i=0; i < ([directoryContents count]); i++) {
		
		
		NSArray* splitString = [[directoryContents objectAtIndex:i] componentsSeparatedByString:@" legend.txt"];
		tempPath = [[splitString objectAtIndex:0 ] stringByAppendingString:@" latitude.txt"];
		//NSLog(type);

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
			
			//NSString *tempLegPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/Legends"] 
			//					  stringByAppendingPathComponent:[[directoryContents objectAtIndex:(i + 1)] stringByAppendingPathComponent:@"/legend.txt"]];
			//NSLog(tempPath);
			//NSStringEncoding *enc;
			//NSLog([NSString stringWithContentsOfFile:tempPath]);
			
			NSArray* splitString = [[directoryContents objectAtIndex:i] componentsSeparatedByString:@"/"];
			NSString* text = [splitString objectAtIndex:[splitString count]-1 ];
			splitString = [text componentsSeparatedByString:@" legend.txt"];
			
			storyVC.place = [splitString objectAtIndex:0];
			
			storyVC.legendStory =[NSString stringWithContentsOfFile:[directoryContents objectAtIndex:i]
														   encoding:NSUTF8StringEncoding
															  error:NULL];
			
			//storyVC.legendStory = [NSString stringWithContentsOfFile: tempPath];
			//[tempPath dealloc];
			if ([[self.navigationController visibleViewController] isEqual:storyVC]) {
				
			}else if ([[self.navigationController visibleViewController] isEqual:errorVC]){
				
				[self.navigationController popViewControllerAnimated:NO];
				
				[self.navigationController pushViewController:storyVC animated:YES];

			}else {
				[self.navigationController pushViewController:storyVC animated:YES];
			}

			break;
		}else if (i == ([directoryContents count] - 1)) {
			if ([[self.navigationController visibleViewController] isEqual:storyVC]) {
				
				[self.navigationController popViewControllerAnimated:NO];
				
				[self.navigationController pushViewController:errorVC animated:YES];
				
			}else if ([[self.navigationController visibleViewController] isEqual:errorVC]){
				
			}else {
				[self.navigationController pushViewController:errorVC animated:YES];
			}
		}
		
		[anoLoc release];
		
		
		
	}
	
	
	
	
	
    //}
	
    // else skip the event and process the next one.
	
}



@end

