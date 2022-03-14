import React from "react";
import { NativeModules, Platform, NativeEventEmitter } from "react-native";

class NetworkListener {
  constructor() {
    this.status = false;
    console.log(NativeModules);
    console.log(NativeModules.RNNetworkStateListener);
    // this.eventEmitter =
    //   Platform.OS == "android"
    //     ? DeviceEventEmitter
    //     : new NativeEventEmitter(RNNetworkStateListener);
  }
  //=====================================================================================
  /** Starts the network state listener
   *
   */
  startListener() {
    // return RNNetworkStateListener.startNetworkWatching();
  }

  //=====================================================================================
  /**Stops the network state listener, it must be
   * called when the component unmount
   */
  stopListener() {
    // this.networkListener.remove();
  }

  //=====================================================================================
  /** Defines the callback for changes in the state of the network
   * @param {function} callback
   * @returns {boolean} returns true if there is a connection, false otherwise
   */
  onNetworkStateChange(callback) {
    // this.networkListener = this.eventEmitter.addListener(
    //   "isConnected",
    //   (status) => {
    //     callback(status.isConnected);
    //   }
    // );
  }
}

export default new NetworkListener();
