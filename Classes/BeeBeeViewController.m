//
//  BeeBeeViewController.m
//  BeeBee
//
//  Created by Ian Dees on 6/10/09.
//  Copyright Ian Dees 2009. All rights reserved.
//

#import "BeeBeeViewController.h"
#import <AVFoundation/AVAudioPlayer.h>

@implementation BeeBeeViewController


- (void)animationDidStop
{
	[back setTransform:smaller];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	AVAudioPlayer *player = [players objectForKey:string];
	
	if (!player)
	{
		NSString *soundFilePath =
			[[NSBundle mainBundle] pathForResource:string
											ofType:@"aiff"];

		NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath];

		player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL
														error:nil];
		[fileURL release];
		
		[players setObject:player forKey:string];
		[player release];
	}

	[back setText:[string capitalizedString]];

	[UIView beginAnimations:@"labelAnimations" context:nil];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop)];

	[front setTransform:bigger];
	[front setAlpha:0.0];
	[back setTransform:normal];
	[back setAlpha:1.0];

	[UIView commitAnimations];
	
	UILabel* temp = front;
	front = back;
	back = temp;

	[player play];

	return NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];

	players = [[NSMutableDictionary alloc] init];
	front = first;
	back = second;

	normal = [first transform];
	bigger = CGAffineTransformScale(normal, 5.0, 5.0);
	smaller = CGAffineTransformScale(normal, 0.1, 0.1);

	[second setTransform:smaller];
	
	[textField becomeFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [players removeAllObjects];
}


- (void)dealloc {
	[players release];
    [super dealloc];
}

@end
