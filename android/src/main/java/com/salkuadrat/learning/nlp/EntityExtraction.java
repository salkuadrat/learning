/*
package com.salkuadrat.learning.nlp;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.nl.entityextraction.DateTimeEntity;
import com.google.mlkit.nl.entityextraction.Entity;
import com.google.mlkit.nl.entityextraction.EntityAnnotation;
import com.google.mlkit.nl.entityextraction.EntityExtractionParams;
import com.google.mlkit.nl.entityextraction.EntityExtractor;
import com.google.mlkit.nl.entityextraction.EntityExtractorOptions;
import com.google.mlkit.nl.entityextraction.FlightNumberEntity;
import com.google.mlkit.nl.entityextraction.IbanEntity;
import com.google.mlkit.nl.entityextraction.IsbnEntity;
import com.google.mlkit.nl.entityextraction.MoneyEntity;
import com.google.mlkit.nl.entityextraction.PaymentCardEntity;
import com.google.mlkit.nl.entityextraction.TrackingNumberEntity;
import com.salkuadrat.learning.NLPLearningInterface;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class EntityExtraction implements NLPLearningInterface {

    private final EntityExtractor extractor;

    public EntityExtraction(String modelId) {
        EntityExtractorOptions options = new EntityExtractorOptions.Builder(modelId)
            .build();
        this.extractor = com.google.mlkit.nl.entityextraction.EntityExtraction.getClient(options);
    }

    @Override
    public void start(@NonNull String text, @NonNull final MethodChannel.Result result) { }

    public void extract(
        final String text, final EntityExtractionParams params, final MethodChannel.Result result) {

        final Boolean isText = text != null && !text.isEmpty();
        final Boolean isParams = params != null;

        extractor.downloadModelIfNeeded()
            .addOnSuccessListener(new OnSuccessListener<Void>() {
                @Override
                public void onSuccess(@NonNull Void unused) {
                    if (isText) {
                        extractSimple(text, result);
                    } else if (isParams) {
                        extractWithParams(params, result);
                    }
                }
            })
            .addOnFailureListener(new OnFailureListener() {
                @Override
                public void onFailure(@NonNull Exception e) {
                    result.error("Entity extraction failed!", e.getMessage(), e);
                }
            });
    }

    private void extractSimple(
        final String text, final MethodChannel.Result result) {
        extractor.annotate(text)
            .addOnSuccessListener(new OnSuccessListener<List<EntityAnnotation>>() {
                @Override
                public void onSuccess(List<EntityAnnotation> annotations) {
                    process(annotations, result);
                }
            })
            .addOnFailureListener(new OnFailureListener() {
                @Override
                public void onFailure(@NonNull Exception e) {
                    result.error("Entity extraction failed!", e.getMessage(), e);
                }
            });
    }

    private void extractWithParams(
        final EntityExtractionParams params, final MethodChannel.Result result) {
        extractor.annotate(params)
            .addOnSuccessListener(new OnSuccessListener<List<EntityAnnotation>>() {
                @Override
                public void onSuccess(List<EntityAnnotation> annotations) {
                    process(annotations, result);
                }
            })
            .addOnFailureListener(new OnFailureListener() {
                @Override
                public void onFailure(@NonNull Exception e) {
                    result.error("Entity extraction failed!", e.getMessage(), e);
                }
            });
    }

    private void process(List<EntityAnnotation> annotations, MethodChannel.Result result) {
        List<List<Map<String, Object>>> results = new ArrayList<>();

        for (EntityAnnotation annotation : annotations) {
            List<Entity> entities = annotation.getEntities();
            List<Map<String, Object>> list = new ArrayList<>();

            for (Entity entity : entities) {
                Map<String, Object> values = new HashMap<>();
                switch (entity.getType()) {
                    case Entity.TYPE_DATE_TIME:
                        DateTimeEntity dateTimeEntity = entity.asDateTimeEntity();
                        values.put("type", "datetime");
                        values.put("granularity", dateTimeEntity.getDateTimeGranularity());
                        values.put("timestamp", dateTimeEntity.getTimestampMillis());
                        list.add(values);
                        break;
                    case Entity.TYPE_FLIGHT_NUMBER:
                        FlightNumberEntity flightNumberEntity = entity.asFlightNumberEntity();
                        values.put("type", "flight");
                        values.put("airline", flightNumberEntity.getAirlineCode());
                        values.put("flight", flightNumberEntity.getFlightNumber());
                        list.add(values);
                    case Entity.TYPE_MONEY:
                        MoneyEntity moneyEntity = entity.asMoneyEntity();
                        values.put("type", "money");
                        values.put("currency", moneyEntity.getUnnormalizedCurrency());
                        values.put("value", moneyEntity.getIntegerPart());
                        values.put("fraction", moneyEntity.getFractionalPart());
                        list.add(values);
                    case Entity.TYPE_IBAN:
                        IbanEntity ibanEntity = entity.asIbanEntity();
                        values.put("type", "iban");
                        values.put("iban", ibanEntity.getIban());
                        values.put("country", ibanEntity.getIbanCountryCode());
                        list.add(values);
                    case Entity.TYPE_ISBN:
                        IsbnEntity isbnEntity = entity.asIsbnEntity();
                        values.put("type", "isbn");
                        values.put("isbn", isbnEntity.getIsbn());
                        list.add(values);
                    case Entity.TYPE_PAYMENT_CARD:
                        PaymentCardEntity cardEntity = entity.asPaymentCardEntity();
                        values.put("type", "payment");
                        values.put("network", cardEntity.getPaymentCardNetwork());
                        values.put("number", cardEntity.getPaymentCardNumber());
                        list.add(values);
                    case Entity.TYPE_TRACKING_NUMBER:
                        TrackingNumberEntity trackingEntity = entity.asTrackingNumberEntity();
                        values.put("type", "tracking");
                        values.put("carrier", trackingEntity.getParcelCarrier());
                        values.put("number", trackingEntity.getParcelTrackingNumber());
                        list.add(values);
                    //case Entity.TYPE_ADDRESS:
                    //case Entity.TYPE_EMAIL:
                    //case Entity.TYPE_URL:
                    // case Entity.TYPE_PHONE:
                    default:
                }
            }

            results.add(list);
        }

        result.success(results);
    }

    @Override
    public void dispose() {
        if (extractor != null) {
            extractor.close();
        }
    }
}
*/
