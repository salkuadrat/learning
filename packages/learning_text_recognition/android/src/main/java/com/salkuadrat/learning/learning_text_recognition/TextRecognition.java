package com.salkuadrat.learning.learning_text_recognition;

import android.graphics.Point;
import android.graphics.Rect;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.vision.common.InputImage;
import com.google.mlkit.vision.text.Text;
import com.google.mlkit.vision.text.TextRecognizer;
import com.google.mlkit.vision.text.latin.TextRecognizerOptions;
import com.google.mlkit.vision.text.chinese.ChineseTextRecognizerOptions;
import com.google.mlkit.vision.text.devanagari.DevanagariTextRecognizerOptions;
import com.google.mlkit.vision.text.japanese.JapaneseTextRecognizerOptions;
import com.google.mlkit.vision.text.korean.KoreanTextRecognizerOptions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class TextRecognition  {

    final TextRecognizer recognizer;

    public TextRecognition(String options) {
        if (options == "chinese") {
            this.recognizer = com.google.mlkit.vision.text.TextRecognition.getClient(new ChineseTextRecognizerOptions.Builder().build());
        } else if (options == "devanagari") {
            this.recognizer = com.google.mlkit.vision.text.TextRecognition.getClient(new DevanagariTextRecognizerOptions.Builder().build());
        } else if (options == "japanese") {
            this.recognizer = com.google.mlkit.vision.text.TextRecognition.getClient(new JapaneseTextRecognizerOptions.Builder().build());
        } else if (options == "korean") {
            this.recognizer = com.google.mlkit.vision.text.TextRecognition.getClient(new KoreanTextRecognizerOptions.Builder().build());
        } else {
            this.recognizer = com.google.mlkit.vision.text.TextRecognition.getClient(TextRecognizerOptions.DEFAULT_OPTIONS);
        }
    }

    public void process(@NonNull InputImage image, @NonNull final MethodChannel.Result result) {
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
        Map<String, Object> results = new HashMap<>();
        results.put("text", text.getText());

        List<Map<String, Object>> blocksData = new ArrayList<>();

        for (Text.TextBlock block : text.getTextBlocks()) {
            Map<String, Object> blockData = new HashMap<>();
            blockData.put("text", block.getText());
            blockData.put("cornerPoints", pointsToList(block.getCornerPoints()));
            blockData.put("frame", rectToMap(block.getBoundingBox()));
            blockData.put("language", block.getRecognizedLanguage());

            List<Map<String, Object>> linesData = new ArrayList<>();

            for (Text.Line line : block.getLines()) {
                Map<String, Object> lineData = new HashMap<>();
                lineData.put("text", line.getText());
                lineData.put("cornerPoints", pointsToList(line.getCornerPoints()));
                lineData.put("frame", rectToMap(line.getBoundingBox()));
                lineData.put("language", line.getRecognizedLanguage());

                List<Map<String, Object>> elementsData = new ArrayList<>();
                for (Text.Element element : line.getElements()) {
                    Map<String, Object> elementData = new HashMap<>();
                    elementData.put("text", element.getText());
                    elementData.put("cornerPoints", pointsToList(element.getCornerPoints()));
                    elementData.put("frame", rectToMap(element.getBoundingBox()));
                    elementData.put("language", element.getRecognizedLanguage());
                    elementsData.add(elementData);
                }
                lineData.put("elements", elementsData);
                linesData.add(lineData);
            }

            blockData.put("lines", linesData);
            blocksData.add(blockData);
        }
        results.put("blocks", blocksData);
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

    Map<String, Object> pointToMap(@NonNull Point point) {
        Map<String, Object> result = new HashMap<>();
        result.put("x", point.x);
        result.put("y", point.y);
        return result;
    }

    List<Map<String, Object>> pointsToList(@NonNull Point[] points) {
        List<Map<String, Object>> result = new ArrayList<>();
        for (Point point : points) {
            result.add(pointToMap(point));
        }
        return result;
    }
    
    public void dispose() {
        if (recognizer != null) {
            recognizer.close();
        }
    }
}
