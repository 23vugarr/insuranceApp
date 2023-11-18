// ignore_for_file: constant_identifier_names

enum MessageType {
  PRIVATE,
  GROUP;

  static MessageType? fromString(String str) {
    for (MessageType messageType in values) {
      if (messageType.name.toUpperCase() == str.toUpperCase()) {
        return messageType;
      }
    }
    return null;
  }
}