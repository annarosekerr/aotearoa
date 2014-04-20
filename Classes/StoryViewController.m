//
//  StoryViewController.m
//  MockUp
//
//  Created by Rowan Walker on 23/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StoryViewController.h"


@implementation StoryViewController

@synthesize place, legendStory, textView;





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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//textView.text = legendStory;
	//[(UIBarButtonItem *)view setTintColor:newColor]
	//self.navigationController.navigationItem.backBarButtonItem = [UIBarButtonItem initWithCustomView: ]  [[UIColor colorWithRed:1.0/256.0 green:42.0/256.0 blue:3.0/256.0 alpha:1.0];

}*/

- (void)viewWillAppear:(BOOL)animated {    
    // Update the views appropriately
	self.navigationItem.title = place;
    self.textView.text = legendStory;
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


@end
