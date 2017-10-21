    //
//  OC_GLMain.m
//  GameProto
//
//  Created by n-naka on 2017/09/23.
//  Copyright © 2017年 n-naka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OC_GLMain.h"
#import "GLMain.h"

@implementation OC_GLMain {
    GLMain *mGLMain;
}

-(id)init {
    self = [super init];
    mGLMain = &GLMain::instance();
    mGLMain->init(1920, 1080);
    return self;
}

- (id) initWithWidth:(int)width height:(int)height {
    if (self = [super init]) {
        mGLMain = &GLMain::instance();
        mGLMain->init(width, height);
    }
    return self;
}

-(void)dealloc {
    mGLMain = nullptr;
}

-(void)draw {
    if (mGLMain) {
        mGLMain->draw();
    }
}

-(void)setImage:(int)width height:(int)height bytesPerPixel:(int)bytesPerPixel data:(const uint8_t*)data {
    if (mGLMain) {
        mGLMain->setImage(width, height, bytesPerPixel, data);
    }
}

@end
