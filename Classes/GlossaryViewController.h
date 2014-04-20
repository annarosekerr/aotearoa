//
//  GlossaryViewController.h
//  MockUp
//
//  Created by Rowan Walker on 23/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DefinitionViewController;

@interface GlossaryViewController : UITableViewController {

	IBOutlet DefinitionViewController *definitionVC;
	NSString *directoryPath;
	NSArray *directoryContents;
}

//START:code.FilesystemExplorer.directorypathpropertydeclaration
@property (nonatomic, retain) NSString *directoryPath;
//END:code.FilesystemExplorer.directorypathpropertydeclaration

- (void)loadDirectoryContents;

@end
