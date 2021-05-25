package com.salkuadrat.learning.learning_selfie_segmentation;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.vision.common.InputImage;
import com.google.mlkit.vision.segmentation.Segmentation;
import com.google.mlkit.vision.segmentation.SegmentationMask;
import com.google.mlkit.vision.segmentation.Segmenter;
import com.google.mlkit.vision.segmentation.selfie.SelfieSegmenterOptions;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class SelfieSegmentation {

    private final Segmenter segmenter;

    public SelfieSegmentation(boolean isStreamMode, boolean enableRawSizeMask) {
        SelfieSegmenterOptions.Builder builder = new SelfieSegmenterOptions.Builder();

        builder.setDetectorMode(isStreamMode
            ? SelfieSegmenterOptions.STREAM_MODE
            : SelfieSegmenterOptions.SINGLE_IMAGE_MODE);

        if (enableRawSizeMask) {
            builder.enableRawSizeMask();
        }

        SelfieSegmenterOptions options = builder.build();
        segmenter = Segmentation.getClient(options);
    }

    public void process(@NonNull InputImage image, @NonNull final MethodChannel.Result result) {
        segmenter.process(image)
            .addOnSuccessListener(
                new OnSuccessListener<SegmentationMask>() {
                    @Override
                    public void onSuccess(SegmentationMask segmentationMask) {
                        process(segmentationMask, result);
                    }
                })
            .addOnFailureListener(
                new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        result.error("Selfie segmentation failed!", e.getMessage(), e);
                    }
                });
    }

    private void process(SegmentationMask segmentationMask, MethodChannel.Result result) {
        Map<String, Object> results = new HashMap<>();
        ByteBuffer mask = segmentationMask.getBuffer();
        int maskWidth = segmentationMask.getWidth();
        int maskHeight = segmentationMask.getHeight();

        results.put("maskWidth", maskWidth);
        results.put("maskHeight", maskHeight);
        
        List<Float> confidences = new ArrayList<>();

        for (int y = 0; y < maskHeight; y++) {
            for (int x = 0; x < maskWidth; x++) {
                // Gets the confidence of the (x,y) pixel in the mask being in the foreground.
                // float foregroundConfidence = mask.getFloat();
                confidences.add(mask.getFloat());
            }
        }
        
        results.put("confidences", confidences);
        result.success(results);
    }

    /* private void process(SegmentationMask segmentationMask, MethodChannel.Result result) {
        List<Map<String, Object>> results = new ArrayList<>();

        ByteBuffer mask = segmentationMask.getBuffer();
        int maskWidth = segmentationMask.getWidth();
        int maskHeight = segmentationMask.getHeight();

        for (int y = 0; y < maskHeight; y++) {
            for (int x = 0; x < maskWidth; x++) {
                Map<String, Object> item = new HashMap<>();
                item.put("x", x);
                item.put("y", y);
                item.put("foregroundConfidence", mask.getFloat());
                // Gets the confidence of the (x,y) pixel in the mask being in the foreground.
                // float foregroundConfidence = mask.getFloat();
                results.add(item);
            }
        }

        result.success(results);
    } */

    public void dispose() {
        if (segmenter != null) {
            segmenter.close();
        }
    }
}
