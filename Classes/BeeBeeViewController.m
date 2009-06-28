//
//  BeeBeeViewController.m
//  BeeBee
//
//  Created by Ian Dees on 6/10/09.
//  Copyright Ian Dees 2009. All rights reserved.
//

#import "BeeBeeViewController.h"
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVAudioPlayer.h>

@implementation BeeBeeViewController


- (void)animationDidStop
{
	[back setTransform:smaller];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if (usingHeadphones)
		return NO;

	AVAudioPlayer *player = [players objectForKey:string];
	if (!player)
	{
		NSString *soundFilePath =
			[[NSBundle mainBundle] pathForResource:string
											ofType:@"aiff"];
		NSURL *fileURL;

		@try {
			fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath];
		}
		@catch (NSException *exception) {
			return NO;
		}

		player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL
														error:nil];
		if (!player)
			return NO;
		
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


- (void)disableHeadphones
{
	CFStringRef audioRoute;
	UInt32 propertySize = sizeof(CFStringRef);	

	if (0 == AudioSessionGetProperty(kAudioSessionProperty_AudioRoute,
									 &propertySize,
									 &audioRoute))
	{
		usingHeadphones = (kCFCompareEqualTo != CFStringCompare(audioRoute, (CFStringRef)@"Speaker", 0));
	}
	else
	{
		usingHeadphones = NO;
	}
	
	if (usingHeadphones)
	{
		[textField resignFirstResponder];
		UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Headphones detected" message:@"Please disconnect headphones before continuing" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] autorelease];
		[alert show];
	}
	else
	{
		[textField becomeFirstResponder];
	}
}


void audioRouteChangeListenerCallback(void                   *inUserData,
									  AudioSessionPropertyID inPropertyID,
									  UInt32                 inPropertyValueSize,
									  const void             *inPropertyValue)
{
	BeeBeeViewController* controller = (BeeBeeViewController*)inUserData;
	[controller disableHeadphones];
}


- (void)viewDidLoad {
    [super viewDidLoad];

	AudioSessionInitialize(NULL, NULL, NULL, NULL);
	UInt32 sessionCategory = kAudioSessionCategory_UserInterfaceSoundEffects;
	AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
	AudioSessionAddPropertyListener(kAudioSessionProperty_AudioRouteChange, audioRouteChangeListenerCallback, self);
	AudioSessionSetActive(true);

	[self disableHeadphones];
	
	players = [[NSMutableDictionary alloc] init];
	front = first;
	back = second;

	normal = [first transform];
	bigger = CGAffineTransformScale(normal, 5.0, 5.0);
	smaller = CGAffineTransformScale(normal, 0.1, 0.1);

	[second setTransform:smaller];
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
