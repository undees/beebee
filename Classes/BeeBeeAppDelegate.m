//
//  BeeBeeAppDelegate.m
//  BeeBee
//
//  Created by Ian Dees on 6/10/09.
//  Copyright Ian Dees 2009. All rights reserved.
//

#import "BeeBeeAppDelegate.h"
#import "BeeBeeViewController.h"

@implementation BeeBeeAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
