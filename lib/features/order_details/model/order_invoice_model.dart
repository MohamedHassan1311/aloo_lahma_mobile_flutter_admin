import '../../../app/localization/language_constant.dart';

class OrderInvoiceModel {
  int? id;
  double? subTotal;
  double? tax;
  double? taxPercentage;
  double? deliveryCharges;
  double? deliveryChargesPercentage;
  double? discount;
  double? paidFromWallet;
  double? totalPrice;
  double? actualTotalPrice;
  double? cashback;
  bool? needBankTransfer;
  String? bankTransfer;
  String? currency;

  OrderInvoiceModel(
      {this.id,
      this.subTotal,
      this.taxPercentage,
      this.tax,
      this.deliveryCharges,
      this.deliveryChargesPercentage,
      this.discount,
      this.totalPrice,
      this.paidFromWallet,
      this.actualTotalPrice,
      this.cashback,
      this.needBankTransfer,
      this.bankTransfer,
      this.currency});

  OrderInvoiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subTotal = json['total_price_without_tax_trans'] != null
        ? double.parse(json['total_price_without_tax_trans'].toString())
        : null;
    taxPercentage = json['tax_percentage'] != null
        ? double.parse(json['tax_percentage'].toString())
        : null;
    tax = json['tax_value'] != null
        ? double.parse(json['tax_value'].toString())
        : null;
    deliveryChargesPercentage = json['transportation_price_percentage'] != null
        ? double.parse(json['transportation_price_percentage'].toString())
        : null;
    deliveryCharges = json['transportation_price'] != null
        ? double.parse(json['transportation_price'].toString())
        : null;
    discount = json['discount'] != null
        ? double.parse(json['discount'].toString())
        : null;
    paidFromWallet = json['pay_from_wallet'] != null
        ? double.parse(json['pay_from_wallet'].toString())
        : null;

    totalPrice =
        json['amount'] != null ? double.parse(json['amount'].toString()) : null;
    actualTotalPrice = json['amount_price_value'] != null
        ? double.parse(json['amount_price_value'].toString())
        : null;
    cashback = json['cash_back'] != null
        ? double.parse(json['cash_back'].toString())
        : null;

    needBankTransfer = json['need_bank_transfer'];
    bankTransfer = json['bank_transfer'] != null &&
            json['bank_transfer']['attachment'] != null
        ? json['bank_transfer']['attachment']
        : null;
    currency = json['currency'] ?? getTranslated("sar");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['total_price_without_tax_trans'] = subTotal;
    data['tax_percentage'] = taxPercentage;
    data['tax_value'] = tax;
    data['transportation_price_percentage'] = deliveryChargesPercentage;
    data['transportation_price'] = deliveryCharges;
    data['discount'] = discount;
    data['amount'] = totalPrice;
    data['paid_from_wallet'] = paidFromWallet;
    data['amount_price_value'] = actualTotalPrice;
    data['cash_back'] = cashback;
    data['need_bank_transfer'] = needBankTransfer;
    data['bank_transfer[attachment]'] = bankTransfer;
    data['currency'] = currency;
    return data;
  }
}
