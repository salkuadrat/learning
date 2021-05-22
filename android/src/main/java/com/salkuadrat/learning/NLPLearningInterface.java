package com.salkuadrat.learning;

import androidx.annotation.NonNull;

import io.flutter.plugin.common.MethodChannel;

public interface NLPLearningInterface extends LearningInterface {
    void start(@NonNull String text, @NonNull final MethodChannel.Result result);
}
