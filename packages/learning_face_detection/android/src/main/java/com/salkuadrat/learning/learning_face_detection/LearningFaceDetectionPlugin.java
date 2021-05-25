package com.salkuadrat.learning.learning_face_detection;

import android.content.Context;
import android.net.Uri;

import androidx.annotation.NonNull;

import com.google.mlkit.vision.common.InputImage;
import com.google.mlkit.vision.face.FaceDetectorOptions;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * LearningFaceDetectionPlugin
 */
public class LearningFaceDetectionPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private FaceDetection faceDetection;
    private Context applicationContext;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        applicationContext = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "LearningFaceDetection");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "detect":
                detect(call, result);
                break;
            case "dispose":
                dispose(result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void detect(MethodCall call, Result result) {
        InputImage image = getInputImage(call, result);
        Double _minFaceSize = call.argument("minFaceSize");
        Boolean _tracking = call.argument("enableTracking");

        float minFaceSize = _minFaceSize != null ? _minFaceSize.floatValue() : 0.15f;
        String performance = call.argument("performance");
        String landmark = call.argument("landmark");
        String classification = call.argument("classification");
        String contour = call.argument("contour");
        boolean tracking = _tracking != null && _tracking;

        int performanceMode = performance != null && performance.equals("accurate")
            ? FaceDetectorOptions.PERFORMANCE_MODE_ACCURATE
            : FaceDetectorOptions.PERFORMANCE_MODE_FAST;

        int classificationMode = classification != null && classification.equals("all")
            ? FaceDetectorOptions.CLASSIFICATION_MODE_ALL
            : FaceDetectorOptions.CLASSIFICATION_MODE_NONE;

        int landmarkMode = landmark != null && landmark.equals("all")
            ? FaceDetectorOptions.LANDMARK_MODE_ALL
            : FaceDetectorOptions.LANDMARK_MODE_NONE;

        int contourMode = contour != null && contour.equals("all")
            ? FaceDetectorOptions.CONTOUR_MODE_ALL
            : FaceDetectorOptions.CONTOUR_MODE_NONE;

        if (image != null) {
            faceDetection = new FaceDetection(minFaceSize,
                performanceMode, classificationMode, landmarkMode, contourMode, tracking);
            faceDetection.detect(image, result);
        }
    }

    private InputImage getInputImage(MethodCall call, Result result) {
        Map<String, Object> data = call.argument("image");

        if (data != null) {
            try {
                return getInputImage(data, result);
            } catch (Exception e) {
                e.printStackTrace();
                result.error("Image data invalid!", e.getMessage(), e);
            }
        }

        return null;
    }

    private InputImage getInputImage(@NonNull Map<String, Object> data, Result result) {
        // file or bytes
        String type = (String) data.get("type");
        InputImage inputImage;

        if (type != null) {
            if (type.equals("file")) {
                try {
                    String path = (String) data.get("path");
                    if (path != null) {
                        File file = new File(path);
                        Uri uri = Uri.fromFile(file);
                        inputImage = InputImage.fromFilePath(applicationContext, uri);
                        return inputImage;
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                    result.error("Image data error", e.getMessage(), e);
                    return null;
                }
            } else if (type.equals("bytes")) {
                Map metaData = (Map) data.get("metadata");
                
                if (metaData != null) {
                    Object _bytes = data.get("bytes");
                    Double _width = (Double) metaData.get("width");
                    Double _height = (Double) metaData.get("height");
                    Integer _rotation = (Integer) metaData.get("rotation");
                    Integer _imageFormat = (Integer) metaData.get("imageFormat");

                    if (_bytes != null) {
                        inputImage = InputImage.fromByteArray(
                            (byte[]) _bytes,
                            _width != null ? _width.intValue() : 0,
                            _height != null ? _height.intValue() : 0,
                            _rotation != null ? _rotation : 0,
                            _imageFormat != null ? _imageFormat : 0
                        );

                        return inputImage;
                    }
                }
            }
        }

        result.error("Invalid Image Data", null, null);
        return null;
    }

    private void dispose(@NonNull Result result) {
        if (faceDetection != null) {
            faceDetection.dispose();
        }
        result.success(true);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
