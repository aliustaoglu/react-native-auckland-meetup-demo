import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  requireNativeComponent,
  Button,
  UIManager,
  findNodeHandle,
  TextInput
} from 'react-native';

const CustomPlayer = requireNativeComponent('CustomPlayer');

const playerRef = React.createRef();

export default class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4'
    };
  }

  componentDidMount() {
    this.nativeCommands = UIManager.getViewManagerConfig('CustomPlayer').Commands;
    console.log(this.nativeCommands);
  }

  render() {
    return (
      <View style={styles.container}>
        <Text>Welcome to React Native!</Text>
        <CustomPlayer
          autoPlay={false}
          filename="http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
          style={{ width: 300, height: 300 }}
          ref={playerRef}
          onVideoFinished={e => {
            alert(e.nativeEvent.message);
            console.log(e.nativeEvent);
          }}
        />
        <Button
          title="Play/pause"
          onPress={() => {
            const playerNodeHandle = findNodeHandle(playerRef.current);
            UIManager.dispatchViewManagerCommand(playerNodeHandle, this.nativeCommands.togglePlay, []);
          }}
        />
        <TextInput
          style={{ width: 300, height: 40, backgroundColor: '#ddd' }}
          value={this.state.videoUrl}
          onChange={e => this.setState({ videoUrl: e.nativeEvent.text })}
        />
        <Button
          title="Change video"
          onPress={() => {
            const playerNodeHandle = findNodeHandle(playerRef.current);
            UIManager.dispatchViewManagerCommand(playerNodeHandle, this.nativeCommands.changeVideo, [
              this.state.videoUrl,
              'bar'
            ]);
          }}
        />
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
