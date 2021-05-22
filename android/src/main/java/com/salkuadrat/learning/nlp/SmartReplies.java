/*
package com.salkuadrat.learning.nlp;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.nl.smartreply.SmartReply;
import com.google.mlkit.nl.smartreply.SmartReplyGenerator;
import com.google.mlkit.nl.smartreply.SmartReplySuggestion;
import com.google.mlkit.nl.smartreply.SmartReplySuggestionResult;
import com.google.mlkit.nl.smartreply.TextMessage;
import com.salkuadrat.learning.NLPLearningInterface;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodChannel;

public class SmartReplies implements NLPLearningInterface {

    private final SmartReplyGenerator smartReply;
    private final List<TextMessage> conversation;

    public SmartReplies() {
        this.smartReply = SmartReply.getClient();
        this.conversation = new ArrayList<>();
    }

    public void addConversation(
        String userId, @NonNull long timestamp, @NonNull String text, @NonNull final MethodChannel.Result result) {

        TextMessage message;

        if (userId == null || userId.isEmpty()) {
            message = TextMessage.createForLocalUser(text, timestamp);
        } else {
            message = TextMessage.createForRemoteUser(text, timestamp, userId);
        }

        conversation.add(message);
        result.success("Push Smart Replies success!");
    }

    public void reply(@NonNull final MethodChannel.Result result) {
        smartReply.suggestReplies(conversation)
            .addOnSuccessListener(new OnSuccessListener<SmartReplySuggestionResult>() {
                @Override
                public void onSuccess(SmartReplySuggestionResult suggestion) {
                    int status = suggestion.getStatus();

                    if (status == SmartReplySuggestionResult.STATUS_NOT_SUPPORTED_LANGUAGE) {
                        result.error("Your conversation language isn't supported!", "", null);
                    } else if (status == SmartReplySuggestionResult.STATUS_SUCCESS) {
                        //result.success(suggestion.getSuggestions());
                        process(suggestion.getSuggestions(), result);
                    }
                }
            })
            .addOnFailureListener(new OnFailureListener() {
                @Override
                public void onFailure(@NonNull Exception e) {
                    result.error("Smart Reply failed!", e.getMessage(), e);
                }
            });
    }

    private void process(List<SmartReplySuggestion> suggestions, MethodChannel.Result result) {
        List<String> results = new ArrayList<>();

        for(SmartReplySuggestion suggestion : suggestions) {
            results.add(suggestion.getText());
        }

        result.success(results);
    }

    @Override
    public void start(@NonNull String text, final @NonNull MethodChannel.Result result) {
    }

    @Override
    public void dispose() {
        if (smartReply != null) {
            smartReply.close();
        }
    }
}
*/
