package com.salkuadrat.learning;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

//import com.google.mlkit.vision.barcode.Barcode;
//import com.google.mlkit.vision.common.InputImage;
//import com.google.mlkit.vision.face.FaceDetectorOptions;
//import com.salkuadrat.learning.nlp.EntityExtraction;
//import com.salkuadrat.learning.nlp.LanguageIdentification;
//import com.salkuadrat.learning.nlp.SmartReplies;
//import com.salkuadrat.learning.nlp.TranslateText;
//import com.salkuadrat.learning.vision.BarcodeScanning;
//import com.salkuadrat.learning.vision.DigitalInkRecognition;
//import com.salkuadrat.learning.vision.FaceDetection;
//import com.salkuadrat.learning.vision.ImageLabeling;
//import com.salkuadrat.learning.vision.ObjectDetection;
//import com.salkuadrat.learning.vision.PoseDetection;
//import com.salkuadrat.learning.vision.SelfieSegmentation;
//import com.salkuadrat.learning.vision.TextRecognition;

/**
 * LearningPlugin
 */
public class LearningPlugin implements FlutterPlugin, MethodCallHandler {

    //final String LANGUAGE_IDENTIFICATION = "LanguageIdentification";
    //final String TRANSLATE_TEXT = "TranslateText";
    //final String ENTITY_EXTRACTION = "EntityExtraction";
    //final String SMART_REPLIES = "SmartReplies";
    //final String SMART_REPLIES_PUSH = "PushSmartReplies";
    //final String TEXT_RECOGNITION = "TextRecognition";
    //final String FACE_DETECTION = "FaceDetection";
    //final String POSE_DETECTION = "PoseDetection";
    //final String SELFIE_SEGMENTATION = "SelfieSegmentation";
    //final String BARCODE_SCANNING = "BarcodeScanning";
    //final String IMAGE_LABELING = "ImageLabeling";
    //final String OBJECT_DETECTION = "ObjectDetection";
    //final String DIGITAL_INK_RECOGNITION = "DigitalInkRecognition";

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    //private Context ctx;

    //private LanguageIdentification languageIdentification;
    //private TranslateText translateText;
    //private SmartReplies smartReplies;
    //private EntityExtraction entityExtraction;
    //private TextRecognition textRecognition;
    //private FaceDetection faceDetection;
    //private PoseDetection poseDetection;
    //private SelfieSegmentation selfieSegmentation;
    //private BarcodeScanning barcodeScanning;
    //private ImageLabeling imageLabeling;
    //private ObjectDetection objectDetection;
    //private DigitalInkRecognition digitalInkRecognition;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        //ctx = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "Learning");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        /*String method = call.method;

