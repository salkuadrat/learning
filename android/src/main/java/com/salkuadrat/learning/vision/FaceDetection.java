/*
package com.salkuadrat.learning.vision;

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
import com.salkuadrat.learning.VisionLearningInterface;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class FaceDetection implements VisionLearningInterface {

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

    @Override
    public void start(@NonNull InputImage image, @NonNull final MethodChannel.Result result) {
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

            Rect bounds = face.getBoundingBox();
            Map<String, Object> _bounds = new HashMap<>();

            _bounds.put("top", bounds.top);
            _bounds.put("left", bounds.left);
            _bounds.put("right", bounds.right);
            _bounds.put("bottom", bounds.bottom);

            item.put("bounds", _bounds);

            float rotY = face.getHeadEulerAngleY();  // Head is rotated to the right rotY degrees
            float rotZ = face.getHeadEulerAngleZ();  // Head is tilted sideways rotZ degrees

            item.put("headAngleY", rotY);
            item.put("headAngleZ", rotZ);

            // If landmark detection was enabled
            // (mouth, ears, eyes, cheeks, and nose available):
            Map<String, Object> landmark = new HashMap<>();
            Map<String, Object> eye = new HashMap<>();
            Map<String, Object> ear = new HashMap<>();
            Map<String, Object> cheek = new HashMap<>();
            Map<String, Object> mouth = new HashMap<>();

            // landmark eye
            FaceLandmark leftEye = face.getLandmark(FaceLandmark.LEFT_EYE);
            FaceLandmark rightEye = face.getLandmark(FaceLandmark.RIGHT_EYE);

            if (leftEye != null) {
                eye.put("left", pointToMap(leftEye.getPosition()));
            }

            if (rightEye != null) {
                eye.put("right", pointToMap(rightEye.getPosition()));
            }

            landmark.put("ear", eye);

            // landmark ear
            FaceLandmark leftEar = face.getLandmark(FaceLandmark.LEFT_EAR);
            FaceLandmark rightEar = face.getLandmark(FaceLandmark.RIGHT_EAR);

            if (leftEar != null) {
                ear.put("left", pointToMap(leftEar.getPosition()));
            }

            if (rightEar != null) {
                ear.put("right", pointToMap(rightEar.getPosition()));
            }

            landmark.put("ear", ear);

            // landmark cheek
            FaceLandmark leftCheek = face.getLandmark(FaceLandmark.LEFT_CHEEK);
            FaceLandmark rightCheek = face.getLandmark(FaceLandmark.RIGHT_CHEEK);

            if (leftCheek != null) {
                cheek.put("left", pointToMap(leftCheek.getPosition()));
            }

            if (rightCheek != null) {
                cheek.put("right", pointToMap(rightCheek.getPosition()));
            }

            landmark.put("cheek", cheek);

            // landmark nose
            FaceLandmark nose = face.getLandmark(FaceLandmark.NOSE_BASE);

            if (nose != null) {
                landmark.put("nose", pointToMap(nose.getPosition()));
            }

            // landmark eye
            FaceLandmark mouthLeft = face.getLandmark(FaceLandmark.MOUTH_LEFT);
            FaceLandmark mouthRight = face.getLandmark(FaceLandmark.MOUTH_RIGHT);
            FaceLandmark mouthBottom = face.getLandmark(FaceLandmark.MOUTH_BOTTOM);

            if (mouthLeft != null) {
                mouth.put("left", pointToMap(mouthLeft.getPosition()));
            }

            if (mouthRight != null) {
                mouth.put("right", pointToMap(mouthRight.getPosition()));
            }

            if (mouthBottom != null) {
                mouth.put("bottom", pointToMap(mouthBottom.getPosition()));
            }

            landmark.put("mouth", mouth);
            item.put("landmark", landmark);

            // If Contour detection is enabled.
            Map<String, Object> contour = new HashMap<>();
            Map<String, Object> cEye = new HashMap<>();
            Map<String, Object> cEyebrow = new HashMap<>();
            Map<String, Object> cNose = new HashMap<>();
            Map<String, Object> cCheek = new HashMap<>();
            Map<String, Object> cLip = new HashMap<>();

            // Contour Face
            FaceContour faceContour = face.getContour(FaceContour.FACE);

            if (faceContour != null) {
                contour.put("face", pointsToList(faceContour.getPoints()));
            }

            // Contour Eye
            FaceContour leftEyeCountour = face.getContour(FaceContour.LEFT_EYE);
            FaceContour rightEyeCountour = face.getContour(FaceContour.RIGHT_EYE);

            if (leftEyeCountour != null) {
                cEye.put("left", pointsToList(leftEyeCountour.getPoints()));
            }

            if (rightEyeCountour != null) {
                cEye.put("right", pointsToList(rightEyeCountour.getPoints()));
            }

            contour.put("eye", cEye);

            // Contour Eyebrow
            FaceContour leftTopEBCountour = face.getContour(FaceContour.LEFT_EYEBROW_TOP);
            FaceContour leftBottomEBCountour = face.getContour(FaceContour.LEFT_EYEBROW_BOTTOM);
            FaceContour rightTopEBCountour = face.getContour(FaceContour.RIGHT_EYEBROW_TOP);
            FaceContour rightBottomEBCountour = face.getContour(FaceContour.RIGHT_EYEBROW_BOTTOM);

            if (leftTopEBCountour != null) {
                cEyebrow.put("leftTop", pointsToList(leftTopEBCountour.getPoints()));
            }

            if (leftBottomEBCountour != null) {
                cEyebrow.put("leftBottom", pointsToList(leftBottomEBCountour.getPoints()));
            }

            if (rightTopEBCountour != null) {
                cEyebrow.put("rightTop", pointsToList(rightTopEBCountour.getPoints()));
            }

            if (rightBottomEBCountour != null) {
                cEyebrow.put("rightBottom", pointsToList(rightBottomEBCountour.getPoints()));
            }

            contour.put("eyebrow", cEyebrow);

            // Contour Nose
            FaceContour noseBridgeCountour = face.getContour(FaceContour.NOSE_BRIDGE);
            FaceContour noseBottomCountour = face.getContour(FaceContour.NOSE_BOTTOM);

            if (noseBridgeCountour != null) {
                cNose.put("bridge", pointsToList(noseBridgeCountour.getPoints()));
            }

            if (noseBottomCountour != null) {
                cNose.put("bottom", pointsToList(noseBottomCountour.getPoints()));
            }

            contour.put("nose", cNose);

            // Contour Cheek
            FaceContour leftCheekCountour = face.getContour(FaceContour.LEFT_CHEEK);
            FaceContour rightCheekCountour = face.getContour(FaceContour.RIGHT_CHEEK);

            if (leftCheekCountour != null) {
                cCheek.put("left", pointsToList(leftCheekCountour.getPoints()));
            }

            if (rightCheekCountour != null) {
                cCheek.put("right", pointsToList(rightCheekCountour.getPoints()));
            }

            contour.put("cheek", cCheek);

            // Contour Lip
            FaceContour upperTopLipCountour = face.getContour(FaceContour.UPPER_LIP_TOP);
            FaceContour upperBottomLipCountour = face.getContour(FaceContour.UPPER_LIP_BOTTOM);
            FaceContour lowerTopLipCountour = face.getContour(FaceContour.LOWER_LIP_TOP);
            FaceContour lowerBottomLipCountour = face.getContour(FaceContour.LOWER_LIP_BOTTOM);

            if (upperTopLipCountour != null) {
                cLip.put("upperTop", pointsToList(upperTopLipCountour.getPoints()));
            }

            if (upperBottomLipCountour != null) {
                cLip.put("upperBottom", pointsToList(upperBottomLipCountour.getPoints()));
            }

            if (lowerTopLipCountour != null) {
                cLip.put("lowerTop", pointsToList(lowerTopLipCountour.getPoints()));
            }

            if (lowerBottomLipCountour != null) {
                cLip.put("lowerBottom", pointsToList(lowerBottomLipCountour.getPoints()));
            }

            contour.put("lip", cLip);
            item.put("contour", contour);

            // If classification was enabled:
            if (face.getSmilingProbability() != null) {
                item.put("smile", face.getSmilingProbability());
            }

            Map<String, Object> eyeOpen = new HashMap<>();

            if (face.getLeftEyeOpenProbability() != null) {
                eyeOpen.put("left", face.getLeftEyeOpenProbability());
            }

            if (face.getRightEyeOpenProbability() != null) {
                eyeOpen.put("right", face.getRightEyeOpenProbability());
            }

            item.put("eyeOpen", eyeOpen);

            // If face tracking was enabled:
            if (face.getTrackingId() != null) {
                item.put("id", face.getTrackingId());
            }

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

    List<Map<String, Object>> pointsToList(@NonNull List<PointF> points) {
        List<Map<String, Object>> result = new ArrayList<>();
        for (PointF point : points) {
            result.add(pointToMap(point));
        }
        return result;
    }

    @Override
    public void dispose() {
        if (detector != null) {
            detector.close();
        }
    }
}
*/
