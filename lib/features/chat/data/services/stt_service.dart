import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart';

class SpeechToTextService {
  final stt.SpeechToText _speech = stt.SpeechToText();

  Future<void> listen({
    required void Function(SpeechRecognitionResult result) onResult,
  }) async {
    // ✅ اطلب الـ permission الأول
    final status = await Permission.microphone.request();
    if (!status.isGranted) return;

    final available = await _speech.initialize(
      onError: (error) => print('STT Error: $error'),
      onStatus: (status) => print('STT Status: $status'),
    );

    if (available) {
      await _speech.listen(onResult: onResult);
    }
  }

  Future<void> stop() async => await _speech.stop();
}
