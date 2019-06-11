import Foundation
import UIKit
import PlayerKit
import AVFoundation

class PlayerView: UIView {
  
  @objc var autoPlay: Bool = false
  @objc var filename: NSString = ""
  var player: RegularPlayer!
  
  override init(frame:CGRect) {
    super.init(frame: frame)
    player = RegularPlayer()
    player.view.frame = frame
    self.addSubview(player.view)
  }
  
  public func togglePlay(){
    if (self.player.playing) {
      self.player.pause()
    } else {
      self.player.play()
    }
  }
  
  public func changeVideo(url:NSString, extraParam:NSString){
    player.set(AVURLAsset(url: URL.init(string: url as String)!))
    player.play()
  }
  
  override func didSetProps(_ changedProps: [String]!) {
    player.set(AVURLAsset(url: URL.init(string: self.filename as String)!))
    if (self.autoPlay == true){
      player.play()
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if (self.player.playing) {
      self.player.pause()
    } else {
      self.player.play()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
