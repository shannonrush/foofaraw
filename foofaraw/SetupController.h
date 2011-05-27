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

@interface SetupController : BaseController {
    AVCaptureSession *captureSession;
    AVCaptureVideoPreviewLayer *previewLayer;
}

@end
