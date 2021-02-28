import React, { useState, useEffect } from 'react';
import { SafeAreaView, StyleSheet, View, Text } from 'react-native';
import { Colors } from 'react-native/Libraries/NewAppScreen';
import NetworkListener from 'react-native-network-state-listener';


const App = () => {
  const [networkStatus, setNetworkStatus] = useState(true);

  useEffect(() => {
    (async () => {
      await NetworkListener.startListener();

      NetworkListener.onNetworkStateChange((status) => {
        console.log("+===STATUS: ", status);
        setNetworkStatus(status);
      })
    })();

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
