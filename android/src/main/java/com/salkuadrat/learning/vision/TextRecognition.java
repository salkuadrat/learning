/*
package com.salkuadrat.learning.vision;

import android.graphics.Point;
import android.graphics.Rect;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.vision.common.InputImage;
import com.google.mlkit.vision.text.Text;
import com.google.mlkit.vision.text.TextRecognizer;
import com.google.mlkit.vision.text.TextRecognizerOptions;
import com.salkuadrat.learning.VisionLearningInterface;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodChannel;

public class TextRecognition implements VisionLearningInterface {

    final TextRecognizer recognizer;

    public TextRecognition() {
        this.recognizer = com.google.mlkit.vision.text.TextRecognition.getClient();
    }

    @Override
    public void start(@NonNull InputImage image, @NonNull final MethodChannel.Result result) {
        recognizer.process(image)
            .addOnSuccessListener(new OnSuccessListener<Text>() {
                @Override
                public void onSuccess(Text visionText) {
                    process(visionText, result);
                }
            })
            .addOnFailureListener(
                new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        result.error("Text recognition failed!", e.getMessage(), e);
                    }
                });
    }

    private void process(Text text, MethodChannel.Result result) {
        String resultText = text.getText();
        List<String> results = new ArrayList<>();

        for (Text.TextBlock block : text.getTextBlocks()) {
            String blockText = block.getText();
            Point[] blockCornerPoints = block.getCornerPoints();
            Rect blockFrame = block.getBoundingBox();
            for (Text.Line line : block.getLines()) {
                String lineText = line.getText();
                Point[] lineCornerPoints = line.getCornerPoints();
                Rect lineFrame = line.getBoundingBox();
                for (Text.Element element : line.getElements()) {
                    String elementText = element.getText();
                    Point[] elementCornerPoints = element.getCornerPoints();
                    Rect elementFrame = element.getBoundingBox();
                    results.add(elementText);
                }
            }
        }

        result.success(results);
    }

    @Override
    public void dispose() {
        if (recognizer != null) {
            recognizer.close();
        }
    }
}
*/
