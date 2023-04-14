import '../../features/home/data/models/book_model/sale_info.dart';

String  getPrice(SaleInfo saleInfo) {
  if (saleInfo.saleability == 'FOR_SALE') {
    return '${saleInfo.listPrice!.amount} £';
  } else if (saleInfo.saleability == 'FREE') {
    return saleInfo.saleability!;
  } else if (saleInfo.saleability == 'NOT_FOR_SALE') {
    return 'Not for sale';
  } else {
    return saleInfo.saleability.toString();
  }
}