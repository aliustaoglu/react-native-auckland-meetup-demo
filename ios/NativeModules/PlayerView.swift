import Foundation
import UIKit
import PlayerKit
import AVFoundation

class PlayerView: UIView {
  
  var autoPlay: Bool!
  var filename: NSString!
  var player: RegularPlayer!
  
  @objc func setAutoPlay(_ val: Bool) {
    self.autoPlay = val
    
  }
  
  @objc func setFilename(_ val:NSString){
    self.filename = val
  }
  
  override init(frame:CGRect) {
    super.init(frame: frame)
    player = RegularPlayer()
    player.view.frame = frame
    self.addSubview(player.view)
  }
  
  override func didSetProps(_ changedProps: [String]!) {
    player.set(AVURLAsset(url: URL.init(string: self.filename as String)!))
    if (self.autoPlay == true){
      player.play()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
