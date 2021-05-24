import 'package:flutter/rendering.dart';

class Pose {
  Map<PoseLandmarkType, PoseLandmark> landmarks;

  Pose({this.landmarks = const {}});

  PoseLandmark? landmark(PoseLandmarkType type) => landmarks[type];

  factory Pose.from(Map json) {
    Map<PoseLandmarkType, PoseLandmark> landmarks = {};

    for (String key in json.keys) {
      PoseLandmarkType? type = toPoseLandmarkType(key);
      Map item = json[key];

      if (type != null) {
        landmarks[type] = PoseLandmark(
          type: type,
          position: toPoint(item['position']),
          inFrameLikelihood: item['inFrameLikelihood'] as double,
        );
      }
    }

    return Pose(landmarks: landmarks);
  }
}

class PoseLandmark {
  final PoseLandmarkType type;
  final Offset position;
  final double inFrameLikelihood;

  PoseLandmark({
    required this.type,
    required this.position,
    this.inFrameLikelihood = 0.0,
  });
}

enum PoseLandmarkType {
  LEFT_EYE,
  LEFT_EYE_INNER,
  LEFT_EYE_OUTER,
  RIGHT_EYE,
  RIGHT_EYE_INNER,
  RIGHT_EYE_OUTER,
  LEFT_EAR,
  RIGHT_EAR,
  NOSE,
  LEFT_MOUTH,
  RIGHT_MOUTH,
  LEFT_SHOULDER,
  RIGHT_SHOULDER,
  LEFT_ELBOW,
  RIGHT_ELBOW,
  LEFT_WRIST,
  RIGHT_WRIST,
  LEFT_THUMB,
  RIGHT_THUMB,
  LEFT_INDEX,
  RIGHT_INDEX,
  LEFT_PINKY,
  RIGHT_PINKY,
  LEFT_HIP,
  RIGHT_HIP,
  LEFT_KNEE,
  RIGHT_KNEE,
  LEFT_ANKLE,
  RIGHT_ANKLE,
  LEFT_HEEL,
  RIGHT_HEEL,
  LEFT_FOOT_INDEX,
  RIGHT_FOOT_INDEX,
}

PoseLandmarkType? toPoseLandmarkType(String type) {
  switch (type) {
    case 'LEFT_EYE':
      return PoseLandmarkType.LEFT_EYE;
    case 'LEFT_EYE_INNER':
      return PoseLandmarkType.LEFT_EYE_INNER;
    case 'LEFT_EYE_OUTER':
      return PoseLandmarkType.LEFT_EYE_OUTER;
    case 'RIGHT_EYE':
      return PoseLandmarkType.RIGHT_EYE;
    case 'RIGHT_EYE_INNER':
      return PoseLandmarkType.RIGHT_EYE_INNER;
    case 'RIGHT_EYE_OUTER':
      return PoseLandmarkType.RIGHT_EYE_OUTER;
    case 'LEFT_EAR':
      return PoseLandmarkType.LEFT_EAR;
    case 'RIGHT_EAR':
      return PoseLandmarkType.RIGHT_EAR;
    case 'NOSE':
      return PoseLandmarkType.NOSE;
    case 'LEFT_MOUTH':
      return PoseLandmarkType.LEFT_MOUTH;
    case 'RIGHT_MOUTH':
      return PoseLandmarkType.RIGHT_MOUTH;
    case 'LEFT_SHOULDER':
      return PoseLandmarkType.LEFT_SHOULDER;
    case 'RIGHT_SHOULDER':
      return PoseLandmarkType.RIGHT_SHOULDER;
    case 'LEFT_ELBOW':
      return PoseLandmarkType.LEFT_ELBOW;
    case 'RIGHT_ELBOW':
      return PoseLandmarkType.RIGHT_ELBOW;
    case 'LEFT_WRIST':
      return PoseLandmarkType.LEFT_WRIST;
    case 'RIGHT_WRIST':
      return PoseLandmarkType.RIGHT_WRIST;
    case 'LEFT_THUMB':
      return PoseLandmarkType.LEFT_THUMB;
    case 'RIGHT_THUMB':
      return PoseLandmarkType.RIGHT_THUMB;
    case 'LEFT_INDEX':
      return PoseLandmarkType.LEFT_INDEX;
    case 'RIGHT_INDEX':
      return PoseLandmarkType.RIGHT_INDEX;
    case 'LEFT_PINKY':
      return PoseLandmarkType.LEFT_PINKY;
    case 'RIGHT_PINKY':
      return PoseLandmarkType.RIGHT_PINKY;
    case 'LEFT_HIP':
      return PoseLandmarkType.LEFT_HIP;
    case 'RIGHT_HIP':
      return PoseLandmarkType.RIGHT_HIP;
    case 'LEFT_KNEE':
      return PoseLandmarkType.LEFT_KNEE;
    case 'RIGHT_KNEE':
      return PoseLandmarkType.RIGHT_KNEE;
    case 'LEFT_HEEL':
      return PoseLandmarkType.LEFT_HEEL;
    case 'RIGHT_HEEL':
      return PoseLandmarkType.RIGHT_HEEL;
    case 'LEFT_FOOT_INDEX':
      return PoseLandmarkType.LEFT_FOOT_INDEX;
    case 'RIGHT_FOOT_INDEX':
      return PoseLandmarkType.RIGHT_FOOT_INDEX;
    default:
      return null;
  }
}

Offset toPoint(Map json) => Offset(
      json['x'] as double,
      json['y'] as double,
    );
