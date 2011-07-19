//
//  LogController.m
//  Paduino
//
//  Created by Alasdair Allan on 14/07/2011.
//  Copyright 2011 University of Exeter. All rights reserved.
//

#import "LogController.h"

@implementation LogController

@synthesize logWindow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *log = [[paths objectAtIndex:0] stringByAppendingPathComponent: @"ns.log"];	
        NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:log];
        
        //Read the existing logs, I opted not to do this.
        //[logWindowTextField readRTFDFromFile:logPath];
        
        //Seek to end of file so that logs from previous application launch are not visible
        [fh seekToEndOfFile];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(getData:)
                                                     name:@"NSFileHandleReadCompletionNotification"
                                                   object:fh];
        [fh readInBackgroundAndNotify];
        firstOpen = YES;
    }
    return self;
}

- (void)dealloc {
    [logWindow release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *log = [[paths objectAtIndex:0] stringByAppendingPathComponent: @"ns.log"];	
    //NSLog(@"Opened log window.");
    if ( firstOpen ) {
        NSString* content = [NSString stringWithContentsOfFile:log encoding:NSUTF8StringEncoding error:NULL];  
        logWindow.editable = TRUE;
		logWindow.text = [logWindow.text stringByAppendingString: content];
		logWindow.editable = FALSE;
        firstOpen = NO;
    } 
}

- (void)viewDidUnload {
    [self setLogWindow:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
	return YES;
}

#pragma mark - NSLog Redirection Methods

- (void) getData: (NSNotification *)aNotification {
    NSData *data = [[aNotification userInfo] objectForKey:NSFileHandleNotificationDataItem];
    // If the length of the data is zero, then the task is basically over - there is nothing
    // more to get from the handle so we may as well shut down.
    if ([data length])
    {
        // Send the data on to the controller; we can't just use +stringWithUTF8String: here
        // because -[data bytes] is not necessarily a properly terminated string.
        // -initWithData:encoding: on the other hand checks -[data length]
        NSString *aString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
		
		logWindow.editable = TRUE;
		logWindow.text = [logWindow.text stringByAppendingString: aString];
		logWindow.editable = FALSE;
        
		//Scroll to the last line
		[self setWindowScrollToVisible];
        
		// we need to schedule the file handle go read more data in the background again.
		[[aNotification object] readInBackgroundAndNotify];
    }
	else
	{
		//I use a delay to minimize CPU usage when the file has not changed.
		[self performSelector:@selector(refreshLog:) withObject:aNotification afterDelay:1.0];
	}
}
- (void) refreshLog: (NSNotification *)aNotification {
	[[aNotification object] readInBackgroundAndNotify];
}

-(void)setWindowScrollToVisible {
	NSRange txtOutputRange;
	txtOutputRange.location = [[logWindow text] length];
	txtOutputRange.length = 0;
    logWindow.editable = TRUE;
	[logWindow scrollRangeToVisible:txtOutputRange];
	[logWindow setSelectedRange:txtOutputRange];
    logWindow.editable = FALSE;
}

#pragma mark - UIBarButtonItem Callbacks

-(IBAction)done:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
    
}

@end

