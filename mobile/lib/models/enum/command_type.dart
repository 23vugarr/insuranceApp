// ignore_for_file: constant_identifier_names

enum CommandType { 
  MESSAGE,
  GROUP_ACTION,
  FEEDBACK;

  static CommandType? fromString(String str) {
    for (CommandType commandType in values) {
      if (commandType.name.toUpperCase() == str.toUpperCase()) {
        return commandType;
      }
    }
    return null;
  }
}