
# react-native-native-location-foreground-service

## Getting started

`$ npm install react-native-native-location-foreground-service --save`

### Mostly automatic installation

`$ react-native link react-native-native-location-foreground-service`

### Manual installation


#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNNativeLocationForegroundServicePackage;` to the imports at the top of the file
  - Add `new RNNativeLocationForegroundServicePackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-native-location-foreground-service'
  	project(':react-native-native-location-foreground-service').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-native-location-foreground-service/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-native-location-foreground-service')
  	```


## Usage
```javascript
import RNNativeLocationForegroundService from 'react-native-native-location-foreground-service';

// TODO: What to do with the module?
RNNativeLocationForegroundService;
```
  