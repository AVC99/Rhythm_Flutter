class DisplayInfo {
  final String text;
  final String url;
  final String? artist;
  final String? previewUrl;

  DisplayInfo({
    required this.text,
    required this.url,
    this.artist,
    this.previewUrl,
  });

}
