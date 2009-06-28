//
//  BeeBeeViewController.h
//  BeeBee
//
//  Created by Ian Dees on 6/10/09.
//  Copyright Ian Dees 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeeBeeViewController : UIViewController<UITextFieldDelegate> {
	IBOutlet UITextField *textField;
	IBOutlet UILabel *first, *second;

	BOOL usingHeadphones;

	UILabel *front, *back;
	CGAffineTransform normal, bigger, smaller;
	NSMutableDictionary *players;
}

@end

