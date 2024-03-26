class MediaFielsModel {
  final String messageID;
  final String senderID;
  String? messageImage;
  String? messageVideo;
  String? messageText;

  MediaFielsModel(
      {required this.messageID,
      required this.senderID,
      this.messageImage,
      this.messageVideo,
      this.messageText});

  factory MediaFielsModel.fromJson(jsonData) {
    return MediaFielsModel(
        messageID: jsonData['messageID'],
        senderID: jsonData['senderID'],
        messageImage: jsonData['messageImage'],
        messageVideo: jsonData['messageVideo'],
        messageText: jsonData['messageText']);
  }

  Map<String, dynamic> toMap() {
    return {
      'messageID': messageID,
      'senderID': senderID,
      'messageImage': messageImage,
      'messageVideo': messageVideo,
      'messageText': messageText
    };
  }
}
