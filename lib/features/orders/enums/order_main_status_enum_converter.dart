import 'order_main_status_enum.dart';

abstract class OrderMainStatusEnumConverter {
  static OrderMainStatus convertOrderMainStatusFromStringToEnum(String status) {
    switch (status.toUpperCase()) {
      case "CURRENT":
        return OrderMainStatus.current;
      case "PREVIOUS":
        return OrderMainStatus.previous;

      default:
        return OrderMainStatus.current;
    }
  }

  static String convertOrderMainStatusFromEnumToString(OrderMainStatus status) {
    switch (status) {
      case OrderMainStatus.current:
        return 'current_orders';
      case OrderMainStatus.previous:
        return 'previous_orders';

      default:
        return 'current_orders';
    }
  }
}
