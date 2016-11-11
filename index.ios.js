/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    NativeModules
} from 'react-native';

import { GestureView } from 'react-native-gestureunlock';

export default class GestureUnlockDemo extends Component {
    constructor() {
        super()
        this.state = {
            passcodeContent: 'content as a test for call from component'
        }
    }

    render() {
        var gestureViewSettings = (<GestureView style={styles.gesture}
                                                nodeScale={74} colCount={3}
                                                backgroundImgName="Home_refresh_bg" onGestureComplete={
                                                (result)=>this.setState({
                                                passcodeContent: result? result : 'The return value not found'
                                                })} nodeThemes={{nodeNormal: 'gesture_node_normal'
                                                                }}/>)
                return (
                    <View style={styles.container}>
                        {gestureViewSettings}
                        <Text style={styles.passcode}>
                            {this.state.passcodeContent}
                        </Text>
                    </View>
                );
    }
}
const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        backgroundColor: 'white',
    },
    gesture: {
        flex: 1,
        justifyContent: 'center',
    },
    passcode: {
        fontSize: 16,
        textAlign: 'center',
        margin: 10,
        color: 'black'
    },
});

AppRegistry.registerComponent('GestureUnlockDemo', () => GestureUnlockDemo);
