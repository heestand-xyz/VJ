#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "OSCClient.h"
#import "OSCKit.h"
#import "OSCMessage.h"
#import "OSCProtocol.h"
#import "OSCServer.h"

FOUNDATION_EXPORT double OSCKitVersionNumber;
FOUNDATION_EXPORT const unsigned char OSCKitVersionString[];

