import 'package:flutter_test/flutter_test.dart';
import 'package:yofa/pagecustomer/tagihan/model/tagihan_model.dart';

void main() {
  group('Tagihan model', () {
    test('parses invoice data from API JSON', () {
      final json = {
        'id': 38,
        'invoice_number': '20021',
        'total': 90000,
        'status': 'pending',
        'tanggal': '2026-07-14',
        'due_date': null,
      };

      final tagihan = Tagihan.fromJson(json);

      expect(tagihan.id, 38);
      expect(tagihan.invoiceNumber, '20021');
      expect(tagihan.total, 90000);
      expect(tagihan.isPaid, isFalse);
      expect(tagihan.displayStatus, 'Belum Bayar');
    });
  });
}
