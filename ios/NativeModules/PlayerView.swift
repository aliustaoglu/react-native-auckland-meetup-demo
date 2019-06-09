import Foundation
import UIKit
import PlayerKit
import AVFoundation

class PlayerView: UIView {
  
  var autoPlay: NSString!
  var player: RegularPlayer!
  
  @objc func setAutoPlay(_ val: NSString) {
    self.autoPlay = val
    if (self.autoPlay == "yes"){
      player.play()
    }
  }
  
  
  var lbl: UILabel = UILabel()
  
  override init(frame:CGRect) {
    super.init(frame: frame)
    player = RegularPlayer()
    player.set(AVURLAsset(url: URL.init(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!))
    player.view.frame = frame
    self.addSubview(player.view)
    
  }

  

  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
