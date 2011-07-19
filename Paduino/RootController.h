//
//  RootController.h
//  Paduino
//
//  Created by Alasdair Allan on 14/07/2011.
//  Copyright 2011 University of Exeter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogController.h"
#import "RscMgr.h"

#define BUFFER_LEN 1024

@interface RootController : UIViewController <RscMgrDelegate> {
    
    UISwitch *pin13;
    UISwitch *pin12;
    UISwitch *pin11;
    UISwitch *pin10;
    UISwitch *pin9;
    UISwitch *pin8;
    UISwitch *pin7;
    UISwitch *pin6;
    UISwitch *pin5;
    UISwitch *pin4;
    UISwitch *pin3;
    UISwitch *pin2;
    UIImageView *connectedIndicator;
    
    UIButton *resetButton;
    
    UISlider *pwmPin11;
    
    RscMgr *manager;
    UInt8 rxBuffer[BUFFER_LEN];
	UInt8 txBuffer[BUFFER_LEN];
    
    LogController *logWindow;
}

@property (nonatomic, retain) LogController *logWindow;

@property (nonatomic, retain) IBOutlet UISwitch *pin13;
@property (nonatomic, retain) IBOutlet UISwitch *pin12;
@property (nonatomic, retain) IBOutlet UISwitch *pin11;
@property (nonatomic, retain) IBOutlet UISwitch *pin10;
@property (nonatomic, retain) IBOutlet UISwitch *pin9;
@property (nonatomic, retain) IBOutlet UISwitch *pin8;

@property (nonatomic, retain) IBOutlet UISwitch *pin7;
@property (nonatomic, retain) IBOutlet UISwitch *pin6;
@property (nonatomic, retain) IBOutlet UISwitch *pin5;
@property (nonatomic, retain) IBOutlet UISwitch *pin4;
@property (nonatomic, retain) IBOutlet UISwitch *pin3;
@property (nonatomic, retain) IBOutlet UISwitch *pin2;

@property (nonatomic, retain) IBOutlet UIButton *resetButton;

@property (nonatomic, retain) IBOutlet UISlider *pwmPin11;

@property (nonatomic, retain) IBOutlet UIImageView *connectedIndicator;

- (IBAction)help:(id)sender;
- (IBAction)log:(id)sender;
- (IBAction)slider:(id)sender;
- (IBAction)toggle:(id)sender;
- (IBAction)reset:(id)sender;

@end
