//
//  OpenUDID.h
//  LXF_MapGuideDemo
//
//  Created by developer on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//
// Usage:
//    #include "LXF_OpenUDID.h"
//    NSString* openUDID = [LXF_OpenUDID value];
//

#define kOpenUDIDErrorNone          0
#define kOpenUDIDErrorOptedOut      1
#define kOpenUDIDErrorCompromised   2



@interface LXF_OpenUDID : NSObject 

+ (NSString*) value;
+ (NSString*) valueWithError:(NSError**)error;
+ (void) setOptOut:(BOOL)optOutValue;

@end


