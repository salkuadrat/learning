# ML Selfie Segmentation

The easy way to use ML Kit for selfie segmentation in Flutter.

ML Kit's Selfie Segmentation allows developers to easily separate the background from users within a scene and focus on what matters. Adding cool effects to selfies or inserting your users into interesting background environments has never been easier.

It takes an input image and produces an output mask. By default, the mask will be the same size as the input image. Each pixel of the mask is assigned a float number that has a range between [0.0, 1.0]. The closer the number is to 1.0, the higher the confidence that the pixel represents a person, and vice versa.

It works with static images and live video use cases. During live video, it will leverage output from previous frames to return smoother segmentation results.

## Getting Started

Add dependency to your flutter project:

```
$ flutter pub add learning_selfie_segmentation
```

or

```yaml
dependencies:
  learning_selfie_segmentation: ^0.0.1
```

Then run `flutter pub get`.