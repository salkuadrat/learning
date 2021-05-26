/*
package com.salkuadrat.learning.vision;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.vision.common.InputImage;
import com.google.mlkit.vision.label.ImageLabel;
import com.google.mlkit.vision.label.ImageLabeler;
import com.google.mlkit.vision.label.defaults.ImageLabelerOptions;
import com.salkuadrat.learning.VisionLearningInterface;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class ImageLabeling implements VisionLearningInterface {

    private final ImageLabeler labeler;

    public ImageLabeling(float threshold) {
        ImageLabelerOptions options =
            new ImageLabelerOptions.Builder()
                .setConfidenceThreshold(threshold)
                .build();
        labeler = com.google.mlkit.vision.label.ImageLabeling.getClient(options);
    }

    @Override
    public void start(@NonNull InputImage image, @NonNull final MethodChannel.Result result) {
        labeler.process(image)
            .addOnSuccessListener(
                new OnSuccessListener<List<ImageLabel>>() {
                    @Override
                    public void onSuccess(List<ImageLabel> labels) {
                        process(labels, result);
                    }
                })
            .addOnFailureListener(
                new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        result.error("Image labeling failed!", e.getMessage(), e);
                    }
                });
    }

    private void process(List<ImageLabel> labels, MethodChannel.Result result) {
        List<Map<String, Object>> results = new ArrayList<>();

        for (ImageLabel label : labels) {
            Map<String, Object> item = new HashMap<>();
            item.put("index", label.getIndex());
            item.put("label", label.getText());
            item.put("confidence", label.getConfidence());
            results.add(item);
        }

        result.success(results);
    }

    @Override
    public void dispose() {
        if (labeler != null) {
            labeler.close();
        }
    }
}
*/
