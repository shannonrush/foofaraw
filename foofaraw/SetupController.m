//
//  SetupController.m
//  foofaraw
//
//  Created by Shannon Rush on 5/26/11.
//  Copyright 2011 Rush Devo. All rights reserved.
//

#import "SetupController.h"
#import "foofarawAppDelegate.h"
#import <QuartzCore/QuartzCore.h>


@implementation SetupController

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
    [self initApp];
}

-(void)initApp {
    NSString *appChoicesPath = [[NSBundle mainBundle] pathForResource:@"appChoices" ofType:@"plist"];
    NSDictionary *appChoices = [NSDictionary dictionaryWithContentsOfFile:appChoicesPath];
    NSArray *names = [appChoices objectForKey:@"names"];
    name = [[NSString alloc]initWithString:[names objectAtIndex:arc4random()%[names count]]];
    NSArray *personalities = [[appChoices objectForKey:@"personalities"]allKeys];
    NSString *personalityString = [personalities objectAtIndex:arc4random()%[personalities count]];
    personality = [[NSDictionary alloc]initWithDictionary:[[appChoices objectForKey:@"personalities"]objectForKey:personalityString]];
    foofarawAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context = [appDelegate managedObjectContext];
	NSManagedObject *accountObject = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"Account" 
                                    inManagedObjectContext:context];
	[accountObject setValue:name forKey:@"appName"];
    [accountObject setValue:personalityString forKey:@"personality"];
	NSError *error;
	[context save:&error];
    [self setup];
}

-(void)setup {
    UIView *greetingView = [[UIView alloc]initWithFrame:CGRectMake(150.0, 200.0, 146.0, 96.0)];
    UIImage *bubble1 = [UIImage imageNamed:@"bubble1.png"];
    UIImageView *bubble1View = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 146.0, 96.0)];
    bubble1View.image = bubble1;
    [greetingView addSubview:bubble1View];
    [bubble1View release];
    UILabel *greetingLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 10.0, 126.0, 60.0)];
    greetingLabel.backgroundColor = [UIColor clearColor];
    greetingLabel.textAlignment = UITextAlignmentCenter;
    greetingLabel.font = [UIFont fontWithName:@"Helvetica" size:30.0];
    greetingLabel.text = [personality valueForKey:@"greeting"];
    [greetingView addSubview:greetingLabel];
    [greetingLabel release];
    greetingView.alpha = 0.0;
    [self.view addSubview:greetingView];
    [greetingView release];
    [UIView animateWithDuration:2.0 animations:^{
        greetingView.alpha = 1.0;  
    }];
}

#pragma mark - View lifecycle

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [super dealloc];
}

@end
