package com.salkuadrat.learning.learning_object_detection;

import android.graphics.Rect;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.vision.common.InputImage;
import com.google.mlkit.vision.objects.DetectedObject;
import com.google.mlkit.vision.objects.ObjectDetector;
import com.google.mlkit.vision.objects.defaults.ObjectDetectorOptions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class ObjectDetection {

    private final ObjectDetector detector;

    public ObjectDetection(boolean isStreamMode, boolean classification, boolean multiple) {
        ObjectDetectorOptions.Builder builder = new ObjectDetectorOptions.Builder();

        builder.setDetectorMode(isStreamMode
            ? ObjectDetectorOptions.STREAM_MODE
            : ObjectDetectorOptions.SINGLE_IMAGE_MODE);

        if (classification) {
            builder.enableClassification();
        }

        if (multiple) {
            builder.enableMultipleObjects();
        }

        ObjectDetectorOptions options = builder.build();
        detector = com.google.mlkit.vision.objects.ObjectDetection.getClient(options);
    }

    public void detect(@NonNull InputImage image, @NonNull final MethodChannel.Result result) {
        detector.process(image)
            .addOnSuccessListener(
                new OnSuccessListener<List<DetectedObject>>() {
                    @Override
                    public void onSuccess(List<DetectedObject> objects) {
                        process(objects, result);
                    }
                })
            .addOnFailureListener(
                new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        result.error("Object detection failed!", e.getMessage(), e);
                    }
                });
    }

    private void process(List<DetectedObject> objects, MethodChannel.Result result) {
        List<Map<String, Object>> results = new ArrayList<>();

        for (DetectedObject object : objects) {
            Map<String, Object> objectData = new HashMap<>();
            objectData.put("trackingId", object.getTrackingId());
            objectData.put("boundingBox", rectToMap(object.getBoundingBox()));

            List<Map<String, Object>> labelsData = new ArrayList<>();
            for (DetectedObject.Label label : object.getLabels()) {
                Map<String, Object> item = new HashMap<>();
                item.put("index", label.getIndex());
                item.put("label", label.getText());
                item.put("confidence", label.getConfidence());
                labelsData.add(item);
            }
            objectData.put("labels", labelsData);
            results.add(objectData);
        }

        result.success(results);
    }

    Map<String, Object> rectToMap(@NonNull Rect bounds) {
        Map<String, Object> result = new HashMap<>();
        result.put("top", bounds.top);
        result.put("left", bounds.left);
        result.put("right", bounds.right);
        result.put("bottom", bounds.bottom);
        return result;
    }

    public void dispose() {
        if (detector != null) {
            detector.close();
        }
    }
}
