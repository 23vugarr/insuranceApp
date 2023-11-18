// ignore_for_file: constant_identifier_names

enum MessageContentType { 
  TEXT,
  IMAGE,
  VOICE;

  static MessageContentType? fromString(String str) {
    for (MessageContentType messageContentType in values) {
      if (messageContentType.name.toUpperCase() == str.toUpperCase()) {
        return messageContentType;
      }
    }
    return null;
  }
}