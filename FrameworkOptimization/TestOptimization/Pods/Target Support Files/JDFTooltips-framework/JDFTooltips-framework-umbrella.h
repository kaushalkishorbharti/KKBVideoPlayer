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

#import "JDFSequentialTooltipManager.h"
#import "JDFTooltipManager.h"
#import "JDFTooltips.h"
#import "JDFTooltipView.h"
#import "UILabel+JDFTooltips.h"
#import "UIView+JDFTooltips.h"

FOUNDATION_EXPORT double JDFTooltipsVersionNumber;
FOUNDATION_EXPORT const unsigned char JDFTooltipsVersionString[];

