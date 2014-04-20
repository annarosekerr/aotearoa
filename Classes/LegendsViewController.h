//
//  LegendsViewController.h
//  MockUp
//
//  Created by Rowan Walker on 23/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@class StoryViewController;
@class ErrorMessageViewController;

@interface LegendsViewController : UITableViewController <CLLocationManagerDelegate>{

	IBOutlet StoryViewController *storyVC;
	IBOutlet ErrorMessageViewController *errorVC;

	NSString *directoryPath;
	NSArray *directoryContents;
	CLLocationManager *locationManager;

}

@property (nonatomic, retain) CLLocationManager *locationManager;


//START:code.FilesystemExplorer.directorypathpropertydeclaration
@property (nonatomic, retain) NSString *directoryPath;
//END:code.FilesystemExplorer.directorypathpropertydeclaration

- (void)loadDirectoryContents;
- (void)startStandardUpdates;


@end
