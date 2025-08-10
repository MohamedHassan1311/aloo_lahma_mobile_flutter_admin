enum NotificationTarget { product, order, transaction }

abstract class NotificationTargetConverter {
  static NotificationTarget convertStringToEnum(String target) {
    switch (target) {
      case 'product':
        return NotificationTarget.product;
      case 'order':
        return NotificationTarget.order;
      case 'transaction':
        return NotificationTarget.transaction;
      default:
        return NotificationTarget.product;
    }
  }
}
