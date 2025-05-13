#include <QWindow>
#include <QQuickWindow>
#include <QGuiApplication>
#include <QScreen>

#include "MacTitleBarTransparent.h"

#ifdef Q_OS_MAC
#include <objc/message.h>
#include <objc/runtime.h>
#import <Cocoa/Cocoa.h>
#endif

void macTitleBarTransparent(QWindow* window)
{
#ifdef Q_OS_MAC
    NSView* nsView = reinterpret_cast<NSView*>(window->winId());
    NSWindow* nsWindow = [nsView window];

    if (!nsWindow) return;

    [nsWindow setTitlebarAppearsTransparent:YES];
    [nsWindow setStyleMask:([nsWindow styleMask] | NSWindowStyleMaskFullSizeContentView)];
    [nsWindow setTitleVisibility:NSWindowTitleHidden];
    [nsWindow setMovableByWindowBackground:YES];
    [nsWindow setOpaque:NO];
    [nsWindow setBackgroundColor:[NSColor clearColor]];
#endif
}