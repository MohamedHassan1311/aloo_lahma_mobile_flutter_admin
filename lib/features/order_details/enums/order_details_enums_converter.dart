import 'order_details_enums.dart';

abstract class OrderDetailsEnumsConverter {


  static OrderStatuses convertStringToEnum(String status) {
    switch (status) {
      case "PENDING":
        return OrderStatuses.pending;
      case "ACCEPTED":
        return OrderStatuses.accepted;
      case "IN_PROGRESS":
        return OrderStatuses.inProgress;
      case "OUT_FOR_DELIVERY":
        return OrderStatuses.outForDelivery;
      case "COMPELTED":
        return OrderStatuses.completed;
      case "CANCELLED":
        return OrderStatuses.cancelled;
      case "DEFERRED":
        return OrderStatuses.deferred;
      case "DECOMPOSE":
        return OrderStatuses.decompose;
      case "PAYMENT_PENDING":
        return OrderStatuses.paymentPending;
      case "PAYMENT_FAILED":
        return OrderStatuses.paymentFailed;
      default:
        return OrderStatuses.pending;
    }
  }

  static String convertEnumToString(OrderStatuses status) {
    switch (status) {
      case OrderStatuses.pending:
        return "PENDING";
      case OrderStatuses.accepted:
        return "ACCEPTED";
      case OrderStatuses.inProgress:
        return "IN_PROGRESS";
      case OrderStatuses.outForDelivery:
        return "OUT_FOR_DELIVERY";
      case OrderStatuses.completed:
        return "COMPELTED";
      case OrderStatuses.cancelled:
        return "CANCELLED";
      case OrderStatuses.deferred:
        return "DEFERRED";
      case OrderStatuses.decompose:
        return "DECOMPOSE";
      case OrderStatuses.paymentPending:
        return "PAYMENT_PENDING";
      case OrderStatuses.paymentFailed:
        return "PAYMENT_FAILED";
      default:
        return "PENDING";
    }
  }

  static ReceiptTypes convertStringToReceiptType(String type) {
    switch (type) {
      case "Receipt_From_Store":
        return ReceiptTypes.takeAway;
      case "DELIVERY":
        return ReceiptTypes.delivery;
      default:
        return ReceiptTypes.delivery;
    }
  }

  static String convertReceiptTypeEnumToString(ReceiptTypes type) {
    switch (type) {
      case ReceiptTypes.takeAway:
        return "Receipt_From_Store";
      case ReceiptTypes.delivery:
        return "DELIVERY";
      default:
        return "DELIVERY";
    }
  }
}
