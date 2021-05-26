/*
package com.salkuadrat.learning.vision;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.vision.common.InputImage;
import com.google.mlkit.vision.segmentation.Segmentation;
import com.google.mlkit.vision.segmentation.SegmentationMask;
import com.google.mlkit.vision.segmentation.Segmenter;
import com.google.mlkit.vision.segmentation.selfie.SelfieSegmenterOptions;
import com.salkuadrat.learning.VisionLearningInterface;

import io.flutter.plugin.common.MethodChannel;

public class SelfieSegmentation implements VisionLearningInterface {

    private Segmenter segmenter;

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

    @Override
    public void start(@NonNull InputImage image, @NonNull final MethodChannel.Result result) {
        segmenter.process(image)
            .addOnSuccessListener(
                new OnSuccessListener<SegmentationMask>() {
                    @Override
                    public void onSuccess(SegmentationMask mask) {
                        process(mask, result);
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

    private void process(SegmentationMask mask, MethodChannel.Result result) {

    }

    @Override
    public void dispose() {
        if (segmenter != null) {
            segmenter.close();
        }
    }
}
*/
