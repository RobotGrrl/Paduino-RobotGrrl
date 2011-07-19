//
//  PaduinoAppDelegate.m
//  Paduino
//
//  Created by Alasdair Allan on 14/07/2011.
//  Copyright 2011 University of Exeter. All rights reserved.
//

#import "PaduinoAppDelegate.h"

@implementation PaduinoAppDelegate


@synthesize window=_window;

/*
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];
    return YES;
}
 */

- (void)applicationWillResignActive:(UIApplication *)application {
 
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
 
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
 }

- (void)dealloc {
    [_window release];
    [super dealloc];
}

@end
