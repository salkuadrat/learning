/*
package com.salkuadrat.learning.nlp;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.common.model.DownloadConditions;
import com.google.mlkit.nl.translate.Translation;
import com.google.mlkit.nl.translate.Translator;
import com.google.mlkit.nl.translate.TranslatorOptions;
import com.salkuadrat.learning.NLPLearningInterface;

import io.flutter.plugin.common.MethodChannel;

public class TranslateText implements NLPLearningInterface {

    private final Translator translator;

    public TranslateText(@NonNull String source, @NonNull String target) {
        TranslatorOptions options =
            new TranslatorOptions.Builder()
                .setSourceLanguage(source)
                .setTargetLanguage(target)
                .build();
        this.translator = Translation.getClient(options);
    }

    @Override
    public void start(@NonNull String text, @NonNull final MethodChannel.Result result) {
        final String textToTranslate = text;
        DownloadConditions conditions = new DownloadConditions.Builder()
            .requireWifi()
            .build();

        translator.downloadModelIfNeeded(conditions)
            .addOnSuccessListener(
                new OnSuccessListener<Void>() {
                    @Override
                    public void onSuccess(Void v) {
                        translate(textToTranslate, result);
                    }
                })
            .addOnFailureListener(
                new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        result.error("Translation failed!", e.getMessage(), e);
                    }
                });
    }

    private void translate(String text, final MethodChannel.Result result) {
        translator.translate(text)
            .addOnSuccessListener(
                new OnSuccessListener<String>() {
                    @Override
                    public void onSuccess(@NonNull String translatedText) {
                        result.success(translatedText);
                    }
                })
            .addOnFailureListener(
                new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        result.error("Translation failed!", e.getMessage(), e);
                    }
                });
    }

    @Override
    public void dispose() {
        if (translator != null) {
            translator.close();
        }
    }
}
*/
