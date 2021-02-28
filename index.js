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
    startListener() {
            return RNNetworkStateListener.startNetworkWatching();
    }

    //=====================================================================================
    stopListener() {
        this.networkListener.remove();
    }

    //=====================================================================================
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
