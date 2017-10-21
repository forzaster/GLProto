//
//  OC_GLMain.h
//  GameProto
//
//  Created by n-naka on 2017/09/23.
//  Copyright © 2017年 n-naka. All rights reserved.
//

#ifndef OC_GLMain_h
#define OC_GLMain_h

#import <Foundation/Foundation.h>

@interface OC_GLMain : NSObject
-(void)draw;
-(void)setImage:(int)width height:(int)height bytesPerPixel:(int)bytesPerPixel data:(const uint8_t*)data;
-(id)initWithWidth:(int)width height:(int)height;
@end

#endif /* OC_GLMain_h */
