//
//  StoryViewController.h
//  MockUp
//
//  Created by Rowan Walker on 23/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StoryViewController : UIViewController {
	NSString *place;
	NSString *legendStory;
	IBOutlet UITextView *textView;
}

@property (nonatomic, retain) NSString *place;
@property (nonatomic, retain) NSString *legendStory;

@property (nonatomic, retain) IBOutlet UITextView *textView;

@end
