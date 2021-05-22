package com.salkuadrat.learning.learning_translate;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.common.model.DownloadConditions;
import com.google.mlkit.common.model.RemoteModelManager;
import com.google.mlkit.nl.translate.TranslateRemoteModel;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * LearningTranslatePlugin
 */
public class LearningTranslatePlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private MethodChannel modelManagerChannel;
    private TranslateText translateText;

    private final RemoteModelManager modelManager = RemoteModelManager.getInstance();

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "LearningTranslate");
        channel.setMethodCallHandler(this);
        setModelManager(flutterPluginBinding);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "translate":
                translate(call, result);
                break;
            case "dispose":
                dispose(result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void translate(@NonNull MethodCall call, @NonNull Result result) {
        String source = call.argument("from");
        String target = call.argument("to");
        String text = call.argument("text");
        Boolean _isDownloadRequireWifi = call.argument("isDownloadRequireWifi");

        boolean isDownloadRequireWifi =
            _isDownloadRequireWifi != null && _isDownloadRequireWifi;

        if (source != null && target != null && text != null) {
            translateText = new TranslateText(source, target, isDownloadRequireWifi);
            translateText.start(text, result);
        }
    }

    private void dispose(@NonNull Result result) {
        if (translateText != null) {
            translateText.dispose();
        }
        result.success(true);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
        modelManagerChannel.setMethodCallHandler(null);
    }

    private void setModelManager(@NonNull FlutterPluginBinding flutterPluginBinding) {
        modelManagerChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "LearningTranslationModelManager");
        modelManagerChannel.setMethodCallHandler(new MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
                switch (call.method) {
                    case "list":
                        listModel(result);
                        break;
                    case "download":
                        downloadModel(call, result);
                        break;
                    case "check":
                        checkModel(call, result);
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

    private void listModel(@NonNull final Result result) {
        modelManager.getDownloadedModels(TranslateRemoteModel.class)
            .addOnSuccessListener(new OnSuccessListener<Set<TranslateRemoteModel>>() {
                @Override
                public void onSuccess(Set<TranslateRemoteModel> models) {
                    List<String> results = new ArrayList<>();
                    for (TranslateRemoteModel model : models) {
                        results.add(model.getLanguage());
                    }
                    result.success(results);
                }
            })
            .addOnFailureListener(new OnFailureListener() {
                @Override
                public void onFailure(@NonNull Exception e) {
                    result.error("Listing models failed!", e.getMessage(), e);
                }
            });
    }

    private void downloadModel(@NonNull MethodCall call, @NonNull final Result result) {
        String entityModel = call.argument("model");
        Boolean _isRequireWifi = call.argument("isRequireWifi");
        boolean isRequireWifi = _isRequireWifi != null && _isRequireWifi;

        if (entityModel != null) {
            TranslateRemoteModel remoteModel = new TranslateRemoteModel
                .Builder(entityModel)
                .build();
            DownloadConditions.Builder builder = new DownloadConditions.Builder();

            if (isRequireWifi) {
                builder.requireWifi();
            }

            DownloadConditions conditions = builder.build();

            modelManager.download(remoteModel, conditions)
                .addOnSuccessListener(new OnSuccessListener<Void>() {
                    @Override
                    public void onSuccess(Void v) {
                        result.success(true);
                    }
                })
                .addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        result.error("Download model failed!", e.getMessage(), e);
                    }
                });
        } else {
            result.error("Model is not valid", null, null);
        }
    }

    private void checkModel(@NonNull MethodCall call, @NonNull final Result result) {
        final String entityModel = call.argument("model");

        if (entityModel != null) {
            modelManager.getDownloadedModels(TranslateRemoteModel.class)
                .addOnSuccessListener(new OnSuccessListener<Set<TranslateRemoteModel>>() {
                    @Override
                    public void onSuccess(Set<TranslateRemoteModel> models) {
                        boolean isFound = false;
                        for (TranslateRemoteModel model : models) {
                            if (entityModel.equals(model.getLanguage())) {
                                isFound = true;
                                break;
                            }
                        }
                        result.success(isFound);
                    }
                })
                .addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        result.error("Listing models failed!", e.getMessage(), e);
                    }
                });
        } else {
            result.error("Model is not valid", null, null);
        }
    }

    private void deleteModel(@NonNull MethodCall call, @NonNull final Result result) {
        String entityModel = call.argument("model");

        if (entityModel != null) {
            TranslateRemoteModel remoteModel = new TranslateRemoteModel
                .Builder(entityModel)
                .build();

            modelManager.deleteDownloadedModel(remoteModel)
                .addOnSuccessListener(new OnSuccessListener<Void>() {
                    @Override
                    public void onSuccess(Void v) {
                        result.success(true);
                    }
                })
                .addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        result.error("Delete model failed!", e.getMessage(), e);
                    }
                });
        } else {
            result.error("Model is not valid", null, null);
        }
    }
}
