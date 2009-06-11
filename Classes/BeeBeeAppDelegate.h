//
//  BeeBeeAppDelegate.h
//  BeeBee
//
//  Created by Ian Dees on 6/10/09.
//  Copyright Ian Dees 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BeeBeeViewController;

@interface BeeBeeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    BeeBeeViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet BeeBeeViewController *viewController;

@end

