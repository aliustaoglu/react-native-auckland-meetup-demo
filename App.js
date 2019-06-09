import React, { Component } from 'react';
import { StyleSheet, Text, View, requireNativeComponent } from 'react-native';

const CustomPlayer = requireNativeComponent('CustomPlayerView')

export default class App extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text>Welcome to React Native!</Text>
        <CustomPlayer autoPlay="no" style={{ width: 300, height: 300 }} />
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
