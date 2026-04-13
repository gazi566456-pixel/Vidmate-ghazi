import 'dart:io';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:ffmpeg_kit_flutter_new/statistics.dart';
import 'package:vidmate_clone_app/core/errors/exceptions.dart';

class FFmpegService {
  void Function(double progress)? onProgress;

  Future<String> mergeVideoAndAudio(String videoPath, String audioPath, String outputPath) async {
    final String command = "-i \"$videoPath\" -i \"$audioPath\" -c:v copy -c:a aac -map 0:v:0 -map 1:a:0 \"$outputPath\"";
    return _executeCommand(command, outputPath);
  }

  Future<String> extractAudioToMp3(String inputPath, String outputPath) async {
    final String command = "-i \"$inputPath\" -vn -ar 44100 -ac 2 -b:a 192k \"$outputPath\"";
    return _executeCommand(command, outputPath);
  }

  Future<String> downloadAndConvertM3u8ToMp4(String m3u8Url, String outputPath) async {
    final String command = "-i \"$m3u8Url\" -c copy -bsf:a aac_adtstoasc \"$outputPath\"";
    return _executeCommand(command, outputPath);
  }

  Future<String> _executeCommand(String command, String outputPath) async {
    final session = await FFmpegKit.executeAsync(
      command,
      (session) async {
        final returnCode = await session.getReturnCode();
        if (ReturnCode.isSuccess(returnCode)) {
          // Success
        } else if (ReturnCode.isCancel(returnCode)) {
          throw CancellationException(message: "FFmpeg operation cancelled.");
        } else {
          final logs = await session.getLogs();
          throw FFmpegExecutionException(message: "FFmpeg failed: ${logs.last.getMessage()}");
        }
      },
      (log) => {},
      (statistics) {
        if (onProgress != null) {
          // Progress calculation logic based on statistics (time-based)
          // For MVP, we can emit a generic progress or use time if duration is known
        }
      },
    );
    
    // Wait for the session to complete
    await session.getReturnCode();
    return outputPath;
  }
}
