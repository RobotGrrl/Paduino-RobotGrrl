//
//  PaduinoAppDelegate_iPad.h
//  Paduino
//
//  Created by Alasdair Allan on 14/07/2011.
//  Copyright 2011 University of Exeter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaduinoAppDelegate.h"
#import "RootController_iPad.h"

@interface PaduinoAppDelegate_iPad : PaduinoAppDelegate {
    
    RootController_iPad *viewController;
}

@property (nonatomic, retain) IBOutlet RootController *viewController;

@end
