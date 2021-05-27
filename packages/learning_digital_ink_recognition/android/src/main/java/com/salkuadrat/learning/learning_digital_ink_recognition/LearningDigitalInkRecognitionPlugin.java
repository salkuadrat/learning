package com.salkuadrat.learning.learning_digital_ink_recognition;

import android.content.Context;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.common.MlKitException;
import com.google.mlkit.common.model.DownloadConditions;
import com.google.mlkit.common.model.RemoteModelManager;
import com.google.mlkit.vision.digitalink.DigitalInkRecognitionModel;
import com.google.mlkit.vision.digitalink.DigitalInkRecognitionModelIdentifier;
import com.google.mlkit.vision.digitalink.DigitalInkRecognizerOptions;

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
    private MethodChannel modelManagerChannel;
    private DigitalInkRecognition digitalInkRecognition;
    private Context applicationContext;

    private RemoteModelManager remoteModelManager = RemoteModelManager.getInstance();

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        applicationContext = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "LearningDigitalInkRecognition");
        channel.setMethodCallHandler(this);
        setModelManager(flutterPluginBinding);
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
                Double _width = (Double) call.argument("width");
                Double _height = (Double) call.argument("height");
                float width = _width != null ? _width.floatValue() : 0.0f;
                float height = _height != null ? _height.floatValue() : 0.0f;
                digitalInkRecognition = new DigitalInkRecognition(language, width, height);
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
                    String preContext = call.argument("preContext");
                    digitalInkRecognition.process(preContext, result);
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

    private void setModelManager(@NonNull FlutterPluginBinding flutterPluginBinding) {
        modelManagerChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "LearningDigitalInkModelManager");
        modelManagerChannel.setMethodCallHandler(new MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
                switch (call.method) {
                    case "check":
                        checkModel(call, result);
                        break;
                    case "download":
                        downloadModel(call, result);
                        break;
                    case "delete":
                        deleteModel(call, result);
                        break;
                    default:
                        result.notImplemented();
                        break;
                }
            }
        });
    }

    private void checkModel(@NonNull MethodCall call, @NonNull final Result result) {
        String language = call.argument("model");

        try {
            DigitalInkRecognitionModelIdentifier modelIdentifier =
                DigitalInkRecognitionModelIdentifier.fromLanguageTag(language);

            DigitalInkRecognitionModel model = DigitalInkRecognitionModel
                .builder(modelIdentifier)
                .build();

            remoteModelManager.isModelDownloaded(model)
                .addOnSuccessListener(new OnSuccessListener<Boolean>() {
                    @Override
                    public void onSuccess(@NonNull Boolean isDownloaded) {
                        result.success(isDownloaded);
                    }
                })
                .addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        result.error("Check model failed!", e.getMessage(), e);
                    }
                });
        } catch (MlKitException e) {
            result.error("MLKitException", e.getMessage(), e);
        }
    }

    private void downloadModel(@NonNull MethodCall call, @NonNull final Result result) {
        String language = call.argument("model");

        try {
            DigitalInkRecognitionModelIdentifier modelIdentifier =
                DigitalInkRecognitionModelIdentifier.fromLanguageTag(language);

            DigitalInkRecognitionModel model = DigitalInkRecognitionModel
                .builder(modelIdentifier)
                .build();

            remoteModelManager.download(model, new DownloadConditions.Builder().build())
                .addOnSuccessListener(new OnSuccessListener<Void>() {
                    @Override
                    public void onSuccess(@NonNull Void unused) {
                        result.success(true);
                    }
                })
                .addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        result.error("Download model failed!", e.getMessage(), e);
                    }
                });
        } catch (MlKitException e) {
            result.error("MLKitException", e.getMessage(), e);
        }
    }

    private void deleteModel(@NonNull MethodCall call, @NonNull final Result result) {
        String language = call.argument("model");

        try {
            DigitalInkRecognitionModelIdentifier modelIdentifier =
                DigitalInkRecognitionModelIdentifier.fromLanguageTag(language);

            DigitalInkRecognitionModel model = DigitalInkRecognitionModel
                .builder(modelIdentifier)
                .build();

            remoteModelManager.deleteDownloadedModel(model)
                .addOnSuccessListener(new OnSuccessListener<Void>() {
                    @Override
                    public void onSuccess(@NonNull Void unused) {
                        result.success(true);
                    }
                })
                .addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        result.error("Check model failed!", e.getMessage(), e);
                    }
                });
        } catch (MlKitException e) {
            result.error("MLKitException", e.getMessage(), e);
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
