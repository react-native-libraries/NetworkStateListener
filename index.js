import {
    DeviceEventEmitter,
    NativeModules
} from 'react-native';

const { RNNetworkStateListener } = NativeModules;

class NetworkListener {

    constructor() {
        this.status = false;
    }

    //=====================================================================================
    /** Starts the network state listener
     * 
     */
    startListener() {
            return RNNetworkStateListener.startNetworkWatching();
    }

    //=====================================================================================
    /**Stops the network state listener, it must be 
     * called when the component unmount
     */
    stopListener() {
        this.networkListener.remove();
    }

    //=====================================================================================
    /** Defines the callback for changes in the state of the network
     * @param {function} callback 
     * @returns {boolean} returns true if there is a connection, false otherwise 
     */
    onNetworkStateChange(callback) {
        this.networkListener = DeviceEventEmitter.addListener(
            'isConnected',
            (status) => {
                callback(status.isConnected);
            },
        );
    }

}

export default new NetworkListener();
