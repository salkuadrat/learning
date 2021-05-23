package com.salkuadrat.learning.learning_face_detection;

import android.graphics.PointF;
import android.graphics.Rect;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.vision.common.InputImage;
import com.google.mlkit.vision.face.Face;
import com.google.mlkit.vision.face.FaceContour;
import com.google.mlkit.vision.face.FaceDetector;
import com.google.mlkit.vision.face.FaceDetectorOptions;
import com.google.mlkit.vision.face.FaceLandmark;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class FaceDetection {

    private final FaceDetector detector;

    public FaceDetection(
        float minFaceSize, int performance, int landmark,
        int classification, int contour, boolean tracking) {
        FaceDetectorOptions.Builder builder =
            new FaceDetectorOptions.Builder()
                .setPerformanceMode(performance)
                .setLandmarkMode(landmark)
                .setClassificationMode(classification)
                .setContourMode(contour)
                .setMinFaceSize(minFaceSize);

        if (tracking) {
            builder.enableTracking();
        }

        FaceDetectorOptions options = builder.build();
        detector = com.google.mlkit.vision.face.FaceDetection.getClient(options);
    }

    public void detect(@NonNull InputImage image, @NonNull final MethodChannel.Result result) {
        detector.process(image)
            .addOnSuccessListener(
                new OnSuccessListener<List<Face>>() {
                    @Override
                    public void onSuccess(List<Face> faces) {
                        process(faces, result);
                    }
                })
            .addOnFailureListener(
                new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        result.error("Face detection failed!", e.getMessage(), e);
                    }
                });
    }

    private void process(List<Face> faces, MethodChannel.Result result) {
        List<Map<String, Object>> results = new ArrayList<>();

        for (Face face : faces) {
            Map<String, Object> item = new HashMap<>();

            item.put("bound", rectToMap(face.getBoundingBox()));

            // Head is rotated to the right rotY degrees
            item.put("headAngleY", face.getHeadEulerAngleY());

            // Head is tilted sideways rotZ degrees
            item.put("headAngleZ", face.getHeadEulerAngleZ());

            Map<String, Object> landmarks = new HashMap<>();

            // landmark eye
            FaceLandmark leftEye = face.getLandmark(FaceLandmark.LEFT_EYE);
            FaceLandmark rightEye = face.getLandmark(FaceLandmark.RIGHT_EYE);

            if (leftEye != null) {
                landmarks.put("LEFT_EYE", pointToMap(leftEye.getPosition()));
            }

            if (rightEye != null) {
                landmarks.put("RIGHT_EYE", pointToMap(rightEye.getPosition()));
            }

            // landmark ear
            FaceLandmark leftEar = face.getLandmark(FaceLandmark.LEFT_EAR);
            FaceLandmark rightEar = face.getLandmark(FaceLandmark.RIGHT_EAR);

            if (leftEar != null) {
                landmarks.put("LEFT_EAR", pointToMap(leftEar.getPosition()));
            }

            if (rightEar != null) {
                landmarks.put("RIGHT_EAR", pointToMap(rightEar.getPosition()));
            }

            // landmark cheek
            FaceLandmark leftCheek = face.getLandmark(FaceLandmark.LEFT_CHEEK);
            FaceLandmark rightCheek = face.getLandmark(FaceLandmark.RIGHT_CHEEK);

            if (leftCheek != null) {
                landmarks.put("LEFT_CHEEK", pointToMap(leftCheek.getPosition()));
            }

            if (rightCheek != null) {
                landmarks.put("RIGHT_CHEEK", pointToMap(rightCheek.getPosition()));
            }

            // landmark nose
            FaceLandmark nose = face.getLandmark(FaceLandmark.NOSE_BASE);

            if (nose != null) {
                landmarks.put("nose", pointToMap(nose.getPosition()));
            }

            // landmark mouth
            FaceLandmark mouthLeft = face.getLandmark(FaceLandmark.MOUTH_LEFT);
            FaceLandmark mouthRight = face.getLandmark(FaceLandmark.MOUTH_RIGHT);
            FaceLandmark mouthBottom = face.getLandmark(FaceLandmark.MOUTH_BOTTOM);

            if (mouthLeft != null) {
                landmarks.put("MOUTH_LEFT", pointToMap(mouthLeft.getPosition()));
            }

            if (mouthRight != null) {
                landmarks.put("MOUTH_RIGHT", pointToMap(mouthRight.getPosition()));
            }

            if (mouthBottom != null) {
                landmarks.put("MOUTH_BOTTOM", pointToMap(mouthBottom.getPosition()));
            }
            
            item.put("landmarks", landmarks);
            
            Map<String, Object> contours = new HashMap<>();
            // Contour Face
            FaceContour faceContour = face.getContour(FaceContour.FACE);

            if (faceContour != null) {
                contours.put("FACE", pointsToList(faceContour.getPoints()));
            }

            // Contour Eye
            FaceContour leftEyeCountour = face.getContour(FaceContour.LEFT_EYE);
            FaceContour rightEyeCountour = face.getContour(FaceContour.RIGHT_EYE);

            if (leftEyeCountour != null) {
                contours.put("LEFT_EYE", pointsToList(leftEyeCountour.getPoints()));
            }

            if (rightEyeCountour != null) {
                contours.put("RIGHT_EYE", pointsToList(rightEyeCountour.getPoints()));
            }

            // Contour Eyebrow
            FaceContour leftTopEBCountour = face.getContour(FaceContour.LEFT_EYEBROW_TOP);
            FaceContour leftBottomEBCountour = face.getContour(FaceContour.LEFT_EYEBROW_BOTTOM);
            FaceContour rightTopEBCountour = face.getContour(FaceContour.RIGHT_EYEBROW_TOP);
            FaceContour rightBottomEBCountour = face.getContour(FaceContour.RIGHT_EYEBROW_BOTTOM);

            if (leftTopEBCountour != null) {
                contours.put("LEFT_EYEBROW_TOP", pointsToList(leftTopEBCountour.getPoints()));
            }

            if (leftBottomEBCountour != null) {
                contours.put("LEFT_EYEBROW_BOTTOM", pointsToList(leftBottomEBCountour.getPoints()));
            }

            if (rightTopEBCountour != null) {
                contours.put("RIGHT_EYEBROW_TOP", pointsToList(rightTopEBCountour.getPoints()));
            }

            if (rightBottomEBCountour != null) {
                contours.put("RIGHT_EYEBROW_BOTTOM", pointsToList(rightBottomEBCountour.getPoints()));
            }

            // Contour Nose
            FaceContour noseBridgeCountour = face.getContour(FaceContour.NOSE_BRIDGE);
            FaceContour noseBottomCountour = face.getContour(FaceContour.NOSE_BOTTOM);

            if (noseBridgeCountour != null) {
                contours.put("NOSE_BRIDGE", pointsToList(noseBridgeCountour.getPoints()));
            }

            if (noseBottomCountour != null) {
                contours.put("NOSE_BOTTOM", pointsToList(noseBottomCountour.getPoints()));
            }

            // Contour Cheek
            FaceContour leftCheekCountour = face.getContour(FaceContour.LEFT_CHEEK);
            FaceContour rightCheekCountour = face.getContour(FaceContour.RIGHT_CHEEK);

            if (leftCheekCountour != null) {
                contours.put("LEFT_CHEEK", pointsToList(leftCheekCountour.getPoints()));
            }

            if (rightCheekCountour != null) {
                contours.put("RIGHT_CHEEK", pointsToList(rightCheekCountour.getPoints()));
            }

            // Contour Lip
            FaceContour upperTopLipCountour = face.getContour(FaceContour.UPPER_LIP_TOP);
            FaceContour upperBottomLipCountour = face.getContour(FaceContour.UPPER_LIP_BOTTOM);
            FaceContour lowerTopLipCountour = face.getContour(FaceContour.LOWER_LIP_TOP);
            FaceContour lowerBottomLipCountour = face.getContour(FaceContour.LOWER_LIP_BOTTOM);

            if (upperTopLipCountour != null) {
                contours.put("UPPER_LIP_TOP", pointsToList(upperTopLipCountour.getPoints()));
            }

            if (upperBottomLipCountour != null) {
                contours.put("UPPER_LIP_BOTTOM", pointsToList(upperBottomLipCountour.getPoints()));
            }

            if (lowerTopLipCountour != null) {
                contours.put("LOWER_LIP_TOP", pointsToList(lowerTopLipCountour.getPoints()));
            }

            if (lowerBottomLipCountour != null) {
                contours.put("LOWER_LIP_BOTTOM", pointsToList(lowerBottomLipCountour.getPoints()));
            }
            
            item.put("contours", contours);

            // If classification was enabled:
            if (face.getSmilingProbability() != null) {
                item.put("smilingProbability", face.getSmilingProbability());
            }

            if (face.getLeftEyeOpenProbability() != null) {
                item.put("leftEyeOpenProbability", face.getLeftEyeOpenProbability());
            }

            if (face.getRightEyeOpenProbability() != null) {
                item.put("rightEyeOpenProbability", face.getRightEyeOpenProbability());
            }

            // If face tracking was enabled:
            if (face.getTrackingId() != null) {
                item.put("trackingId", face.getTrackingId());
            }

            results.add(item);
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

    Map<String, Object> pointToMap(@NonNull PointF point) {
        Map<String, Object> result = new HashMap<>();
        result.put("x", point.x);
        result.put("y", point.y);
        return result;
    }

    List<Map<String, Object>> pointsToList(@NonNull List<PointF> points) {
        List<Map<String, Object>> result = new ArrayList<>();
        for (PointF point : points) {
            result.add(pointToMap(point));
        }
        return result;
    }

    public void dispose() {
        if (detector != null) {
            detector.close();
        }
    }
}
