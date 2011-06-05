//
//  SetupController.h
//  foofaraw
//
//  Created by Shannon Rush on 5/26/11.
//  Copyright 2011 Rush Devo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "BaseController.h"
#import <CoreMotion/CoreMotion.h>
#import "OpenGLView.h"

@class OpenGLTexture3D;


@interface SetupController : BaseController <UITextFieldDelegate, GLViewDelegate> {
    AVCaptureSession *captureSession;
    AVCaptureVideoPreviewLayer *previewLayer;
    NSString *name;
    NSDictionary *personality;
    NSString *username;
    
    UIView *usernameResponseView;
    UITextField *usernameResponseField;
    UIView *emailResponseView;
    UITextField *emailResponseField;
    UIView *foofView;
    
    CMMotionManager *motionManager;
    NSOperationQueue *motionQueue;
    CMAttitude *referenceAttitude;
    
    OpenGLView *glView;
    OpenGLTexture3D *texture;
}

@property (nonatomic, retain) OpenGLTexture3D *texture;
@property (nonatomic, retain) IBOutlet OpenGLView *glView;



-(void)initApp;

-(void)introduction;
-(void)infoCollection;
-(void)tutorial;
-(void)addFoof;
-(void)add3DFoof;
-(void)processMotion:(CMDeviceMotion *)motion withError:(NSError *)error;

-(UIView *)greetingView;
-(UIView *)intro1View;
-(UIView *)intro2View;
-(UIView *)usernameResponseView;
-(UIView *)hiView;
-(UIView *)requestEmailView;
-(UIView *)emailResponseView;
-(void)submitUsername;
-(void)submitEmail;

@end