        if (method.startsWith("dispose")) {
            dispose(method);
        } else if (method.startsWith("v")) {
            method = method.replaceFirst("v", "");
            onMethodVision(method, call, result);
        } else if (method.startsWith("n")) {
            method = method.replaceFirst("n", "");
            onMethodNLP(method, call, result);
        } else {
            result.notImplemented();
        }*/
    }

    /*private void onMethodVision(String method, @NonNull MethodCall call, Result result) {
        switch (method) {
            case TEXT_RECOGNITION:
                handleTextRecognition(call, result);
                break;
            case FACE_DETECTION:
                handleFaceDetection(call, result);
                break;
            case POSE_DETECTION:
                handlePoseDetection(call, result);
                break;
            case SELFIE_SEGMENTATION:
                handleSelfieSegmentation(call, result);
                break;
            case BARCODE_SCANNING:
                handleBarcodeScanning(call, result);
                break;
            case IMAGE_LABELING:
                handleImageLabeling(call, result);
                break;
            case OBJECT_DETECTION:
                handleObjectDetection(call, result);
                break;
            case DIGITAL_INK_RECOGNITION:
                handleDigitalInkRecognition(call, result);
                break;
            default:
                break;
        }
    }*/

    private void onMethodNLP(String method, @NonNull MethodCall call, Result result) {
        switch (method) {
            /*case LANGUAGE_IDENTIFICATION:
                handleLanguageIdentification(call, result);
                break;*/
            /*case TRANSLATE_TEXT:
                handleTranslateText(call, result);
                break;*/
            /*case ENTITY_EXTRACTION:
                handleEntityExtraction(call, result);
                break;*/
            /*case SMART_REPLIES:
                handleSmartReplies(result);
                break;*/
            /*case SMART_REPLIES_PUSH:
                handlePushSmartReplies(call, result);
                break;*/
            default:
                break;
        }
    }

    /*private void handleLanguageIdentification(@NonNull MethodCall call, Result result) {
        String text = call.argument("text");
        Float _threshold = call.argument("confidenceThreshold");
        Boolean _multi = call.argument("isMultipleLanguages");

        float threshold = _threshold != null ? _threshold : 0.5f;
        boolean multi = _multi != null && _multi;

        if (text != null) {
            languageIdentification = new LanguageIdentification(threshold, multi);
            languageIdentification.start(text, result);
        }
    }*/

    /*private void handleTranslateText(@NonNull MethodCall call, Result result) {
        String source = call.argument("from");
        String target = call.argument("to");
        String text = call.argument("text");

        if (source != null && target != null && text != null) {
            translateText = new TranslateText(source, target);
            translateText.start(text, result);
        }
    }*/

    /*private void handlePushSmartReplies(@NonNull MethodCall call, Result result) {
        if (smartReplies == null) {
            smartReplies = new SmartReplies();
        }

        String userId = call.argument("user");
        String text = call.argument("text");
        long timestamp = call.argument("timestamp");

        if (text != null) {
            smartReplies.addConversation(userId, timestamp, text, result);
        }
    }*/

    /*private void handleSmartReplies(Result result) {
        if (smartReplies != null) {
            smartReplies.reply(result);
        }
    }*/

    /*private void handleEntityExtraction(@NonNull MethodCall call, Result result) {
        String modelId = call.argument("model");
        String text = call.argument("text");

        if (text != null) {
            entityExtraction = new EntityExtraction(modelId);
            entityExtraction.extract(text, null, result);
        }
    }*/

    /*private void handleTextRecognition(MethodCall call, Result result) {
        InputImage image = getInputImage(call, result);

        if (image != null) {
            textRecognition = new TextRecognition();
            textRecognition.start(image, result);
        }
    }*/

    /*private void handleFaceDetection(MethodCall call, Result result) {
        InputImage image = getInputImage(call, result);
        Float _minFaceSize = call.argument("minFaceSize");
        Boolean _tracking = call.argument("enableTracking");

        float minFaceSize = _minFaceSize != null ? _minFaceSize : 0.15f;
        String performance = call.argument("performance");
        String landmark = call.argument("landmark");
        String classification = call.argument("classification");
        String contour = call.argument("contour");
        boolean tracking = _tracking != null && _tracking;

        int performanceMode = performance != null && performance.equals("accurate")
            ? FaceDetectorOptions.PERFORMANCE_MODE_ACCURATE
            : FaceDetectorOptions.PERFORMANCE_MODE_FAST;

        int classificationMode = classification != null && classification.equals("all")
            ? FaceDetectorOptions.CLASSIFICATION_MODE_ALL
            : FaceDetectorOptions.CLASSIFICATION_MODE_NONE;

        int landmarkMode = landmark != null && landmark.equals("all")
            ? FaceDetectorOptions.LANDMARK_MODE_ALL
            : FaceDetectorOptions.LANDMARK_MODE_NONE;

        int contourMode = contour != null && contour.equals("all")
            ? FaceDetectorOptions.CONTOUR_MODE_ALL
            : FaceDetectorOptions.CONTOUR_MODE_NONE;

        if (image != null) {
            faceDetection = new FaceDetection(minFaceSize,
                performanceMode, classificationMode, landmarkMode, contourMode, tracking);
            faceDetection.start(image, result);
        }
    }*/

    /*private void handlePoseDetection(MethodCall call, Result result) {
        InputImage image = getInputImage(call, result);
        Boolean _isStream = call.argument("isStream");
        boolean isStream = _isStream != null && _isStream;

        if (image != null) {
            poseDetection = new PoseDetection(isStream);
            poseDetection.start(image, result);
        }
    }*/

    /*private void handleSelfieSegmentation(MethodCall call, Result result) {
        InputImage image = getInputImage(call, result);
        Boolean _isStream = call.argument("isStream");
        Boolean _enableRawSizeMask = call.argument("enableRawSizeMask");

        boolean isStream = _isStream != null && _isStream;
        boolean enableRawSizeMask = _enableRawSizeMask != null && _enableRawSizeMask;

        if (image != null) {
            selfieSegmentation = new SelfieSegmentation(isStream, enableRawSizeMask);
            selfieSegmentation.start(image, result);
        }
    }*/

    /*private void handleBarcodeScanning(MethodCall call, Result result) {
        InputImage image = getInputImage(call, result);
        String formats = call.argument("formats");

        if (formats != null) {
            int count = formats.length();
            String[] formatItems = formats.split(",");

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
                barcodeScanning.start(image, result);
            }
        }
    }*/

    /*private void handleImageLabeling(MethodCall call, Result result) {
        InputImage image = getInputImage(call, result);
        Float _threshold = call.argument("confidenceThreshold");

        float threshold = _threshold != null ? _threshold : 0.8f;

        if (image != null) {
            imageLabeling = new ImageLabeling(threshold);
            imageLabeling.start(image, result);
        }
    }*/

    /*private void handleObjectDetection(MethodCall call, Result result) {
        InputImage image = getInputImage(call, result);
        Boolean _isStream = call.argument("isStream");
        Boolean _multiple = call.argument("enableMultipleObjects");
        Boolean _classification = call.argument("enableClassification");

        boolean isStream = _isStream != null && _isStream;
        boolean multiple = _multiple != null && _multiple;
        boolean classification = _classification != null && _classification;

        if (image != null) {
            objectDetection = new ObjectDetection(isStream, classification, multiple);
            objectDetection.start(image, result);
        }
    }*/

    /*private void handleDigitalInkRecognition(MethodCall call, Result result) {

    }*/

    /*private InputImage getInputImage(MethodCall call, Result result) {
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

        if (type.equals("file")) {
            try {
                String path = (String) data.get("path");
                if (path != null) {
                    File file = new File(path);
                    Uri uri = Uri.fromFile(file);
                    inputImage = InputImage.fromFilePath(ctx, uri);
                    return inputImage;
                }
            } catch (IOException e) {
                e.printStackTrace();
                result.error("Image data error", e.getMessage(), e);
                return null;
            }
        } else if (type.equals("bytes")) {
            Map<String, Object> metaData = (Map<String, Object>) data.get("metadata");
            inputImage = InputImage.fromByteArray(
                (byte[]) data.get("bytes"),
                (int) metaData.get("width"),
                (int) metaData.get("height"),
                (int) metaData.get("rotation"),
                (int) metaData.get("imageFormat")
            );
            return inputImage;
        }

        result.error("Invalid Image Data", null, null);
        return null;
    }*/

    private void dispose(String method) {
        method = method.replaceFirst("dispose", "");

        switch (method) {
            /*case LANGUAGE_IDENTIFICATION:
                if (languageIdentification != null) {
                    languageIdentification.dispose();
                }
                break;*/
            /*case TRANSLATE_TEXT:
                if (translateText != null) {
                    translateText.dispose();
                }
                break;*/
            /*case ENTITY_EXTRACTION:
                if (entityExtraction != null) {
                    entityExtraction.dispose();
                }
                break;*/
            /*case SMART_REPLIES:
                if (smartReplies != null) {
                    smartReplies.dispose();
                }
                break;*/
            /*case TEXT_RECOGNITION:
                if (textRecognition != null) {
                    textRecognition.dispose();
                }
                break;
            case FACE_DETECTION:
                if (faceDetection != null) {
                    faceDetection.dispose();
                }
                break;
            case POSE_DETECTION:
                if (poseDetection != null) {
                    poseDetection.dispose();
                }
                break;
            case SELFIE_SEGMENTATION:
                if (selfieSegmentation != null) {
                    selfieSegmentation.dispose();
                }
                break;
            case BARCODE_SCANNING:
                if (barcodeScanning != null) {
                    barcodeScanning.dispose();
                }
                break;
            case IMAGE_LABELING:
                if (imageLabeling != null) {
                    imageLabeling.dispose();
                }
                break;
            case OBJECT_DETECTION:
                if (objectDetection != null) {
                    objectDetection.dispose();
                }
                break;
            case DIGITAL_INK_RECOGNITION:
                if (digitalInkRecognition != null) {
                    digitalInkRecognition.dispose();
                }
                break;*/
            default:
                break;
        }
    }

}
