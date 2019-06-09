#import <Foundation/Foundation.h>
#import "React/RCTViewManager.h"

@interface RCT_EXTERN_MODULE(CustomPlayerViewManager, RCTViewManager)
  RCT_EXPORT_VIEW_PROPERTY(autoPlay, NSString)
  RCT_EXPORT_VIEW_PROPERTY(zoom, NSNumber)
@end
