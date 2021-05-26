package com.salkuadrat.learning.learning_digital_ink_recognition;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.common.MlKitException;
import com.google.mlkit.vision.digitalink.DigitalInkRecognitionModel;
import com.google.mlkit.vision.digitalink.DigitalInkRecognitionModelIdentifier;
import com.google.mlkit.vision.digitalink.DigitalInkRecognizer;
import com.google.mlkit.vision.digitalink.DigitalInkRecognizerOptions;
import com.google.mlkit.vision.digitalink.Ink;
import com.google.mlkit.vision.digitalink.RecognitionCandidate;
import com.google.mlkit.vision.digitalink.RecognitionResult;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class DigitalInkRecognition {

    private Ink.Builder inkBuilder;
    private Ink.Stroke.Builder strokeBuilder;
    private String language;
    private DigitalInkRecognizer recognizer;

    public DigitalInkRecognition(String language) {
        this.language = language;
    }

    public void start(@NonNull MethodChannel.Result result) {
        inkBuilder = Ink.builder();
        result.success(true);
    }

    public void actionDown(float x, float y, long t, @NonNull MethodChannel.Result result) {
        strokeBuilder = Ink.Stroke.builder();
        strokeBuilder.addPoint(Ink.Point.create(x, y, t));
        result.success(true);
    }

    public void actionMove(float x, float y, long t, @NonNull MethodChannel.Result result) {
        strokeBuilder.addPoint(Ink.Point.create(x, y, t));
        result.success(true);
    }

    public void actionUp(float x, float y, long t, @NonNull MethodChannel.Result result) {
        strokeBuilder.addPoint(Ink.Point.create(x, y, t));
        inkBuilder.addStroke(strokeBuilder.build());
        strokeBuilder = null;
        result.success(true);
    }

    private void initialize(@NonNull final MethodChannel.Result result) {
        if (recognizer == null) {
            try {
                DigitalInkRecognitionModelIdentifier modelIdentifier =
                    DigitalInkRecognitionModelIdentifier.fromLanguageTag(language);

                DigitalInkRecognitionModel model = DigitalInkRecognitionModel
                    .builder(modelIdentifier)
                    .build();

                DigitalInkRecognizerOptions options =
                    DigitalInkRecognizerOptions.builder(model).build();

                recognizer = com.google.mlkit.vision.digitalink.DigitalInkRecognition
                    .getClient(options);

            } catch (MlKitException e) {
                result.error("MLKitException", e.getMessage(), e);
            }
        }
    }

    public void process(@NonNull final MethodChannel.Result result) {
        initialize(result);

        Ink ink = inkBuilder.build();

        if (recognizer != null) {
            recognizer.recognize(ink)
                .addOnSuccessListener(new OnSuccessListener<RecognitionResult>() {
                    @Override
                    public void onSuccess(@NonNull RecognitionResult recognitionResult) {
                        process(recognitionResult, result);
                    }
                })
                .addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        result.error("Ink recognition failed!", e.getMessage(), e);
                    }
                });
        }
    }

    private void process(RecognitionResult recognitionResult, @NonNull MethodChannel.Result result) {
        List<Map<String, Object>> results = new ArrayList<>();
        List<RecognitionCandidate> candidates = recognitionResult.getCandidates();

        for (RecognitionCandidate candidate : candidates) {
            Map<String, Object> item = new HashMap<>();
            item.put("score", candidate.getScore());
            item.put("text", candidate.getText());
            results.add(item);
        }

        result.success(results);
    }

    public void dispose() {
        if (recognizer != null) {
            recognizer.close();
        }
    }
}