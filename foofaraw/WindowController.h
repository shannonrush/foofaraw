//
//  WindowController.h
//  foofaraw
//
//  Created by Shannon Rush on 5/25/11.
//  Copyright 2011 Rush Devo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>



@interface WindowController : UIViewController {
    AVCaptureSession *captureSession;
    AVCaptureVideoPreviewLayer *previewLayer;
}

-(void)initVideo;

@end
