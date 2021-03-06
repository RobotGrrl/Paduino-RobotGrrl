//
//  PaduinoAppDelegate_iPad.m
//  Paduino
//
//  Created by Alasdair Allan on 14/07/2011.
//  Copyright 2011 University of Exeter. All rights reserved.
//

#import "PaduinoAppDelegate_iPad.h"

@implementation PaduinoAppDelegate_iPad

@synthesize viewController=_viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];  
    
    return YES;
}

- (void)dealloc {
	[super dealloc];
}

@end
