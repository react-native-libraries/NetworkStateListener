![npm (scoped)](https://img.shields.io/npm/v/@react_native_libraries/react-native-network-state-listener)
![npm](https://img.shields.io/npm/dw/@react_native_libraries/react-native-network-state-listener)

# react-native-network-state-listener
![banner](https://raw.githubusercontent.com/ReactNativeLibraries/NetworkStateListener/master/assets/banner.png)

## About

The best way to check the internet status on the user's device.

This library makes it possible to check the connection status of the user's device in real-time, whenever the connection undergoes any change, it is verified, if this change means a loss of connection or the availability of connection, an event is triggered with the current connection status of the device.



## Example
![example](https://github.com/ReactNativeLibraries/NetworkStateListener/blob/master/assets/networkStateListener.gif?raw=true)


## Installation

If using yarn:

```
yarn add @react_native_libraries/react-native-network-state-listener
```

If using npm:

```
npm i @react_native_libraries/react-native-network-state-listener
```

## Usage

```javascript
import React, { useState, useEffect } from 'react';
import { SafeAreaView, StyleSheet, View, Text } from 'react-native';
import { Colors } from 'react-native/Libraries/NewAppScreen';

//Add Import
import NetworkListener from '@react_native_libraries/react-native-network-state-listener';

const App = () => {
  const [networkStatus, setNetworkStatus] = useState(true);

  useEffect(() => {
    (async () => {
      //Start listener
      await NetworkListener.startListener();
        
      //Set callback for changes in network status 
      NetworkListener.onNetworkStateChange((status) => {
        console.log("+===STATUS: ", status);
        setNetworkStatus(status);
      })
    })();
    
    //Remove listener when app destroy
    return () => NetworkListener.stopListener();
  }, []);

  return (
      <SafeAreaView style={styles.sectionContainer}>
          <Text style={styles.sectionTitle}>Network Status:</Text>
          {networkStatus && <Text style={styles.sectionTitle}>Connected</Text>}
          {!networkStatus && <Text style={styles.sectionTitle}>Disconnected</Text>}
      </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  sectionContainer: {
    flex: 1,
    paddingHorizontal: 24,
    justifyContent: 'center',
  },
  sectionTitle: {
    textAlign: 'center',
    fontSize: 24,
    fontWeight: '600',
    color: Colors.black,
  }
});

export default App;
```

## Documentation
### Network State Listener

| Name | Description |
|------------------|--------------------------------------------------------------------------|
| startListener | starts the network state listener. |
| stopListener | Stops the network state listener, it must be called when the component unmount. |
| onNetworkStateChange | Defines the callback for changes in the state of the network, returns true if there is a connection, false otherwise. |

## Contributing
Pull requests are always welcome! Feel free to open a new GitHub issue for any changes that can be made.

**Working on your first Pull Request?** You can learn how from this *free* series [How to Contribute to an Open Source Project on GitHub](https://egghead.io/series/how-to-contribute-to-an-open-source-project-on-github)

## Author
Kalebe Samuel

## License
[MIT](./LICENSE)

___

  