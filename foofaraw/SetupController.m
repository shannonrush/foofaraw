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
    [self introduction];
}

-(void)introduction {
    UIView *greetingView = [self greetingView];
    UIView *intro1View = [self intro1View];
    UIView *intro2View = [self intro2View];
    usernameResponseView = [self usernameResponseView];
    [self.view addSubview:greetingView];
    [self.view addSubview:intro1View];
    [self.view addSubview:intro2View];
    [self.view addSubview:usernameResponseView];
    [greetingView release];
    [intro1View release];
    [intro2View release];
    [usernameResponseView release];
    [UIView animateWithDuration:2.0 delay:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        greetingView.alpha = 1.0; 
    } completion:^ (BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:2.0 delay:2.0 options:UIViewAnimationCurveEaseInOut animations:^ {
                greetingView.alpha = 0.0;
                intro1View.alpha = 1.0;
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:2.0 delay:2.0 options:UIViewAnimationCurveEaseInOut animations:^ {
                    intro1View.alpha = 0.0;
                    intro2View.alpha = 1.0;
                }completion:^ (BOOL finished) {
                    [UIView animateWithDuration:2.0 delay:2.0 options:UIViewAnimationCurveEaseInOut animations:^ {
                        intro2View.alpha = 0.0;
                        usernameResponseView.alpha = 1.0;
                    }completion:^(BOOL finished) {
                        if (finished) 
                            [usernameResponseField becomeFirstResponder];
                    }];
                }];
            }];
        }
    }];
}

-(void)infoCollection {
    UIView *hiView = [self hiView];
    UIView *requestEmailView = [self requestEmailView];
    emailResponseView = [self emailResponseView];
    [self.view addSubview:hiView];
    [self.view addSubview:requestEmailView];
    [self.view addSubview:emailResponseView];
    [hiView release];
    [emailResponseView release];
    [requestEmailView release];
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationCurveEaseInOut animations:^{
        usernameResponseView.alpha = 0.0;
        hiView.alpha = 1.0;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:2.0 delay:2.0 options:UIViewAnimationCurveEaseInOut animations:^ {
            hiView.alpha = 0.0;
            requestEmailView.alpha = 1.0;
        }completion:^(BOOL finished) {
            if (finished) 
                [UIView animateWithDuration:2.0 delay:2.0 options:UIViewAnimationCurveEaseInOut animations:^{
                    requestEmailView.alpha = 0.0;
                    emailResponseView.alpha = 1.0;
                }completion:^(BOOL finished) {
                    if (finished) 
                        [emailResponseField becomeFirstResponder];
                }];
        }];
    }];
}

-(void)tutorial {
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationCurveEaseInOut animations:^ {
        emailResponseView.alpha = 0.0;
    }completion:^(BOOL finished) {
        
    }];
}

-(UIView *)greetingView {
    UIView *greetingView = [[UIView alloc]initWithFrame:CGRectMake(175.0, 100.0, 146.0, 96.0)];
    UIImage *bubble1 = [UIImage imageNamed:@"bubble1.png"];
    UIImageView *bubble1View = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 146.0, 96.0)];
    bubble1View.image = bubble1;
    [greetingView addSubview:bubble1View];
    [bubble1View release];
    UILabel *greetingLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 20.0, 126.0, 30.0)];
    greetingLabel.backgroundColor = [UIColor clearColor];
    greetingLabel.textAlignment = UITextAlignmentCenter;
    greetingLabel.font = [UIFont fontWithName:[personality valueForKey:@"font"] size:30.0];
    greetingLabel.text = [personality valueForKey:@"greeting"];
    [greetingView addSubview:greetingLabel];
    [greetingLabel release];
    greetingView.alpha = 0.0;
    return greetingView;
}

-(UIView *)intro1View {
    UIView *intro1View = [[UIView alloc]initWithFrame:CGRectMake(2.0, 150.0, 290.0, 150.0)];
    UIImage *intro1Image = [UIImage imageNamed:@"bubble2l.png"];
    UIImageView *intro1ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 290.0, 150.0)];
    intro1ImageView.image = intro1Image;
    [intro1View addSubview:intro1ImageView];
    [intro1ImageView release];
    UILabel *intro1Label = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 20.0, 270.0, 60.0)];
    intro1Label.adjustsFontSizeToFitWidth = YES;
    intro1Label.minimumFontSize = 10.0;
    intro1Label.backgroundColor = [UIColor clearColor];
    intro1Label.textAlignment = UITextAlignmentCenter;
    intro1Label.font = [UIFont fontWithName:[personality valueForKey:@"font"] size:20.0];
    intro1Label.text = [personality valueForKey:@"intro1"];
    [intro1View addSubview:intro1Label];
    [intro1Label release];
    intro1View.alpha = 0.0;
    return intro1View;
}

-(UIView *)intro2View {
    UIView *intro2View = [[UIView alloc]initWithFrame:CGRectMake(20.0, 20.0, 290.0, 175.0)];
    UIImage *intro2Image = [UIImage imageNamed:@"bubble2r.png"];
    UIImageView *intro2ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 290.0, 175.0)];
    intro2ImageView.image = intro2Image;
    [intro2View addSubview:intro2ImageView];
    [intro2ImageView release];
    UILabel *intro2Label = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 15.0, 270.0, 80.0)];
    intro2Label.backgroundColor = [UIColor clearColor];
    intro2Label.adjustsFontSizeToFitWidth = YES;
    intro2Label.minimumFontSize = 10.0;
    intro2Label.numberOfLines = 2;
    intro2Label.textAlignment = UITextAlignmentCenter;
    intro2Label.font = [UIFont fontWithName:[personality valueForKey:@"font"] size:20.0];
    intro2Label.text = [NSString stringWithFormat:@"%@ %@...\nWhat's yours?",[personality valueForKey:@"intro2"],name];
    [intro2View addSubview:intro2Label];
    [intro2Label release];
    intro2View.alpha = 0.0;
    return intro2View;
}

