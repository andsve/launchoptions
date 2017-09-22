#define DLIB_LOG_DOMAIN "launchoptions_utils"

#include <dmsdk/sdk.h>
#include "launchoptions.h"

#if defined(DM_PLATFORM_OSX)
#include <AppKit/AppKit.h>
#include <CoreGraphics/CoreGraphics.h>

static NSWindow* window = nil;

void launchoptions_platform::Init()
{
    window = dmGraphics::GetNativeOSXNSWindow();
}

void launchoptions_platform::HideWindow()
{
    [window setIsVisible:NO];
}

void launchoptions_platform::ShowWindow()
{
    [window setIsVisible:YES];
}

void launchoptions_platform::MakeDialog()
{
    [[window standardWindowButton:NSWindowCloseButton] setHidden:YES];
    [[window standardWindowButton:NSWindowZoomButton] setHidden:YES];
    [[window standardWindowButton:NSWindowMiniaturizeButton] setHidden:YES];
    [window setStyleMask:[window styleMask] & ~NSResizableWindowMask];
}

void launchoptions_platform::SetWindowSize(float width, float height)
{
    NSRect frame = [window frame];
    frame.origin.x += width;
    frame.origin.y += height;
    frame.size.width = width;
    frame.size.height = height;
    [window setFrame:frame display:YES];
}

#endif
