//
//  GlossaryViewController.m
//  MockUp
//
//  Created by Rowan Walker on 23/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GlossaryViewController.h"
#import "DefinitionViewController.h"


@implementation GlossaryViewController

//@synthesize definitionVC;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
		if ([type isEqualToString:@"definition.txt"]) {
			[tempContents addObject:[tempArray objectAtIndex:i] ];
			//NSLog(@"HELLO");
		}
		
	}
	
	
	[directoryContents release];
    directoryContents = tempContents;//[bundle pathsForResourcesOfType:@"txt" inDirectory:NULL];
	[directoryContents retain];
	
	
	//self.directoryPath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/Definitions"];//[[NSBundle mainBundle] bundlePath];//[NSHomeDirectory() stringByAppendingPathComponent:@"/Resources/Legends"];

	//for (int i = 0; i < [directoryContents count] ; i++) {
		//NSLog([directoryContents objectAtIndex:i]);
	//}
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


#pragma mark -
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
	splitString = [text componentsSeparatedByString:@" definition.txt"];
	
	cell.textLabel.text = [splitString objectAtIndex:0];
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
	
	//NSString *tempPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/Definitions"] 
	//					  stringByAppendingPathComponent:[[directoryContents objectAtIndex:indexPath.row] stringByAppendingPathComponent:@"/definition.txt"]];
	
	NSString *tempPath = [directoryContents objectAtIndex:(indexPath.row )];

	
	//NSLog(tempPath);
	//NSStringEncoding *enc;
	//NSLog([NSString stringWithContentsOfFile:tempPath]);
	
	NSArray* splitString = [[directoryContents objectAtIndex:indexPath.row] componentsSeparatedByString:@"/"];
	NSString* text = [splitString objectAtIndex:[splitString count]-1 ];
	splitString = [text componentsSeparatedByString:@" definition.txt"];
	
	
	definitionVC.word = [splitString objectAtIndex:0];
	
	definitionVC.definition =[NSString stringWithContentsOfFile:tempPath
												   encoding:NSUTF8StringEncoding
													  error:NULL];
	
	//storyVC.legendStory = [NSString stringWithContentsOfFile: tempPath];
	//[tempPath dealloc];
	[self.navigationController pushViewController:definitionVC animated:YES];
	
	
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
	[definitionVC dealloc];
    [super dealloc];
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

