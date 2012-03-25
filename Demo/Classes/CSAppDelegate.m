//
//  CSAppDelegate.m
//  CSLinearLayoutViewDemo
//
//  Created by Charles Scalesse on 3/24/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import "CSAppDelegate.h"
#import "CSMainViewController.h"


@implementation CSAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;

- (void)dealloc {
    [_window release];
    [_navigationController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    CSMainViewController *mainViewController = [[[CSMainViewController alloc] init] autorelease];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:mainViewController] autorelease];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
