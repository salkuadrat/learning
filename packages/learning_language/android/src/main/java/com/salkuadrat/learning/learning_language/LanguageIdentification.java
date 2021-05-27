package com.salkuadrat.learning.learning_language;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.nl.languageid.IdentifiedLanguage;
import com.google.mlkit.nl.languageid.LanguageIdentificationOptions;
import com.google.mlkit.nl.languageid.LanguageIdentifier;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class LanguageIdentification {

    private final LanguageIdentifier identifier;
    private final boolean multi;

    public LanguageIdentification(float threshold, boolean multi) {
        LanguageIdentificationOptions options =
            new LanguageIdentificationOptions.Builder()
                .setConfidenceThreshold(threshold)
                .build();
        this.multi = multi;
        this.identifier = com.google.mlkit.nl.languageid.LanguageIdentification.getClient(options);
    }

    public void identify(@NonNull String text, @NonNull final MethodChannel.Result result) {
        if (multi) {
            identifyLanguages(text, result);
        } else {
            identifyLanguage(text, result);
        }
    }

    private void identifyLanguage(String text, final MethodChannel.Result result) {
        identifier.identifyLanguage(text)
            .addOnSuccessListener(
                new OnSuccessListener<String>() {
                    @Override
                    public void onSuccess(@Nullable String lang) {
                        result.success(lang);
                    }
                })
            .addOnFailureListener(
                new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        result.error("Language Identification failed!", e.getMessage(), e);
                    }
                });
    }

    private void identifyLanguages(String text, final MethodChannel.Result result) {
        identifier.identifyPossibleLanguages(text)
            .addOnSuccessListener(new OnSuccessListener<List<IdentifiedLanguage>>() {
                @Override
                public void onSuccess(List<IdentifiedLanguage> langs) {
                    List<Map<String, Object>> results = new ArrayList<>();

                    if (langs != null) {
                        for (IdentifiedLanguage lang : langs) {
                            Map<String, Object> item = new HashMap<>();
                            item.put("language", lang.getLanguageTag());
                            item.put("confidence", lang.getConfidence());
                            results.add(item);
                        }
                    }

                    result.success(results);
                }
            })
            .addOnFailureListener(
                new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        result.error("Language Identification failed!", e.getMessage(), e);
                    }
                });
    }

    public void dispose() {
        if (identifier != null) {
            identifier.close();
        }
    }
}
