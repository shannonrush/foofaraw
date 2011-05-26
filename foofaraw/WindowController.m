//
//  WindowController.m
//  foofaraw
//
//  Created by Shannon Rush on 5/25/11.
//  Copyright 2011 Rush Devo. All rights reserved.
//

#import "WindowController.h"


@implementation WindowController


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVideo];
}

-(void)initVideo {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    captureSession = [[AVCaptureSession alloc] init];
    [captureSession addInput:captureInput];
    CALayer *layer = [self.view layer];
    previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
    CGRect frame = [layer frame];
    frame.origin.x = frame.origin.y = 0;
    [previewLayer setFrame:frame];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [layer addSublayer:previewLayer];
    [captureSession startRunning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

@end
