//
//  LogController.h
//  Paduino
//
//  Created by Alasdair Allan on 14/07/2011.
//  Copyright 2011 University of Exeter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogController : UIViewController {
    
    UITextView *logWindow;
    BOOL firstOpen;
}

@property (nonatomic, retain) IBOutlet UITextView *logWindow;

- (IBAction)done:(id)sender;
- (void)setWindowScrollToVisible;


@end
