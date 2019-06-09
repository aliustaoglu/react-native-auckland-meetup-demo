import Foundation
import UIKit
import PlayerKit
import AVFoundation

@objc(CustomPlayer)
class CustomPlayer: RCTViewManager {

  
  override func view() -> UIView! {
    return PlayerView(frame: CGRect(x:0, y:0, width: 300, height: 300))
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
