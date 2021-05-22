package com.salkuadrat.learning.learning_entity_extraction;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.common.model.DownloadConditions;
import com.google.mlkit.common.model.RemoteModelManager;
import com.google.mlkit.nl.entityextraction.EntityExtractionRemoteModel;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * LearningEntityExtractionPlugin
 */
public class LearningEntityExtractionPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private MethodChannel modelManagerChannel;
    private EntityExtraction entityExtraction;

    private final RemoteModelManager modelManager = RemoteModelManager.getInstance();

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "LearningEntityExtraction");
        channel.setMethodCallHandler(this);
        setModelManager(flutterPluginBinding);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "extract":
                extract(call, result);
                break;
            case "dispose":
                dispose(result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void extract(@NonNull MethodCall call, Result result) {
        String model = call.argument("model");
        String text = call.argument("text");

        if (text != null) {
            entityExtraction = new EntityExtraction(model);
            entityExtraction.extract(text, null, result);
        }
    }

    private void dispose(@NonNull Result result) {
        if (entityExtraction != null) {
            entityExtraction.dispose();
        }
        result.success(true);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
        modelManagerChannel.setMethodCallHandler(null);
    }

    private void setModelManager(@NonNull FlutterPluginBinding flutterPluginBinding) {
        modelManagerChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "LearningEntityModelManager");
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
        modelManager.getDownloadedModels(EntityExtractionRemoteModel.class)
            .addOnSuccessListener(new OnSuccessListener<Set<EntityExtractionRemoteModel>>() {
                @Override
                public void onSuccess(Set<EntityExtractionRemoteModel> models) {
                    List<String> results = new ArrayList<>();
                    for (EntityExtractionRemoteModel model : models) {
                        results.add(model.getModelIdentifier());
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
            EntityExtractionRemoteModel remoteModel = new EntityExtractionRemoteModel
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
            modelManager.getDownloadedModels(EntityExtractionRemoteModel.class)
                .addOnSuccessListener(new OnSuccessListener<Set<EntityExtractionRemoteModel>>() {
                    @Override
                    public void onSuccess(Set<EntityExtractionRemoteModel> models) {
                        boolean isFound = false;
                        for (EntityExtractionRemoteModel model : models) {
                            if (entityModel.equals(model.getModelIdentifier())) {
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
            EntityExtractionRemoteModel remoteModel = new EntityExtractionRemoteModel
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
