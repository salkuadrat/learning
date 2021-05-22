package com.salkuadrat.learning.learning_smart_reply;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * LearningSmartReplyPlugin
 */
public class LearningSmartReplyPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private SmartReply smartReply;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "LearningSmartReply");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "refresh":
                refresh(result);
                break;
            case "push":
                addConversation(call, result);
                break;
            case "generateReplies":
                generateReplies(result);
                break;
            case "dispose":
                dispose(result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void refresh(@NonNull Result result) {
        if(smartReply != null) {
            smartReply.clear();
        }
        smartReply = new SmartReply();
        result.success(true);
    }

    private void addConversation(@NonNull MethodCall call, @NonNull Result result) {
        String userId = call.argument("user");
        String text = call.argument("text");
        Long _timestamp = call.argument("timestamp");
        long timestamp = _timestamp != null ? _timestamp : 0;

        if (smartReply == null) {
            smartReply = new SmartReply();
        }

        if (text != null) {
            smartReply.addConversation(userId, timestamp, text);
        }

        result.success(true);
    }

    private void generateReplies(@NonNull Result result) {
        if (smartReply != null) {
            smartReply.generateReplies(result);
        }
    }

    private void dispose(@NonNull Result result) {
        if (smartReply != null) {
            smartReply.dispose();
        }
        result.success(true);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
