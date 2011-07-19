//
//  PaduinoAppDelegate_iPhone.h
//  Paduino
//
//  Created by Alasdair Allan on 14/07/2011.
//  Copyright 2011 University of Exeter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaduinoAppDelegate.h"
#import "RootController_iPhone.h"

@interface PaduinoAppDelegate_iPhone : PaduinoAppDelegate {
    
    RootController_iPhone *viewController;
}

@property (nonatomic, retain) IBOutlet RootController *viewController;

@end
