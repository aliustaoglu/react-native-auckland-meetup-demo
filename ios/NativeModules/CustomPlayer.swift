import Foundation
import UIKit
import PlayerKit
import AVFoundation

@objc(CustomPlayer)
class CustomPlayer: RCTViewManager {
  var playerView: PlayerView!
  
  override func view() -> UIView! {
    playerView = PlayerView(frame: CGRect(x:0, y:0, width: 300, height: 300))
    return playerView
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  @objc public func togglePlay(_ node:NSNumber){
    playerView.togglePlay()
  }

  @objc public func changeVideo(_ node:NSNumber, url:NSString, extraParam:NSString){
    playerView.changeVideo(url: url, extraParam: extraParam)
  }
  
}
