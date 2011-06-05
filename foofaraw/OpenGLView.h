//
//  OpenGLView.h
//  foofaraw
//
//  Created by Shannon Rush on 6/4/11.
//  Copyright 2011 Rush Devo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@protocol GLViewDelegate
- (void)drawView:(UIView *)theView;
- (void)setupView:(UIView *)theView;
@end

@interface OpenGLView : UIView {
    
@private
    
    GLint backingWidth;
    GLint backingHeight;
    
    EAGLContext *context;    
    GLuint viewRenderbuffer, viewFramebuffer;
    GLuint depthRenderbuffer;
    
    NSTimer *animationTimer;
    NSTimeInterval animationInterval;
    
    id <GLViewDelegate> delegate;
}
@property NSTimeInterval animationInterval;
@property (assign) /* weak ref */ id <GLViewDelegate> delegate;

- (void)startAnimation;
- (void)stopAnimation;
- (void)drawView;
@end
