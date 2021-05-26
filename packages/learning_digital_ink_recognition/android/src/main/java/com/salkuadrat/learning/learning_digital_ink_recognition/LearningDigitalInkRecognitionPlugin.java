package com.salkuadrat.learning.learning_digital_ink_recognition;

import android.content.Context;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * LearningDigitalInkRecognitionPlugin
 */
public class LearningDigitalInkRecognitionPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private DigitalInkRecognition digitalInkRecognition;
    private Context applicationContext;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        applicationContext = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "LearningDigitalInkRecognition");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        Double _x = (Double) call.argument("x");
        Double _y = (Double) call.argument("y");
        Integer _time = (Integer) call.argument("time");

        float x = _x != null ? _x.floatValue() : 0.0f;
        float y = _y != null ? _y.floatValue() : 0.0f;
        long t = System.currentTimeMillis();

        switch (call.method) {
            case "start":
                String language = call.argument("language");
                digitalInkRecognition = new DigitalInkRecognition(language);
                digitalInkRecognition.start(result);
                break;
            case "actionDown":
                if (digitalInkRecognition != null) {
                    digitalInkRecognition.actionDown(x, y, t, result);
                }
                break;
            case "actionMove":
                if (digitalInkRecognition != null) {
                    digitalInkRecognition.actionMove(x, y, t, result);
                }
                break;
            case "actionUp":
                if (digitalInkRecognition != null) {
                    digitalInkRecognition.actionUp(x, y, t, result);
                }
                break;
            case "process":
                if (digitalInkRecognition != null) {
                    digitalInkRecognition.process(result);
                }
                break;
            case "dispose":
                dispose(result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void dispose(@NonNull Result result) {
        if (digitalInkRecognition != null) {
            digitalInkRecognition.dispose();
        }
        result.success(true);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
