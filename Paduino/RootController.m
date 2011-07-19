//
//  RootController.m
//  Paduino
//
//  Created by Alasdair Allan on 14/07/2011.
//  Copyright 2011 University of Exeter. All rights reserved.
//

#import "RootController.h"

@implementation RootController

@synthesize logWindow;

@synthesize pin13;
@synthesize pin12;
@synthesize pin11;
@synthesize pin10;
@synthesize pin9;
@synthesize pin8;
@synthesize pin7;
@synthesize pin6;
@synthesize pin5;
@synthesize pin4;
@synthesize pin3;
@synthesize pin2;
@synthesize resetButton;
@synthesize pwmPin11;
@synthesize connectedIndicator;

- (void)dealloc {
    [pin13 release];
    [pin12 release];
    [pin11 release];
    [pin10 release];
    [pin9 release];
    [pin8 release];
    [pin7 release];
    [pin6 release];
    [pin5 release];
    [pin4 release];
    [pin3 release];
    [pin2 release];
    [resetButton release];
    [connectedIndicator release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
        
    [super viewDidLoad];
    manager = [[RscMgr alloc] init]; 
	[manager setDelegate:self];
    
    self.logWindow = [[LogController alloc] initWithNibName:@"LogController" bundle:nil];
}

- (void)viewDidUnload {
    [self setPin13:nil];
    [self setPin12:nil];
    [self setPin11:nil];
    [self setPin10:nil];
    [self setPin9:nil];
    [self setPin8:nil];
    [self setPin7:nil];
    [self setPin6:nil];
    [self setPin5:nil];
    [self setPin4:nil];
    [self setPin3:nil];
    [self setPin2:nil];
    [self setConnectedIndicator:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - UIToolbarButton Callbacks

- (IBAction)help:(id)sender {
    
}

- (IBAction)log:(id)sender {
    [self presentModalViewController:self.logWindow animated:YES];
    
}

#pragma mark - UISlider Callback

- (IBAction) slider:(id)sender {
    
    int res = (int)[(UISlider *)sender value];
    NSLog(@"Toggled output pin %i to %i", [sender tag], res);
    txBuffer[0] = [sender tag];
    txBuffer[1] = res;
	int bytesWritten = [manager write:txBuffer Length:2];
    NSLog( @"Wrote %d bytes to serial cable.", bytesWritten);
    
}

#pragma mark - UISwitch Callback

- (IBAction)toggle:(id)sender {
    
    NSLog(@"Toggled output pin %i to %i", [sender tag], [(UISwitch *)sender isOn] );
    txBuffer[0] = [sender tag];
    txBuffer[1] = [(UISwitch *)sender isOn];
	int bytesWritten = [manager write:txBuffer Length:2];
    NSLog( @"Wrote %d bytes to serial cable.", bytesWritten);
}


#pragma mark - UIButton Callback

- (IBAction)reset:(id)sender {
    
    NSLog(@"Pushed reset button" );
    txBuffer[0] = 99;
    txBuffer[1] = 1;
	int bytesWritten = [manager write:txBuffer Length:2];
    NSLog( @"Wrote %d bytes to serial cable.", bytesWritten);
   
    
}

#pragma mark - RscMgrDelegate methods


- (void) cableConnected:(NSString *)protocol {
    NSLog(@"Cable Connected: %@", protocol);
    [manager setBaud:9600];
	[manager open];
    UIImage *img = [UIImage imageNamed:@"GreenLight.png"];
    self.connectedIndicator.image = img;
    
}

- (void) cableDisconnected {
    NSLog(@"Cable disconnected");
    UIImage *img = [UIImage imageNamed:@"RedLight.png"];
    self.connectedIndicator.image = img;	
}


- (void) portStatusChanged {
    NSLog(@"portStatusChanged");
    
}

- (void) readBytesAvailable:(UInt32)numBytes {
    NSLog(@"readBytesAvailable:");
    int bytesRead = [manager read:rxBuffer Length:numBytes];
    NSLog( @"Read %d bytes from serial cable.", bytesRead );
    
    NSString *string = nil;
    for(int i = 0;i < numBytes;++i) {
        if ( string ) { 
            //string =  [NSString stringWithFormat:@"%@%c", string, ((char *)rxBuffer)[i]];
            string =  [NSString stringWithFormat:@"%@%c", string, rxBuffer[i]];
        } else {
            //string =  [NSString stringWithFormat:@"%c", ((char *)rxBuffer)[i]];
            string =  [NSString stringWithFormat:@"%c", rxBuffer[i]];
        }
    }
    NSLog(@"Recieved: %@", string);
}

- (BOOL) rscMessageReceived:(UInt8 *)msg TotalLength:(int)len {
    NSLog(@"rscMessageRecieved:TotalLength:");
    return FALSE;    
}

- (void) didReceivePortConfig {
    NSLog(@"didRecievePortConfig");
}


@end
