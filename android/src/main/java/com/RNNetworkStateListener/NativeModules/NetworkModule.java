package com.RNNetworkStateListener.NativeModules;

import android.content.Context;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import java.util.HashMap;
import java.util.Map;

public class NetworkModule extends ReactContextBaseJavaModule {
    private static final String MODULE_NAME = "RNNetworkStateListener";
    private static final String EVENT_NETWORK_NAME = "isConnected";
    private CheckNetworkState checkNetworkState;
    private static NetworkModule instance;
    private static Context context;

    //==============================================================================================
    public NetworkModule(ReactApplicationContext reactContext) {
        super(reactContext);
        checkNetworkState = new CheckNetworkState(reactContext);
        context = reactContext;
    }

    //==============================================================================================
    private NetworkModule() {
        super((ReactApplicationContext) context);
        checkNetworkState = new CheckNetworkState(context);
    }

    //==============================================================================================
    public static NetworkModule getInstance() {
        if (instance == null) {
            instance = new NetworkModule();
        }
        return instance;
    }

    //==============================================================================================
    @RequiresApi(api = Build.VERSION_CODES.N)
    @ReactMethod
    public void startNetworkWatching() {
        Log.d("NETWORKSTATE", "CALLLED");
        checkNetworkState.registerNetworkCallback();
    }

    //==============================================================================================
    @Nullable
    @Override
    public Map<String, Object> getConstants() {
        final Map<String, Object> constants = new HashMap<>();

        constants.put(EVENT_NETWORK_NAME, EVENT_NETWORK_NAME);

        return constants;
    }

    //==============================================================================================
    public void createEventData(boolean isConnected) {
        WritableMap params = Arguments.createMap();
        params.putBoolean("isConnected", isConnected);
        sendEventToJS((ReactContext) context, EVENT_NETWORK_NAME, params);
    }

    //==============================================================================================
    private void sendEventToJS(ReactContext reactContext, String eventName, @Nullable WritableMap params) {
        reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit(eventName, params);
    }

    //==============================================================================================
    @NonNull
    @Override
    public String getName() {
        return MODULE_NAME;
    }
}
