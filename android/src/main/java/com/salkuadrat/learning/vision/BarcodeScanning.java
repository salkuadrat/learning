/*
package com.salkuadrat.learning.vision;

import android.graphics.Point;
import android.graphics.Rect;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.vision.barcode.Barcode;
import com.google.mlkit.vision.barcode.BarcodeScanner;
import com.google.mlkit.vision.barcode.BarcodeScannerOptions;
import com.google.mlkit.vision.common.InputImage;
import com.salkuadrat.learning.VisionLearningInterface;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class BarcodeScanning implements VisionLearningInterface {

    private final BarcodeScanner scanner;

    public BarcodeScanning(int[] formats) {
        BarcodeScannerOptions options =
            new BarcodeScannerOptions.Builder()
                .setBarcodeFormats(
                    formats[0], Arrays.copyOfRange(formats, 1, formats.length))
                .build();
        this.scanner = com.google.mlkit.vision.barcode.BarcodeScanning.getClient(options);
    }

    @Override
    public void start(@NonNull InputImage image, @NonNull final MethodChannel.Result result) {
        scanner.process(image)
            .addOnSuccessListener(new OnSuccessListener<List<Barcode>>() {
                @Override
                public void onSuccess(List<Barcode> barcodes) {
                    process(barcodes, result);
                }
            })
            .addOnFailureListener(new OnFailureListener() {
                @Override
                public void onFailure(@NonNull Exception e) {
                    result.error("Barcode scanning failed!", e.getMessage(), e);
                }
            });
    }

    private void process(List<Barcode> barcodes, MethodChannel.Result result) {
        List<Map<String, Object>> results = new ArrayList<>();

        for (Barcode barcode : barcodes) {
            Rect bounds = barcode.getBoundingBox();
            Point[] corners = barcode.getCornerPoints();

            Map<String, Object> item = new HashMap<>();
            item.put("rawValue", barcode.getRawValue());

            Map<String, Object> itemBounds = new HashMap<>();
            if (bounds != null) {
                itemBounds.put("top", bounds.top);
                itemBounds.put("left", bounds.left);
                itemBounds.put("right", bounds.right);
                itemBounds.put("bottom", bounds.bottom);
            }
            item.put("bounds", itemBounds);

            List<Map<String, Object>> itemCorners = new ArrayList<>();
            if (corners != null) {
                for (Point corner : corners) {
                    Map<String, Object> itemCorner = new HashMap<>();
                    itemCorner.put("x", corner.x);
                    itemCorner.put("y", corner.y);
                    itemCorners.add(itemCorner);
                }
            }
            item.put("corners", itemCorners);

            int valueType = barcode.getValueType();
            // See API reference for complete list of supported types
            switch (valueType) {
                case Barcode.TYPE_WIFI:
                    if(barcode.getWifi() != null) {
                        item.put("type", "WIFI");
                        item.put("ssid", barcode.getWifi().getSsid());
                        item.put("password", barcode.getWifi().getPassword());

                        int encryption = barcode.getWifi().getEncryptionType();

                        if (encryption == Barcode.WiFi.TYPE_OPEN) {
                            item.put("encryption", "OPEN");
                        } else if (encryption == Barcode.WiFi.TYPE_WEP) {
                            item.put("encryption", "WEP");
                        } else if (encryption == Barcode.WiFi.TYPE_WPA) {
                            item.put("encryption", "WPA");
                        }

                        results.add(item);
                    }
                    break;
                case Barcode.TYPE_URL:
                    if (barcode.getUrl() != null) {
                        item.put("type", "URL");
                        item.put("title", barcode.getUrl().getTitle());
                        item.put("url", barcode.getUrl().getUrl());
                        results.add(item);
                    }
                    break;
                case Barcode.TYPE_TEXT:
                    item.put("type", "TEXT");
                    item.put("value", barcode.getDisplayValue());
                    results.add(item);
                    break;
                case Barcode.TYPE_SMS:
                    if (barcode.getSms() != null) {
                        item.put("type", "SMS");
                        item.put("number", barcode.getSms().getPhoneNumber());
                        item.put("message", barcode.getSms().getMessage());
                        results.add(item);
                    }
                    break;
                case Barcode.TYPE_EMAIL:
                    if (barcode.getEmail() != null) {
                        int type = barcode.getEmail().getType();
                        item.put("type", "EMAIL");
                        item.put("address", barcode.getEmail().getAddress());
                        item.put("subject", barcode.getEmail().getSubject());
                        item.put("body", barcode.getEmail().getBody());

                        if (type == Barcode.Email.TYPE_WORK) {
                            item.put("emailType", "WORK");
                        } else if (type == Barcode.Email.TYPE_HOME) {
                            item.put("emailType", "HOME");
                        } else {
                            item.put("emailType", "UNKNOWN");
                        }

                        results.add(item);
                    }
                    break;
                case Barcode.TYPE_PHONE:
                    if (barcode.getPhone() != null) {
                        item.put("type", "PHONE");
                        item.put("number", barcode.getPhone().getNumber());
                        int phoneType = barcode.getPhone().getType();

                        if (phoneType == Barcode.Phone.TYPE_FAX) {
                            item.put("phoneType", "FAX");
                        } else if (phoneType == Barcode.Phone.TYPE_HOME) {
                            item.put("phoneType", "HOME");
                        } else if (phoneType == Barcode.Phone.TYPE_MOBILE) {
                            item.put("phoneType", "MOBILE");
                        } else if (phoneType == Barcode.Phone.TYPE_WORK) {
                            item.put("phoneType", "WORK");
                        } else {
                            item.put("phoneType", "UNKNOWN");
                        }
                        results.add(item);
                    }
                    break;
                case Barcode.TYPE_CALENDAR_EVENT:
                    if (barcode.getCalendarEvent() != null) {
                        item.put("type", "CALENDAR_EVENT");
                        item.put("status", barcode.getCalendarEvent().getStatus());
                        item.put("summary", barcode.getCalendarEvent().getSummary());
                        item.put("description", barcode.getCalendarEvent().getDescription());
                        item.put("location", barcode.getCalendarEvent().getLocation());
                        item.put("start", barcode.getCalendarEvent().getStart());
                        item.put("end", barcode.getCalendarEvent().getEnd());
                        item.put("organizer", barcode.getCalendarEvent().getOrganizer());
                        results.add(item);
                    }
                    break;
                case Barcode.TYPE_CONTACT_INFO:
                    if (barcode.getContactInfo() != null) {
                        item.put("type", "CONTACT");
                        item.put("title", barcode.getContactInfo().getTitle());
                        item.put("name", barcode.getContactInfo().getName().getFormattedName());
                        item.put("organization", barcode.getContactInfo().getOrganization());
                        item.put("emails", barcode.getContactInfo().getEmails());
                        item.put("phones", barcode.getContactInfo().getPhones());
                        item.put("addresses", barcode.getContactInfo().getAddresses());
                        item.put("urls", barcode.getContactInfo().getUrls());
                        results.add(item);
                    }
                    break;
                case Barcode.TYPE_DRIVER_LICENSE:
                    if (barcode.getDriverLicense() != null) {
                        item.put("type", "DRIVER");
                        item.put("documentType", barcode.getDriverLicense().getDocumentType());
                        item.put("licenseNumber", barcode.getDriverLicense().getLicenseNumber());
                        item.put("firstName", barcode.getDriverLicense().getFirstName());
                        item.put("middleName", barcode.getDriverLicense().getMiddleName());
                        item.put("lastName", barcode.getDriverLicense().getLastName());
                        item.put("gender", barcode.getDriverLicense().getGender());
                        item.put("birthDate", barcode.getDriverLicense().getBirthDate());
                        item.put("street", barcode.getDriverLicense().getAddressStreet());
                        item.put("city", barcode.getDriverLicense().getAddressCity());
                        item.put("state", barcode.getDriverLicense().getAddressState());
                        item.put("zip", barcode.getDriverLicense().getAddressZip());
                        item.put("issueDate", barcode.getDriverLicense().getIssueDate());
                        item.put("expiryDate", barcode.getDriverLicense().getExpiryDate());
                        item.put("issuingCountry", barcode.getDriverLicense().getIssuingCountry());
                        results.add(item);
                    }
                    break;
                case Barcode.TYPE_GEO:
                    if (barcode.getGeoPoint() != null) {
                        item.put("type", "GEO");
                        item.put("latitude", barcode.getGeoPoint().getLat());
                        item.put("longitude", barcode.getGeoPoint().getLng());
                        results.add(item);
                    }
                    break;
                case Barcode.TYPE_ISBN:
                case Barcode.TYPE_PRODUCT:
                case Barcode.TYPE_UNKNOWN:
                default:
                    break;
            }
        }

        result.success(results);
    }

    @Override
    public void dispose() {
        if (scanner != null) {
            scanner.close();
        }
    }
}
*/
