#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CALayer+Image.h"
#import "NanoFrame.h"
#import "UIColor+NanoFrame.h"
#import "UIImage+NanoFrame.h"
#import "UIScreen+NanoFrame.h"
#import "UIView+NanoFrame.h"

FOUNDATION_EXPORT double NanoFrameVersionNumber;
FOUNDATION_EXPORT const unsigned char NanoFrameVersionString[];

