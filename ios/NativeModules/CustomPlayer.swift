import Foundation
import UIKit
import PlayerKit
import AVFoundation

@objc(CustomPlayer)
class CustomPlayer: RCTViewManager {
  
  override func view() -> UIView! {
    let player = RegularPlayer()
    player.set(AVURLAsset(url: URL.init(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!))
    player.play()
    return player.view
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
