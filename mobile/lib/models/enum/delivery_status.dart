// ignore_for_file: constant_identifier_names

enum DeliveryStatus { 
  DELIVERED,
  READ;

  static DeliveryStatus? fromString(String str) {
    for (DeliveryStatus deliveryStatus in values) {
      if (deliveryStatus.name.toUpperCase() == str.toUpperCase()) {
        return deliveryStatus;
      }
    }
    return null;
  }
}