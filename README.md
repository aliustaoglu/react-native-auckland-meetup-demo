# Using Native iOS Libraries in React Native

This is a demo application that was used for a meetup event:

https://www.meetup.com/Auckland-React-Native-Meetup/events/wzdfzqyzjbrb/

This application uses CocoaPods

Please refer to CocoaPods(1) https://guides.cocoapods.org/using/getting-started.html to make the installation

After you've installed Cocoapods to your machine, we need to set it up for our project.

```sh
cd ios
pod init
pod install
```

You may get below error. This is a bug and it is actually declared twice. Just remove one of the instances from `ios/Podfile`. Then re-run pod install.

```
$ pod install
Analyzing dependencies
[!] The target `rnAKLMeetupDemo-tvOSTests` is declared multiple times.
```

![pod install](https://raw.githubusercontent.com/aliustaoglu/react-native-auckland-meetup-demo/master/pod-install.png)

As shown in the picture above, we don't have any dependencies yet.

I want to implement Vimeo's PlayerKit component:

https://cocoapods.org/pods/PlayerKit

Let's add below to `ios/Podfile` under the line `# Pods for rnAKLMeetupDemo`

> pod "PlayerKit"

and run `pod install again`

It should print below message this time

```
Pod installation complete! There is 1 dependency from the Podfile and 1 total pod installed.
```

Now if you open Xcode, under Pods you will see PlayerKit. Run the application to see the classic "Welcome to React Native" message, so we know that everything compiles.

Under rnAKLMeetupDemo:
1. Create NativeModules directory (we don't have to but I want to be a bit tidy)
2. Add a new Swift file called CustomPlayer
3. Xcode will ask you to create a bridging header. Say yes to it. You can change the name but default name is also OK. I used the default name
4. Bridging header will only be created once. Next time you want to add another Swift file you will not need and should not create another bridging header.

![pod install](https://raw.githubusercontent.com/aliustaoglu/react-native-auckland-meetup-demo/master/add-swift-and-bridge.gif)

React Native does not work with Swift-only setup yet. So, we need to create Objective-C files just to export our Swift files. Don't worry, Objective C files will be minimal. You can think them as interfaces to the implementation we do in Swift.

Under the same folder (NativeModules), this time create an Objective-C file called 

![create objective c](https://raw.githubusercontent.com/aliustaoglu/react-native-auckland-meetup-demo/master/create-objective-c.png)

![custom player](https://raw.githubusercontent.com/aliustaoglu/react-native-auckland-meetup-demo/master/customplayer.m.png)

Now we have 3 files:

1. CustomPlayer.swift
2. rnAKLMeetupDemo-Bridging-Header.h
3. CustomPlayer.m

Let's first update bridging header with the below imports that is needed by Swift file

```c
#import "React/RCTBridgeModule.h"
#import "React/RCTViewManager.h"
```

Then update CustomPlayer.swift to use PlayerKit

```swift
import Foundation
import UIKit
import PlayerKit
import AVFoundation

@objc(CustomPlayer)
class CustomPlayer: RCTViewManager {
  
  override func view() -> UIView! {
    let player = RegularPlayer()
    player.set(AVURLAsset(url: URL.init(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!))
    return player.view
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
}

```

We need to create a class that extends RCTViewManager. This way we tell React Native that we will manage UI from the native side. JavaScript will decide when and where to render this control.

We use @objc decorator for any class, method or property we want to export to JavaScript. But before going to JavaScript, it needs to go to Objective-C first.

Now open CustomPlayer.m to see how we export Swift class to JavaScript:

```objective-c
#import <Foundation/Foundation.h>
#import "React/RCTViewManager.h"

@interface RCT_EXTERN_MODULE(CustomPlayer, RCTViewManager)

@end

```

Here we just exported the module. You may have seen `RCT_EXPORT_MODULE` macro. That is when you use Objective-C modules only. If the module you're exporting from is a Swift class, you need to use RCT_EXPORT_MODULE instead.

So, that is it from the native side. Pretty tiny. But you can see that we only exported the module. We haven't exported or implemented any methods (pause, play, ff, rw etc.) But first I just want to see if this works:

Now go to App.js (of course in real life you may wanna use another file but for simplicity we use App.js)

```javascript
import React, { Component } from 'react';
import { StyleSheet, Text, View, requireNativeComponent } from 'react-native';

const CustomPlayer = requireNativeComponent('CustomPlayer')

export default class App extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text>Welcome to React Native!</Text>
        <CustomPlayer style={{ width: 300, height: 300 }} />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF'
  }
});

```

With requireNativeComponent, we import the UIView class from the Swift thru Objective-C. Name of the component should be what you use in the brackets of the decorator `objc(CustomPlayer)`.

We need to specify height and width to see the video player.


![player](https://raw.githubusercontent.com/aliustaoglu/react-native-auckland-meetup-demo/master/custom-player.png)

It works!

But video does not play because we did not implement anything about it. If you add player.play() before you return the view, you see it automatically plays the video.

```swift
    player.play()
    return player.view
```

But let's do this by using a prop so user can decide whether the video should autoplay or not.

```javascript
<CustomPlayer autoPlay={true} style={{ width: 300, height: 300 }} />
```

