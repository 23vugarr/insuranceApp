// ignore_for_file: constant_identifier_names

enum Authority {
  USER;

  static Authority? fromString(String str) {
    for (Authority authority in values) {
      if (str.toUpperCase() == authority.name.toUpperCase()) {
        return authority;
      }
    }
    return null;
  }
}