package com.salkuadrat.learning.learning_language;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * LearningLanguagePlugin
 */
public class LearningLanguagePlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private LanguageIdentification languageIdentification;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "LearningLanguage");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "identify":
                identify(call, result);
                break;
            case "dispose":
                dispose(result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void identify(@NonNull MethodCall call, Result result) {
        String text = call.argument("text");
        Double _threshold = call.argument("confidenceThreshold");
        Boolean _multi = call.argument("isMultipleLanguages");

        float threshold = _threshold != null ? _threshold.floatValue() : 0.5f;
        boolean multi = _multi != null && _multi;

        if (text != null) {
            languageIdentification = new LanguageIdentification(threshold, multi);
            languageIdentification.identify(text, result);
        }
    }

    private void dispose(@NonNull Result result) {
        if (languageIdentification != null) {
            languageIdentification.dispose();
        }
        result.success(true);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
