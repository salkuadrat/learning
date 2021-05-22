package com.salkuadrat.learning.learning_entity_extraction;

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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class EntityExtraction {

    private final EntityExtractor extractor;

    public EntityExtraction(String model) {
        EntityExtractorOptions options = new EntityExtractorOptions.Builder(model).build();
        this.extractor = com.google.mlkit.nl.entityextraction.EntityExtraction
            .getClient(options);
    }

    public void extract(
        final String text, final EntityExtractionParams params,
        @NonNull final MethodChannel.Result result) {

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
        List<Map<String, Object>> results = new ArrayList<>();

        for (EntityAnnotation annotation : annotations) {
            Map<String, Object> annotationData = new HashMap<>();
            annotationData.put("annotation", annotation.getAnnotatedText());
            annotationData.put("start", annotation.getStart());
            annotationData.put("end", annotation.getEnd());

            List<Map<String, Object>> entitiesData = new ArrayList<>();
            for (Entity entity : annotation.getEntities()) {
                Map<String, Object> values = new HashMap<>();
                switch (entity.getType()) {
                    case Entity.TYPE_DATE_TIME:
                        DateTimeEntity dateTimeEntity = entity.asDateTimeEntity();
                        if (dateTimeEntity != null) {
                            values.put("type", "datetime");
                            values.put("granularity", dateTimeEntity.getDateTimeGranularity());
                            values.put("timestamp", dateTimeEntity.getTimestampMillis());
                            entitiesData.add(values);
                        }
                        break;
                    case Entity.TYPE_FLIGHT_NUMBER:
                        FlightNumberEntity flightNumberEntity = entity.asFlightNumberEntity();
                        if (flightNumberEntity != null) {
                            values.put("type", "flight");
                            values.put("airline", flightNumberEntity.getAirlineCode());
                            values.put("flight", flightNumberEntity.getFlightNumber());
                            entitiesData.add(values);
                        }
                        break;
                    case Entity.TYPE_MONEY:
                        MoneyEntity moneyEntity = entity.asMoneyEntity();
                        if (moneyEntity != null) {
                            values.put("type", "money");
                            values.put("currency", moneyEntity.getUnnormalizedCurrency());
                            values.put("value", moneyEntity.getIntegerPart());
                            values.put("fraction", moneyEntity.getFractionalPart());
                            entitiesData.add(values);
                        }
                        break;
                    case Entity.TYPE_IBAN:
                        IbanEntity ibanEntity = entity.asIbanEntity();
                        if (ibanEntity != null) {
                            values.put("type", "iban");
                            values.put("iban", ibanEntity.getIban());
                            values.put("country", ibanEntity.getIbanCountryCode());
                            entitiesData.add(values);
                        }
                        break;
                    case Entity.TYPE_ISBN:
                        IsbnEntity isbnEntity = entity.asIsbnEntity();
                        if (isbnEntity != null) {
                            values.put("type", "isbn");
                            values.put("isbn", isbnEntity.getIsbn());
                            entitiesData.add(values);
                        }
                        break;
                    case Entity.TYPE_PAYMENT_CARD:
                        PaymentCardEntity cardEntity = entity.asPaymentCardEntity();
                        if (cardEntity != null) {
                            values.put("type", "payment");
                            values.put("network", cardEntity.getPaymentCardNetwork());
                            values.put("number", cardEntity.getPaymentCardNumber());
                            entitiesData.add(values);
                        }
                        break;
                    case Entity.TYPE_TRACKING_NUMBER:
                        TrackingNumberEntity trackingEntity = entity.asTrackingNumberEntity();
                        if (trackingEntity != null) {
                            values.put("type", "tracking");
                            values.put("carrier", trackingEntity.getParcelCarrier());
                            values.put("number", trackingEntity.getParcelTrackingNumber());
                            entitiesData.add(values);
                        }
                        break;
                    case Entity.TYPE_ADDRESS:
                        values.put("type", "address");
                        values.put("address", annotation.getAnnotatedText());
                        entitiesData.add(values);
                        break;
                    case Entity.TYPE_EMAIL:
                        values.put("type", "email");
                        values.put("email", annotation.getAnnotatedText());
                        entitiesData.add(values);
                        break;
                    case Entity.TYPE_URL:
                        values.put("type", "url");
                        values.put("url", annotation.getAnnotatedText());
                        entitiesData.add(values);
                        break;
                    case Entity.TYPE_PHONE:
                        values.put("type", "phone");
                        values.put("phone", annotation.getAnnotatedText());
                        entitiesData.add(values);
                        break;
                    default:
                }
            }

            annotationData.put("entities", entitiesData);
            results.add(annotationData);
        }

        result.success(results);
    }

    public void dispose() {
        if (extractor != null) {
            extractor.close();
        }
    }
}
