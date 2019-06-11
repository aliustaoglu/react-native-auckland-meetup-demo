#import <Foundation/Foundation.h>
#import "React/RCTViewManager.h"

@interface RCT_EXTERN_MODULE(CustomPlayer, RCTViewManager)
RCT_EXPORT_VIEW_PROPERTY(autoPlay, BOOL)
RCT_EXPORT_VIEW_PROPERTY(filename, NSString)
RCT_EXTERN_METHOD(togglePlay:(nonnull NSNumber *)node)
RCT_EXTERN_METHOD(changeVideo:(nonnull NSNumber *)node
                  url:(nonnull NSString *)url
                  extraParam:(nonnull NSString *)extraParam)
RCT_EXPORT_VIEW_PROPERTY(onVideoFinished, RCTDirectEventBlock)
@end
