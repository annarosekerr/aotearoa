//
//  DefinitionViewController.h
//  MockUp
//
//  Created by Rowan Walker on 23/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DefinitionViewController : UIViewController {

	NSString *word;
	NSString *definition;
	IBOutlet UITextView *textView;
	
}

@property (nonatomic, retain) NSString *word;
@property (nonatomic, retain) NSString *definition;

@property (nonatomic, retain) IBOutlet UITextView *textView;


@end
