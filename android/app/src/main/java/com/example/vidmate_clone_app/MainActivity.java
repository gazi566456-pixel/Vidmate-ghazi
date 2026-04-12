package com.example.vidmate_clone_app;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.plugin.common.MethodChannel;
import android.content.Intent;
import androidx.annotation.NonNull;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.example.vidmate_clone_app/download_service";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        
        // Cache the engine for background service use
        FlutterEngineCache.getInstance().put("my_download_engine", flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler((call, result) -> {
                if (call.method.equals("startService")) {
                    Intent intent = new Intent(this, ForegroundDownloadService.class);
                    if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                        startForegroundService(intent);
                    } else {
                        startService(intent);
                    }
                    result.success(null);
                } else if (call.method.equals("stopService")) {
                    Intent intent = new Intent(this, ForegroundDownloadService.class);
                    stopService(intent);
                    result.success(null);
                } else {
                    result.notImplemented();
                }
            });
    }
}
