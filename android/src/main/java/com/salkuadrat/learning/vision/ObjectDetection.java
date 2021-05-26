/*
package com.salkuadrat.learning.vision;

import android.graphics.Rect;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.vision.common.InputImage;
import com.google.mlkit.vision.objects.DetectedObject;
import com.google.mlkit.vision.objects.ObjectDetector;
import com.google.mlkit.vision.objects.defaults.ObjectDetectorOptions;
import com.salkuadrat.learning.VisionLearningInterface;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class ObjectDetection implements VisionLearningInterface {

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

    @Override
    public void start(@NonNull InputImage image, @NonNull final MethodChannel.Result result) {
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
        List<List<Map<String, Object>>> results = new ArrayList<>();

        for (DetectedObject object : objects) {
            List<Map<String, Object>> list = new ArrayList<>();
            Rect boundingBox = object.getBoundingBox();
            Integer trackingId = object.getTrackingId();

            for (DetectedObject.Label label : object.getLabels()) {
                Map<String, Object> item = new HashMap<>();
                item.put("index", label.getIndex());
                item.put("label", label.getText());
                item.put("confidence", label.getConfidence());
                list.add(item);
            }

            results.add(list);
        }

        result.success(results);
    }

    @Override
    public void dispose() {
        if (detector != null) {
            detector.close();
        }
    }
}
*/
