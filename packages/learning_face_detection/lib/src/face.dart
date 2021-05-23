import 'package:flutter/rendering.dart';

class Face {
  Rect bound;
  double headAngleY;
  double headAngleZ;
  int? trackingId;
  Map<FaceLandmarkTag, FaceLandmark> landmarks;
  Map<FaceContourTag, FaceContour> countours;
  double? smilingProbability;
  double? leftEyeOpenProbability;
  double? rightEyeOpenProbability;

  Face({
    required this.bound,
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
    Map<FaceLandmarkTag, FaceLandmark> landmarks = {};
    Map<FaceContourTag, FaceContour> contours = {};

    if (json.containsKey('landmarks')) {
      Map lmap = json['landmarks'];

      for (String key in lmap.keys) {
        FaceLandmarkTag? tag = strToFaceLandmarkTag(key);
        Map point = lmap[key];

        if (tag != null) {
          landmarks[tag] = FaceLandmark(
            tag: tag,
            point: toPoint(point),
          );
        }
      }
    }

    if (json.containsKey('contours')) {
      Map cmap = json['contours'];

      for (String key in cmap.keys) {
        FaceContourTag? tag = strToFaceContourTag(key);
        List points = cmap[key];

        if (tag != null) {
          contours[tag] = FaceContour(
            tag: tag,
            points: toPoints(points),
          );
        }
      }
    }

    return Face(
      bound: toRect(json['bound']),
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
  final FaceLandmarkTag tag;
  final Offset point;

  FaceLandmark({
    required this.tag,
    required this.point,
  });
}

class FaceContour {
  final FaceContourTag tag;
  final List<Offset> points;

  FaceContour({
    required this.tag,
    this.points = const [],
  });
}

enum FaceLandmarkTag {
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

enum FaceContourTag {
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

FaceLandmarkTag? strToFaceLandmarkTag(String tag) {
  switch (tag) {
    case 'LEFT_EYE':
      return FaceLandmarkTag.LEFT_EYE;
    case 'RIGHT_EYE':
      return FaceLandmarkTag.RIGHT_EYE;
    case 'LEFT_EAR':
      return FaceLandmarkTag.LEFT_EAR;
    case 'RIGHT_EAR':
      return FaceLandmarkTag.RIGHT_EAR;
    case 'LEFT_CHEEK':
      return FaceLandmarkTag.LEFT_CHEEK;
    case 'RIGHT_CHEEK':
      return FaceLandmarkTag.RIGHT_CHEEK;
    case 'NOSE_BASE':
      return FaceLandmarkTag.NOSE_BASE;
    case 'MOUTH_LEFT':
      return FaceLandmarkTag.MOUTH_LEFT;
    case 'MOUTH_RIGHT':
      return FaceLandmarkTag.MOUTH_RIGHT;
    case 'MOUTH_BOTTOM':
      return FaceLandmarkTag.MOUTH_BOTTOM;
    default:
      return null;
  }
}

FaceContourTag? strToFaceContourTag(String tag) {
  switch (tag) {
    case 'FACE':
      return FaceContourTag.FACE;
    case 'LEFT_EYE':
      return FaceContourTag.LEFT_EYE;
    case 'RIGHT_EYE':
      return FaceContourTag.RIGHT_EYE;
    case 'LEFT_EYEBROW_TOP':
      return FaceContourTag.LEFT_EYEBROW_TOP;
    case 'LEFT_EYEBROW_BOTTOM':
      return FaceContourTag.LEFT_EYEBROW_BOTTOM;
    case 'RIGHT_EYEBROW_TOP':
      return FaceContourTag.RIGHT_EYEBROW_TOP;
    case 'RIGHT_EYEBROW_BOTTOM':
      return FaceContourTag.RIGHT_EYEBROW_BOTTOM;
    case 'NOSE_BRIDGE':
      return FaceContourTag.NOSE_BRIDGE;
    case 'NOSE_BOTTOM':
      return FaceContourTag.NOSE_BOTTOM;
    case 'LEFT_CHEEK':
      return FaceContourTag.LEFT_CHEEK;
    case 'RIGHT_CHEEK':
      return FaceContourTag.RIGHT_CHEEK;
    case 'UPPER_LIP_TOP':
      return FaceContourTag.UPPER_LIP_TOP;
    case 'UPPER_LIP_BOTTOM':
      return FaceContourTag.UPPER_LIP_BOTTOM;
    case 'LOWER_LIP_TOP':
      return FaceContourTag.LOWER_LIP_TOP;
    case 'LOWER_LIP_BOTTOM':
      return FaceContourTag.LOWER_LIP_BOTTOM;
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
