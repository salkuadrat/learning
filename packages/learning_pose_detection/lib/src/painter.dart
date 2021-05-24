import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:learning_input_image/learning_input_image.dart';

import 'pose.dart';

class PosePainter extends CustomPainter {
  final Pose pose;
  final Size imageSize;
  final InputImageRotation rotation;

  PosePainter({
    required this.pose,
    required this.imageSize,
    this.rotation = InputImageRotation.ROTATION_0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    pose.landmarks.forEach((key, landmark) {
      canvas.drawCircle(transform(landmark.position, size), 1, dotPaint);
    });

    PoseLandmark? leftShoulder = pose.landmark(PoseLandmarkType.LEFT_SHOULDER);
    PoseLandmark? rightShoulder =
        pose.landmark(PoseLandmarkType.RIGHT_SHOULDER);
    PoseLandmark? leftElbow = pose.landmark(PoseLandmarkType.LEFT_ELBOW);
    PoseLandmark? rightElbow = pose.landmark(PoseLandmarkType.RIGHT_ELBOW);
    PoseLandmark? leftWrist = pose.landmark(PoseLandmarkType.LEFT_WRIST);
    PoseLandmark? rightWrist = pose.landmark(PoseLandmarkType.RIGHT_WRIST);
    PoseLandmark? leftHip = pose.landmark(PoseLandmarkType.LEFT_HIP);
    PoseLandmark? rightHip = pose.landmark(PoseLandmarkType.RIGHT_HIP);
    PoseLandmark? leftKnee = pose.landmark(PoseLandmarkType.LEFT_KNEE);
    PoseLandmark? rightKnee = pose.landmark(PoseLandmarkType.RIGHT_KNEE);
    PoseLandmark? leftAnkle = pose.landmark(PoseLandmarkType.LEFT_ANKLE);
    PoseLandmark? rightAnkle = pose.landmark(PoseLandmarkType.RIGHT_ANKLE);
    PoseLandmark? leftHeel = pose.landmark(PoseLandmarkType.LEFT_HEEL);
    PoseLandmark? rightHeel = pose.landmark(PoseLandmarkType.RIGHT_HEEL);
    PoseLandmark? leftFootIndex =
        pose.landmark(PoseLandmarkType.LEFT_FOOT_INDEX);
    PoseLandmark? rightFootIndex =
        pose.landmark(PoseLandmarkType.RIGHT_FOOT_INDEX);
    PoseLandmark? leftPinky = pose.landmark(PoseLandmarkType.LEFT_PINKY);
    PoseLandmark? rightPinky = pose.landmark(PoseLandmarkType.RIGHT_PINKY);
    PoseLandmark? leftIndex = pose.landmark(PoseLandmarkType.LEFT_INDEX);
    PoseLandmark? rightIndex = pose.landmark(PoseLandmarkType.RIGHT_INDEX);
    PoseLandmark? leftThumb = pose.landmark(PoseLandmarkType.LEFT_THUMB);
    PoseLandmark? rightThumb = pose.landmark(PoseLandmarkType.RIGHT_THUMB);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white.withOpacity(0.75);

    //Draw arms
    if (leftElbow != null && leftWrist != null) {
      canvas.drawLine(transform(leftElbow.position, size),
          transform(leftWrist.position, size), paint);
    }

    if (leftElbow != null && leftShoulder != null) {
      canvas.drawLine(transform(leftElbow.position, size),
          transform(leftShoulder.position, size), paint);
    }

    if (rightElbow != null && rightWrist != null) {
      canvas.drawLine(transform(rightElbow.position, size),
          transform(rightWrist.position, size), paint);
    }

    if (rightElbow != null && rightShoulder != null) {
      canvas.drawLine(transform(rightElbow.position, size),
          transform(rightShoulder.position, size), paint);
    }

    // Draw Hand
    if (leftWrist != null && leftThumb != null) {
      canvas.drawLine(transform(leftWrist.position, size),
          transform(leftThumb.position, size), paint);
    }

    if (leftWrist != null && leftIndex != null) {
      canvas.drawLine(transform(leftWrist.position, size),
          transform(leftIndex.position, size), paint);
    }

    if (leftWrist != null && leftPinky != null) {
      canvas.drawLine(transform(leftWrist.position, size),
          transform(leftPinky.position, size), paint);
    }

    if (rightWrist != null && rightThumb != null) {
      canvas.drawLine(transform(rightWrist.position, size),
          transform(rightThumb.position, size), paint);
    }

    if (rightWrist != null && rightIndex != null) {
      canvas.drawLine(transform(rightWrist.position, size),
          transform(rightIndex.position, size), paint);
    }

    if (rightWrist != null && rightPinky != null) {
      canvas.drawLine(transform(rightWrist.position, size),
          transform(rightPinky.position, size), paint);
    }

    //Draw legs
    if (leftHip != null && leftKnee != null) {
      canvas.drawLine(transform(leftHip.position, size),
          transform(leftKnee.position, size), paint);
    }
    if (leftKnee != null && leftAnkle != null) {
      canvas.drawLine(transform(leftKnee.position, size),
          transform(leftAnkle.position, size), paint);
    }
    if (leftAnkle != null && leftHeel != null) {
      canvas.drawLine(transform(leftAnkle.position, size),
          transform(leftHeel.position, size), paint);
    }
    if (leftHeel != null && leftFootIndex != null) {
      canvas.drawLine(transform(leftHeel.position, size),
          transform(leftFootIndex.position, size), paint);
    }

    if (rightHip != null && rightKnee != null) {
      canvas.drawLine(transform(rightHip.position, size),
          transform(rightKnee.position, size), paint);
    }
    if (rightKnee != null && rightAnkle != null) {
      canvas.drawLine(transform(rightKnee.position, size),
          transform(rightAnkle.position, size), paint);
    }
    if (rightAnkle != null && rightHeel != null) {
      canvas.drawLine(transform(rightAnkle.position, size),
          transform(rightHeel.position, size), paint);
    }
    if (rightHeel != null && rightFootIndex != null) {
      canvas.drawLine(transform(rightHeel.position, size),
          transform(rightFootIndex.position, size), paint);
    }

    //Draw body
    if (leftHip != null && leftShoulder != null) {
      canvas.drawLine(transform(leftHip.position, size),
          transform(leftShoulder.position, size), paint);
    }
    if (rightHip != null && rightShoulder != null) {
      canvas.drawLine(transform(rightHip.position, size),
          transform(rightShoulder.position, size), paint);
    }
  }

  Offset transform(Offset point, Size size) {
    return Offset(transformX(point.dx, size), transformY(point.dy, size));
  }

  double transformX(double x, Size size) {
    switch (rotation) {
      case InputImageRotation.ROTATION_90:
        return x * size.width / imageSize.height;
      case InputImageRotation.ROTATION_270:
        return size.width - x * size.width / imageSize.height;
      default:
        return x * size.width / imageSize.width;
    }
  }

  double transformY(double y, Size size) {
    switch (rotation) {
      case InputImageRotation.ROTATION_90:
      case InputImageRotation.ROTATION_270:
        return y * size.height / imageSize.width;
      default:
        return y * size.height / imageSize.height;
    }
  }

  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    return pose != oldDelegate.pose;
  }
}
