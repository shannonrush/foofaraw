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

@interface SetupController : BaseController <UITextFieldDelegate> {
    AVCaptureSession *captureSession;
    AVCaptureVideoPreviewLayer *previewLayer;
    NSString *name;
    NSDictionary *personality;
    NSString *username;
    
    UIView *usernameResponseView;
    UITextField *usernameResponseField;
    UIView *emailResponseView;
    UITextField *emailResponseField;
    
}

-(void)initApp;

-(void)introduction;
-(void)infoCollection;
-(void)tutorial;

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
