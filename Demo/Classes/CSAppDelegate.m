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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    CSMainViewController *mainViewController = [[CSMainViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.5 alpha:1.0];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
