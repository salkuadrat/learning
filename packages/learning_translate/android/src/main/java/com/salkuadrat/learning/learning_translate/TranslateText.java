package com.salkuadrat.learning.learning_translate;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.common.model.DownloadConditions;
import com.google.mlkit.nl.translate.Translation;
import com.google.mlkit.nl.translate.Translator;
import com.google.mlkit.nl.translate.TranslatorOptions;

import io.flutter.plugin.common.MethodChannel;

public class TranslateText {

    private final Translator translator;
    private final boolean isDownloadRequireWifi;

    public TranslateText(@NonNull String source, @NonNull String target, boolean isDownloadRequireWifi) {
        TranslatorOptions options =
            new TranslatorOptions.Builder()
                .setSourceLanguage(source)
                .setTargetLanguage(target)
                .build();
        this.translator = Translation.getClient(options);
        this.isDownloadRequireWifi = isDownloadRequireWifi;
    }

    public void start(@NonNull String text, @NonNull final MethodChannel.Result result) {
        final String textToTranslate = text;
        DownloadConditions.Builder builder = new DownloadConditions.Builder();
        if (isDownloadRequireWifi) {
            builder.requireWifi();
        }
        DownloadConditions conditions = builder.build();

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

    /*private String toTranslateLanguage(String id) {
        switch (id) {
            case "af":
                return TranslateLanguage.AFRIKAANS;
            case "ar":
                return TranslateLanguage.ARABIC;
            case "be":
                return TranslateLanguage.BELARUSIAN;
            case "bg":
                return TranslateLanguage.BULGARIAN;
            case "bn":
                return TranslateLanguage.BENGALI;
            case "ca":
                return TranslateLanguage.CATALAN;
            case "cs":
                return TranslateLanguage.CZECH;
            case "cy":
                return TranslateLanguage.WELSH;
            case "da":
                return TranslateLanguage.DANISH;
            case "de":
                return TranslateLanguage.GERMAN;
            case "el":
                return TranslateLanguage.GREEK;
            case "en":
                return TranslateLanguage.ENGLISH;
            case "eo":
                return TranslateLanguage.ESPERANTO;
            case "es":
                return TranslateLanguage.SPANISH;
            case "et":
                return TranslateLanguage.ESTONIAN;
            case "fa":
                return TranslateLanguage.PERSIAN;
            case "fi":
                return TranslateLanguage.FINNISH;
            case "fr":
                return TranslateLanguage.FRENCH;
            case "ga":
                return TranslateLanguage.IRISH;
            case "gl":
                return TranslateLanguage.GALICIAN;
            case "gu":
                return TranslateLanguage.GUJARATI;
            case "he":
                return TranslateLanguage.HEBREW;
            case "hi":
                return TranslateLanguage.HINDI;
            case "hr":
                return TranslateLanguage.CROATIAN;
            case "ht":
                return TranslateLanguage.HAITIAN_CREOLE;
            case "hu":
                return TranslateLanguage.HUNGARIAN;
            case "id":
                return TranslateLanguage.INDONESIAN;
            case "is":
                return TranslateLanguage.ICELANDIC;
            case "it":
                return TranslateLanguage.ITALIAN;
            case "ja":
                return TranslateLanguage.JAPANESE;
            case "ka":
                return TranslateLanguage.GEORGIAN;
            case "kn":
                return TranslateLanguage.KANNADA;
            case "ko":
                return TranslateLanguage.KOREAN;
            case "lt":
                return TranslateLanguage.LITHUANIAN;
            case "lv":
                return TranslateLanguage.LATVIAN;
            case "mk":
                return TranslateLanguage.MACEDONIAN;
            case "mr":
                return TranslateLanguage.MARATHI;
            case "ms":
                return TranslateLanguage.MALAY;
            case "mt":
                return TranslateLanguage.MALTESE;
            case "nl":
                return TranslateLanguage.DUTCH;
            case "no":
                return TranslateLanguage.NORWEGIAN;
            case "pl":
                return TranslateLanguage.POLISH;
            case "pt":
                return TranslateLanguage.PORTUGUESE;
            case "ro":
                return TranslateLanguage.ROMANIAN;
            case "ru":
                return TranslateLanguage.RUSSIAN;
            case "sk":
                return TranslateLanguage.SLOVAK;
            case "sl":
                return TranslateLanguage.SLOVENIAN;
            case "sq":
                return TranslateLanguage.ALBANIAN;
            case "sv":
                return TranslateLanguage.SWEDISH;
            case "sw":
                return TranslateLanguage.SWAHILI;
            case "ta":
                return TranslateLanguage.TAMIL;
            case "te":
                return TranslateLanguage.TELUGU;
            case "th":
                return TranslateLanguage.THAI;
            case "tl":
                return TranslateLanguage.TAGALOG;
            case "tr":
                return TranslateLanguage.TURKISH;
            case "uk":
                return TranslateLanguage.UKRAINIAN;
            case "ur":
                return TranslateLanguage.URDU;
            case "vi":
                return TranslateLanguage.VIETNAMESE;
            case "zh":
                return TranslateLanguage.CHINESE;
            default:
                return id;
        }
    }*/

    public void dispose() {
        if (translator != null) {
            translator.close();
        }
    }
}
