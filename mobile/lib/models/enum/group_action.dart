// ignore_for_file: constant_identifier_names

enum GroupAction { 
  CREATE,
  EDIT,
  LEAVE,
  ADD_PARTICIPANT,
  REMOVE_PARTICIPANT,
  MAKE_ADMIN,
  DISMISS_ADMIN;

  static GroupAction? fromString(String str) {
    for (GroupAction groupAction in values) {
      if (groupAction.name.toUpperCase() == str.toUpperCase()) {
        return groupAction;
      }
    }
    return null;
  }
}