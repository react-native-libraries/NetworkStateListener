package com.RNNetworkStateListener.NativeModules;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkCapabilities;
import android.os.Build;
import android.util.Log;

import androidx.annotation.RequiresApi;

public class CheckNetworkState {
    private Context context;

    public CheckNetworkState(Context context) {
        this.context = context;
    }

    @RequiresApi(api = Build.VERSION_CODES.N)
    public void registerNetworkCallback() {
        try {
            ConnectivityManager connectivityManager = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);

            NetworkCapabilities capabilities = connectivityManager.getNetworkCapabilities(connectivityManager.getActiveNetwork());
            if (capabilities == null) {
                NetworkModule.getInstance().createEventData(false);
            }

            connectivityManager.registerDefaultNetworkCallback(new ConnectivityManager.NetworkCallback() {
                @Override
                public void onAvailable(Network network) {
                    Log.d("NETWORKSTATE", "AVAILABLE");
                    NetworkModule.getInstance().createEventData(true);
                }

                @Override
                public void onLost(Network network) {
                    Log.d("NETWORKSTATE", "LOST");
                    NetworkModule.getInstance().createEventData(false);
                }
            });
            NetworkModule.getInstance().createEventData(false);
        } catch (Exception e) {
            Log.d("NETWORKSTATE", "ERROR: " + e.getMessage());
            NetworkModule.getInstance().createEventData(false);
        }
    }
}