-(UIView *)usernameResponseView {
    usernameResponseView = [[UIView alloc]initWithFrame:CGRectMake(20.0, 100.0, 300.0, 150.0)];
    UIImage *usernameResponseImage = [UIImage imageNamed:@"response1.png"];
    UIImageView *usernameResponseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300.0, 150.0)];
    usernameResponseImageView.image = usernameResponseImage;
    [usernameResponseView addSubview:usernameResponseImageView];
    [usernameResponseImageView release];
    usernameResponseField = [[UITextField alloc]initWithFrame:CGRectMake(20.0, 40.0, 260.0, 33.0)];
    usernameResponseField.delegate = self;
    usernameResponseField.returnKeyType = UIReturnKeyGo;
    usernameResponseField.placeholder = @"What should I call you?";
    [usernameResponseView addSubview:usernameResponseField];
    [usernameResponseField release];
    usernameResponseView.alpha = 0.0;
    return usernameResponseView;
}

-(UIView *)hiView {
    UIView *hiView = [[UIView alloc]initWithFrame:CGRectMake(20.0, 20.0, 290.0, 175.0)];
    UIImage *hiImage = [UIImage imageNamed:@"bubble2r.png"];
    UIImageView *hiImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 290.0, 175.0)];
    hiImageView.image = hiImage;
    [hiView addSubview:hiImageView];
    [hiImageView release];
    UILabel *hiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 15.0, 270.0, 80.0)];
    hiLabel.backgroundColor = [UIColor clearColor];
    hiLabel.adjustsFontSizeToFitWidth = YES;
    hiLabel.minimumFontSize = 10.0;
    hiLabel.numberOfLines = 2;
    hiLabel.textAlignment = UITextAlignmentCenter;
    hiLabel.font = [UIFont fontWithName:[personality valueForKey:@"font"] size:20.0];
    hiLabel.text = [NSString stringWithFormat:@"%@ %@!\n%@",[personality objectForKey:@"hi1"],username,[personality objectForKey:@"hi2"]];
    [hiView addSubview:hiLabel];
    [hiLabel release];
    hiView.alpha = 0.0;
    return hiView;
}

-(UIView *)requestEmailView {
    UIView *requestEmailView = [[UIView alloc]initWithFrame:CGRectMake(2.0, 150.0, 290.0, 150.0)];
    UIImage *requestEmailImage = [UIImage imageNamed:@"bubble2l.png"];
    UIImageView *requestEmailImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 290.0, 150.0)];
    requestEmailImageView.image = requestEmailImage;
    [requestEmailView addSubview:requestEmailImageView];
    [requestEmailImageView release];
    UILabel *requestEmailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 20.0, 270.0, 60.0)];
    requestEmailLabel.adjustsFontSizeToFitWidth = YES;
    requestEmailLabel.minimumFontSize = 10.0;
    requestEmailLabel.backgroundColor = [UIColor clearColor];
    requestEmailLabel.textAlignment = UITextAlignmentCenter;
    requestEmailLabel.font = [UIFont fontWithName:[personality valueForKey:@"font"] size:20.0];
    requestEmailLabel.text = [personality valueForKey:@"requestEmail"];
    [requestEmailView addSubview:requestEmailLabel];
    [requestEmailLabel release];
    requestEmailView.alpha = 0.0;
    return requestEmailView;
}

-(UIView *)emailResponseView {
    emailResponseView = [[UIView alloc]initWithFrame:CGRectMake(20.0, 100.0, 300.0, 150.0)];
    UIImage *emailResponseImage = [UIImage imageNamed:@"response1.png"];
    UIImageView *emailResponseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300.0, 150.0)];
    emailResponseImageView.image = emailResponseImage;
    [emailResponseView addSubview:emailResponseImageView];
    [emailResponseImageView release];
    emailResponseField = [[UITextField alloc]initWithFrame:CGRectMake(20.0, 40.0, 260.0, 33.0)];
    emailResponseField.delegate = self;
    emailResponseField.returnKeyType = UIReturnKeyGo;
    emailResponseField.keyboardType = UIKeyboardTypeEmailAddress;
    emailResponseField.placeholder = @"What is your email address?";
    [emailResponseView addSubview:emailResponseField];
    [emailResponseField release];
    emailResponseView.alpha = 0.0;
    return emailResponseView;
}

-(void)submitUsername {
    foofarawAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSError *error;
    NSManagedObject *account = [[context executeFetchRequest:request error:&error] objectAtIndex:0];
    [request release];    
    [account setValue:usernameResponseField.text forKey:@"username"];
    username = [[NSString alloc]initWithString:usernameResponseField.text];
	[context save:&error];
    [self infoCollection];
}

-(void)submitEmail {
    foofarawAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSError *error;
    NSManagedObject *account = [[context executeFetchRequest:request error:&error] objectAtIndex:0];
    [request release];    
    [account setValue:emailResponseField.text forKey:@"email"];
	[context save:&error];
    [self tutorial];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text length]>0) {
        if (textField==usernameResponseField) {
            [self submitUsername];
        } else if (textField==emailResponseField) {
            [self submitEmail];
        }
        [textField resignFirstResponder];
        return YES;
    } else {
        return NO;
    }
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
    [name release];
    [personality release];
    [username release];
}

@end
