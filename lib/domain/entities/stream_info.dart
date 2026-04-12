import 'package:equatable/equatable.dart';

enum StreamType { video, audio, muxed, m3u8 }

class StreamInfo extends Equatable {
  final String url;
  final StreamType type;
  final String? quality;
  final String? format;
  final int? size;
  final String? codec;

  const StreamInfo({
    required this.url,
    required this.type,
    this.quality,
    this.format,
    this.size,
    this.codec,
  });

  @override
  List<Object?> get props => [url, type, quality, format, size, codec];
}
