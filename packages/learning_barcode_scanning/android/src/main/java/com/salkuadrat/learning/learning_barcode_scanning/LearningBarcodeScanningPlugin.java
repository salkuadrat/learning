package com.salkuadrat.learning.learning_barcode_scanning;

import android.content.Context;
import android.net.Uri;

import androidx.annotation.NonNull;

import com.google.mlkit.vision.barcode.Barcode;
import com.google.mlkit.vision.common.InputImage;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * LearningBarcodeScanningPlugin
 */
public class LearningBarcodeScanningPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private BarcodeScanning barcodeScanning;
    private Context applicationContext;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        applicationContext = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "LearningBarcodeScanning");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "scan":
                scan(call, result);
                break;
            case "dispose":
                dispose(result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void scan(@NonNull MethodCall call, @NonNull Result result) {
        InputImage image = getInputImage(call, result);
        String formats = call.argument("formats");

        if (formats != null) {
            String[] formatItems = formats.split(",");
            int count = formatItems.length;

            int[] formatValues = new int[count];

            for (int i = 0; i < count; i++) {
                String fmt = formatItems[i];

                switch (fmt) {
                    case "codabar":
                        formatValues[i] = Barcode.FORMAT_CODABAR;
                        break;
                    case "code39":
                        formatValues[i] = Barcode.FORMAT_CODE_39;
                        break;
                    case "code93":
                        formatValues[i] = Barcode.FORMAT_CODE_93;
                        break;
                    case "code128":
                        formatValues[i] = Barcode.FORMAT_CODE_128;
                        break;
                    case "ean-8":
                        formatValues[i] = Barcode.FORMAT_EAN_8;
                        break;
                    case "ean-13":
                        formatValues[i] = Barcode.FORMAT_EAN_13;
                        break;
                    case "itf":
                        formatValues[i] = Barcode.FORMAT_ITF;
                        break;
                    case "upc-a":
                        formatValues[i] = Barcode.FORMAT_UPC_A;
                        break;
                    case "upc-e":
                        formatValues[i] = Barcode.FORMAT_UPC_E;
                        break;
                    case "aztec":
                        formatValues[i] = Barcode.FORMAT_AZTEC;
                        break;
                    case "matrix":
                        formatValues[i] = Barcode.FORMAT_DATA_MATRIX;
                        break;
                    case "pdf417":
                        formatValues[i] = Barcode.FORMAT_PDF417;
                        break;
                    case "qrcode":
                        formatValues[i] = Barcode.FORMAT_QR_CODE;
                        break;
                }
            }

            if (image != null) {
                barcodeScanning = new BarcodeScanning(formatValues);
                barcodeScanning.scan(image, result);
            }
        }
    }

    private InputImage getInputImage(MethodCall call, Result result) {
        Map<String, Object> data = call.argument("image");

        if (data != null) {
            try {
                return getInputImage(data, result);
            } catch (Exception e) {
                e.printStackTrace();
                result.error("Image data invalid!", e.getMessage(), e);
            }
        }

        return null;
    }

    private InputImage getInputImage(@NonNull Map<String, Object> data, Result result) {
        // file or bytes
        String type = (String) data.get("type");
        InputImage inputImage;

        if (type != null) {
            if (type.equals("file")) {
                try {
                    String path = (String) data.get("path");
                    if (path != null) {
                        File file = new File(path);
                        Uri uri = Uri.fromFile(file);
                        inputImage = InputImage.fromFilePath(applicationContext, uri);
                        return inputImage;
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                    result.error("Image data error", e.getMessage(), e);
                    return null;
                }
            } else if (type.equals("bytes")) {
                Map metaData = (Map) data.get("metadata");

                if (metaData != null) {
                    Object _bytes = data.get("bytes");
                    Double _width = (Double) metaData.get("width");
                    Double _height = (Double) metaData.get("height");
                    Integer _rotation = (Integer) metaData.get("rotation");
                    Integer _imageFormat = (Integer) metaData.get("imageFormat");

                    if (_bytes != null) {
                        inputImage = InputImage.fromByteArray(
                            (byte[]) _bytes,
                            _width != null ? _width.intValue() : 0,
                            _height != null ? _height.intValue() : 0,
                            _rotation != null ? _rotation : 0,
                            _imageFormat != null ? _imageFormat : 0
                        );

                        return inputImage;
                    }
                }
            }
        }

        result.error("Invalid Image Data", null, null);
        return null;
    }

    private void dispose(@NonNull Result result) {
        if (barcodeScanning != null) {
            barcodeScanning.dispose();
        }
        result.success(true);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
