import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class GenderPredictionResult {
  final String label;
  final double confidence;
  final Map<String, double> scores;

  const GenderPredictionResult({
    required this.label,
    required this.confidence,
    required this.scores,
  });
}

class GenderModelService {
  Interpreter? _interpreter;

  List<int>? _inputShape;
  List<int>? _outputShape;

  /// Keep only if your model is truly 2-class.
  /// Your current model is returning 133 outputs, so these labels
  /// will only work after you replace the model with a real gender model.
  static const List<String> labels = ['Male', 'Female'];

  Future<void> loadModel() async {
    // _interpreter ??= await Interpreter.fromAsset(AppAssets.genderModelAssets);

    _inputShape = _interpreter!.getInputTensor(0).shape;
    _outputShape = _interpreter!.getOutputTensor(0).shape;
  }

  Future<void> dispose() async {
    _interpreter?.close();
    _interpreter = null;
    _inputShape = null;
    _outputShape = null;
  }

  Future<GenderPredictionResult> predictFromFaceFile(File file) async {
    if (_interpreter == null) {
      throw Exception('Model not loaded');
    }

    final inputShape = _inputShape ?? _interpreter!.getInputTensor(0).shape;
    final outputShape = _outputShape ?? _interpreter!.getOutputTensor(0).shape;

    if (inputShape.length != 4) {
      throw Exception('Unexpected input shape: $inputShape');
    }

    if (outputShape.length != 2 || outputShape[0] != 1) {
      throw Exception('Unexpected output shape: $outputShape');
    }

    final int inputHeight = inputShape[1];
    final int inputWidth = inputShape[2];
    final int inputChannels = inputShape[3];
    final int outputClasses = outputShape[1];

    if (inputChannels != 3) {
      throw Exception('Expected 3 input channels, found: $inputChannels');
    }

    final bytes = await file.readAsBytes();
    final decoded = img.decodeImage(bytes);

    if (decoded == null) {
      throw Exception('Unable to decode image');
    }

    final resized = img.copyResize(
      decoded,
      width: inputWidth,
      height: inputHeight,
      interpolation: img.Interpolation.linear,
    );

    final input = _imageToInput(
      image: resized,
      inputWidth: inputWidth,
      inputHeight: inputHeight,
    );

    final output = List.generate(
      1,
      (_) => List<double>.filled(outputClasses, 0.0),
    );

    _interpreter!.run(input, output);

    final scores = output.first;

    print('Model scores length: ${scores.length}');
    print('Model scores: $scores');

    if (scores.isEmpty) {
      throw Exception('Model returned empty output');
    }

    int maxIndex = 0;
    double maxValue = scores[0];

    for (int i = 1; i < scores.length; i++) {
      if (scores[i] > maxValue) {
        maxValue = scores[i];
        maxIndex = i;
      }
    }

    /// If model is not 2-class, do not pretend it is Male/Female.
    if (scores.length != labels.length) {
      return GenderPredictionResult(
        label: 'Unknown model output',
        confidence: maxValue,
        scores: {for (int i = 0; i < scores.length; i++) 'class_$i': scores[i]},
      );
    }

    final mappedScores = <String, double>{};
    for (int i = 0; i < labels.length; i++) {
      mappedScores[labels[i]] = scores[i];
    }

    return GenderPredictionResult(
      label: labels[maxIndex],
      confidence: maxValue,
      scores: mappedScores,
    );
  }

  /// Creates shape: [1, height, width, 3]
  /// Normalization: [0,255] -> [0,1]
  List<List<List<List<double>>>> _imageToInput({
    required img.Image image,
    required int inputWidth,
    required int inputHeight,
  }) {
    return [
      List.generate(inputHeight, (y) {
        return List.generate(inputWidth, (x) {
          final pixel = image.getPixel(x, y);

          final r = pixel.r.toDouble() / 255.0;
          final g = pixel.g.toDouble() / 255.0;
          final b = pixel.b.toDouble() / 255.0;

          return [r, g, b];
        });
      }),
    ];
  }
}
