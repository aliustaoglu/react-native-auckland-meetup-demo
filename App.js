import React, { Component } from 'react';
import { StyleSheet, Text, View, requireNativeComponent } from 'react-native';

const CustomPlayer = requireNativeComponent('CustomPlayer')

export default class App extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text>Welcome to React Native!</Text>
        <CustomPlayer 
          autoPlay={true} 
          filename="http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
          style={{ width: 300, height: 300 }} />
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
