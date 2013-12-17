/*
    Generated for Injection of class implementations
*/

#define INJECTION_NOIMPL
#define INJECTION_BUNDLE InjectionBundle2

#import "/Users/xcode/Library/Application Support/Developer/Shared/Xcode/Plug-ins/InjectionPlugin5.xcplugin/Contents/Resources/BundleInjection.h"

#undef _instatic
#define _instatic extern

#undef _inglobal
#define _inglobal extern

#undef _inval
#define _inval( _val... ) /* = _val */

#import "BundleContents.h"

#import "/Users/xcode/wanax/oc/GooGuuHD/GooGuuHD/RightDetail/UserSetting/ClientActionVC/ClientLoginViewController.m"


@interface InjectionBundle2 : NSObject
@end
@implementation InjectionBundle2

+ (void)load {
    Class bundleInjection = NSClassFromString(@"BundleInjection");
    extern Class OBJC_CLASS_$_ClientLoginViewController;
	[bundleInjection loadedClass:INJECTION_BRIDGE(Class)(void *)&OBJC_CLASS_$_ClientLoginViewController notify:4];
    [bundleInjection loadedNotify:4];
}

@end

