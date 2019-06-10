#import <Foundation/Foundation.h>
#import "React/RCTViewManager.h"

@interface RCT_EXTERN_MODULE(CustomPlayer, RCTViewManager)
  RCT_EXPORT_VIEW_PROPERTY(autoPlay, BOOL)
  RCT_EXPORT_VIEW_PROPERTY(filename, NSString)
@end
