package com.example.vidmate_clone_app;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.IBinder;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class ForegroundDownloadService extends Service {

    private static final String CHANNEL = "com.example.vidmate_clone_app/download_service";
    public static final String TAG = "ForegroundDownloadService";
    private static final String NOTIFICATION_CHANNEL_ID = "DownloadServiceChannel";
    private static final int NOTIFICATION_ID = 1;

    private MethodChannel methodChannel;
    private FlutterEngine flutterEngine;
    private NotificationManager notificationManager;

    @Override
    public void onCreate() {
        super.onCreate();
        Log.d(TAG, "Service onCreate");
        notificationManager = getSystemService(NotificationManager.class);
        createNotificationChannel();
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.d(TAG, "Service onStartCommand received");

        flutterEngine = FlutterEngineCache.getInstance().get("my_download_engine");
        if (flutterEngine == null) {
            Log.w(TAG, "Flutter engine not found in cache, creating a new one.");
            flutterEngine = new FlutterEngine(this);
            FlutterEngineCache.getInstance().put("my_download_engine", flutterEngine);
        }

        methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);

        Notification notification = buildNotification("Downloading...", "Initializing download service.", 0);
        try {
             startForeground(NOTIFICATION_ID, notification);
             Log.d(TAG, "Service started in foreground.");
        } catch (Exception e) {
             Log.e(TAG, "Error starting foreground service: " + e.getMessage());
             stopSelf();
             return START_NOT_STICKY;
        }

        methodChannel.setMethodCallHandler((call, result) -> {
            if (call.method.equals("updateNotification")) {
                String title = call.argument("title");
                String text = call.argument("text");
                int progress = call.argument("progress");
                updateNotification(title, text, progress);
                result.success(null);
            } else if (call.method.equals("onServiceStopped")) {
                stopSelf();
                result.success(null);
            } else {
                result.notImplemented();
            }
        });

        return START_STICKY;
    }

    private void createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel serviceChannel = new NotificationChannel(
                    NOTIFICATION_CHANNEL_ID,
                    "Download Service Channel",
                    NotificationManager.IMPORTANCE_LOW
            );
            notificationManager.createNotificationChannel(serviceChannel);
        }
    }

    private Notification buildNotification(String title, String text, int progress) {
        Intent notificationIntent = new Intent(this, MainActivity.class);
        PendingIntent pendingIntent = PendingIntent.getActivity(this, 0, notificationIntent, PendingIntent.FLAG_IMMUTABLE);

        return new NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_ID)
                .setContentTitle(title)
                .setContentText(text)
                .setSmallIcon(android.R.drawable.stat_sys_download)
                .setContentIntent(pendingIntent)
                .setProgress(100, progress, false)
                .setOngoing(true)
                .build();
    }

    private void updateNotification(String title, String text, int progress) {
        Notification notification = buildNotification(title, text, progress);
        notificationManager.notify(NOTIFICATION_ID, notification);
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}
