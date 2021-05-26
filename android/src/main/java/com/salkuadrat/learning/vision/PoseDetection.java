/*
package com.salkuadrat.learning.vision;

import android.graphics.PointF;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.vision.common.InputImage;
import com.google.mlkit.vision.common.PointF3D;
import com.google.mlkit.vision.pose.Pose;
import com.google.mlkit.vision.pose.PoseDetector;
import com.google.mlkit.vision.pose.PoseDetectorOptionsBase;
import com.google.mlkit.vision.pose.PoseLandmark;
import com.google.mlkit.vision.pose.defaults.PoseDetectorOptions;
import com.salkuadrat.learning.VisionLearningInterface;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class PoseDetection implements VisionLearningInterface {

    private final PoseDetector detector;

    public PoseDetection(boolean isStreamMode) {
        PoseDetectorOptions.Builder builder = new PoseDetectorOptions.Builder();

        builder.setDetectorMode(isStreamMode
            ? PoseDetectorOptions.STREAM_MODE
            : PoseDetectorOptions.SINGLE_IMAGE_MODE);

        PoseDetectorOptions options = builder.build();
        detector = com.google.mlkit.vision.pose.PoseDetection.getClient(options);
    }

    @Override
    public void start(@NonNull InputImage image, @NonNull final MethodChannel.Result result) {
        detector.process(image)
            .addOnSuccessListener(
                new OnSuccessListener<Pose>() {
                    @Override
                    public void onSuccess(Pose pose) {
                        process(pose, result);
                    }
                })
            .addOnFailureListener(
                new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        result.error("Pose detection failed!", e.getMessage(), e);
                    }
                });
    }

    private void process(Pose pose, MethodChannel.Result result) {
        // Get all PoseLandmarks. If no person was detected, the list will be empty
        List<PoseLandmark> allPoseLandmarks = pose.getAllPoseLandmarks();
        List<Map<String, Object>> results = new ArrayList<>();

        for (PoseLandmark landmark : allPoseLandmarks) {
            Map<String, Object> item = new HashMap<>();
            item.put("type", getLandmarkType(landmark.getLandmarkType()));
            item.put("inFrameLikelihood", landmark.getInFrameLikelihood());
            item.put("position", pointToMap(landmark.getPosition()));
            item.put("position3D", point3DToMap(landmark.getPosition3D()));
            results.add(item);
        }

        result.success(results);
    }

    Map<String, Object> pointToMap(@NonNull PointF point) {
        Map<String, Object> result = new HashMap<>();
        result.put("x", point.x);
        result.put("y", point.y);
        return result;
    }

    Map<String, Object> point3DToMap(@NonNull PointF3D point) {
        Map<String, Object> result = new HashMap<>();
        result.put("x", point.getX());
        result.put("y", point.getY());
        result.put("z", point.getZ());
        return result;
    }

    String getLandmarkType(int landmarkType) {
        switch (landmarkType) {
            case PoseLandmark.LEFT_EYE:
                return "LEFT_EYE";
            case PoseLandmark.LEFT_EYE_INNER:
                return "LEFT_EYE_INNER";
            case PoseLandmark.LEFT_EYE_OUTER:
                return "LEFT_EYE_OUTER";
            case PoseLandmark.RIGHT_EYE:
                return "RIGHT_EYE";
            case PoseLandmark.RIGHT_EYE_INNER:
                return "RIGHT_EYE_INNER";
            case PoseLandmark.RIGHT_EYE_OUTER:
                return "RIGHT_EYE_OUTER";
            case PoseLandmark.LEFT_EAR:
                return "LEFT_EAR";
            case PoseLandmark.RIGHT_EAR:
                return "RIGHT_EAR";
            case PoseLandmark.NOSE:
                return "NOSE";
            case PoseLandmark.LEFT_MOUTH:
                return "LEFT_MOUTH";
            case PoseLandmark.RIGHT_MOUTH:
                return "RIGHT_MOUTH";
            case PoseLandmark.LEFT_SHOULDER:
                return "LEFT_SHOULDER";
            case PoseLandmark.RIGHT_SHOULDER:
                return "RIGHT_SHOULDER";
            case PoseLandmark.LEFT_ELBOW:
                return "LEFT_ELBOW";
            case PoseLandmark.RIGHT_ELBOW:
                return "RIGHT_ELBOW";
            case PoseLandmark.LEFT_WRIST:
                return "LEFT_WRIST";
            case PoseLandmark.RIGHT_WRIST:
                return "RIGHT_WRIST";
            case PoseLandmark.LEFT_THUMB:
                return "LEFT_THUMB";
            case PoseLandmark.RIGHT_THUMB:
                return "RIGHT_THUMB";
            case PoseLandmark.LEFT_PINKY:
                return "LEFT_PINKY";
            case PoseLandmark.RIGHT_PINKY:
                return "RIGHT_PINKY";
            case PoseLandmark.LEFT_HIP:
                return "LEFT_HIP";
            case PoseLandmark.RIGHT_HIP:
                return "RIGHT_HIP";
            case PoseLandmark.LEFT_KNEE:
                return "LEFT_KNEE";
            case PoseLandmark.RIGHT_KNEE:
                return "RIGHT_KNEE";
            case PoseLandmark.LEFT_HEEL:
                return "LEFT_HEEL";
            case PoseLandmark.RIGHT_HEEL:
                return "RIGHT_HEEL";
            case PoseLandmark.LEFT_FOOT_INDEX:
                return "LEFT_FOOT_INDEX";
            case PoseLandmark.RIGHT_FOOT_INDEX:
                return "RIGHT_FOOT_INDEX";
            default:
                return "";
        }
    }

    @Override
    public void dispose() {
        if (detector != null) {
            detector.close();
        }
    }
}
*/
