import 'package:flutter/rendering.dart';

class Face {
  Rect boundingBox;
  double headAngleY;
  double headAngleZ;
  int? trackingId;
  Map<FaceLandmarkType, FaceLandmark> landmarks;
  Map<FaceContourType, FaceContour> countours;
  double? smilingProbability;
  double? leftEyeOpenProbability;
  double? rightEyeOpenProbability;

  Face({
    required this.boundingBox,
    this.headAngleY = 0.0,
    this.headAngleZ = 0.0,
    this.trackingId,
    this.landmarks = const {},
    this.countours = const {},
    this.smilingProbability,
    this.leftEyeOpenProbability,
    this.rightEyeOpenProbability,
  });

  factory Face.from(Map json) {
    Map<FaceLandmarkType, FaceLandmark> landmarks = {};
    Map<FaceContourType, FaceContour> contours = {};

    if (json.containsKey('landmarks')) {
      Map lmap = json['landmarks'];

      for (String key in lmap.keys) {
        FaceLandmarkType? type = toFaceLandmarkType(key);
        Map point = lmap[key];

        if (type != null) {
          landmarks[type] = FaceLandmark(
            type: type,
            point: toPoint(point),
          );
        }
      }
    }

    if (json.containsKey('contours')) {
      Map cmap = json['contours'];

      for (String key in cmap.keys) {
        FaceContourType? type = toFaceContourType(key);
        List points = cmap[key];

        if (type != null) {
          contours[type] = FaceContour(
            type: type,
            points: toPoints(points),
          );
        }
      }
    }

    return Face(
      boundingBox: toRect(json['bound']),
      headAngleY: json['headAngleY'] as double,
      headAngleZ: json['headAngleZ'] as double,
      trackingId:
          json.containsKey('trackingId') ? json['trackingId'] as int : null,
      smilingProbability: json.containsKey('smilingProbability')
          ? json['smilingProbability'] as double
          : null,
      leftEyeOpenProbability: json.containsKey('leftEyeOpenProbability')
          ? json['leftEyeOpenProbability'] as double
          : null,
      rightEyeOpenProbability: json.containsKey('rightEyeOpenProbability')
          ? json['rightEyeOpenProbability'] as double
          : null,
      landmarks: landmarks,
      countours: contours,
    );
  }
}

class FaceLandmark {
  final FaceLandmarkType type;
  final Offset point;

  FaceLandmark({
    required this.type,
    required this.point,
  });
}

class FaceContour {
  final FaceContourType type;
  final List<Offset> points;

  FaceContour({
    required this.type,
    this.points = const [],
  });
}

enum FaceLandmarkType {
  LEFT_EYE,
  RIGHT_EYE,
  LEFT_EAR,
  RIGHT_EAR,
  LEFT_CHEEK,
  RIGHT_CHEEK,
  NOSE_BASE,
  MOUTH_LEFT,
  MOUTH_RIGHT,
  MOUTH_BOTTOM,
}

enum FaceContourType {
  FACE,
  LEFT_EYE,
  RIGHT_EYE,
  LEFT_EYEBROW_TOP,
  LEFT_EYEBROW_BOTTOM,
  RIGHT_EYEBROW_TOP,
  RIGHT_EYEBROW_BOTTOM,
  NOSE_BRIDGE,
  NOSE_BOTTOM,
  LEFT_CHEEK,
  RIGHT_CHEEK,
  UPPER_LIP_TOP,
  UPPER_LIP_BOTTOM,
  LOWER_LIP_TOP,
  LOWER_LIP_BOTTOM,
}

FaceLandmarkType? toFaceLandmarkType(String type) {
  switch (type) {
    case 'LEFT_EYE':
      return FaceLandmarkType.LEFT_EYE;
    case 'RIGHT_EYE':
      return FaceLandmarkType.RIGHT_EYE;
    case 'LEFT_EAR':
      return FaceLandmarkType.LEFT_EAR;
    case 'RIGHT_EAR':
      return FaceLandmarkType.RIGHT_EAR;
    case 'LEFT_CHEEK':
      return FaceLandmarkType.LEFT_CHEEK;
    case 'RIGHT_CHEEK':
      return FaceLandmarkType.RIGHT_CHEEK;
    case 'NOSE_BASE':
      return FaceLandmarkType.NOSE_BASE;
    case 'MOUTH_LEFT':
      return FaceLandmarkType.MOUTH_LEFT;
    case 'MOUTH_RIGHT':
      return FaceLandmarkType.MOUTH_RIGHT;
    case 'MOUTH_BOTTOM':
      return FaceLandmarkType.MOUTH_BOTTOM;
    default:
      return null;
  }
}

FaceContourType? toFaceContourType(String type) {
  switch (type) {
    case 'FACE':
      return FaceContourType.FACE;
    case 'LEFT_EYE':
      return FaceContourType.LEFT_EYE;
    case 'RIGHT_EYE':
      return FaceContourType.RIGHT_EYE;
    case 'LEFT_EYEBROW_TOP':
      return FaceContourType.LEFT_EYEBROW_TOP;
    case 'LEFT_EYEBROW_BOTTOM':
      return FaceContourType.LEFT_EYEBROW_BOTTOM;
    case 'RIGHT_EYEBROW_TOP':
      return FaceContourType.RIGHT_EYEBROW_TOP;
    case 'RIGHT_EYEBROW_BOTTOM':
      return FaceContourType.RIGHT_EYEBROW_BOTTOM;
    case 'NOSE_BRIDGE':
      return FaceContourType.NOSE_BRIDGE;
    case 'NOSE_BOTTOM':
      return FaceContourType.NOSE_BOTTOM;
    case 'LEFT_CHEEK':
      return FaceContourType.LEFT_CHEEK;
    case 'RIGHT_CHEEK':
      return FaceContourType.RIGHT_CHEEK;
    case 'UPPER_LIP_TOP':
      return FaceContourType.UPPER_LIP_TOP;
    case 'UPPER_LIP_BOTTOM':
      return FaceContourType.UPPER_LIP_BOTTOM;
    case 'LOWER_LIP_TOP':
      return FaceContourType.LOWER_LIP_TOP;
    case 'LOWER_LIP_BOTTOM':
      return FaceContourType.LOWER_LIP_BOTTOM;
    default:
      return null;
  }
}

Rect toRect(Map json) => Rect.fromLTRB(
      (json['left'] as int).toDouble(),
      (json['top'] as int).toDouble(),
      (json['right'] as int).toDouble(),
      (json['right'] as int).toDouble(),
    );

Offset toPoint(Map json) => Offset(
      json['x'] as double,
      json['y'] as double,
    );

List<Offset> toPoints(List points) {
  List<Offset> result = [];

  for (var point in points) {
    result.add(toPoint(point));
  }

  return result;
}
