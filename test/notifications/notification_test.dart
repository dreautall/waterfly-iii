import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:http/http.dart' as http;
import 'package:waterflyiii/notificationlistener.dart';

void main() {
  group('Notification listener', () {
    test('Data parsing using predefined regexp', () async {
      final MockClient mockHttpClient = MockClient((
        http.Request request,
      ) async {
        if (request.url.path == '/v1/currencies') {
          return http.Response(
            "{ \"data\": [ { \"type\": \"currencies\", \"id\": \"2\", \"attributes\": { \"created_at\": \"2025-09-01T00:00:00+00:00\", \"updated_at\": \"2025-09-01T00:00:00+00:00\", \"enabled\": true, \"primary\": false, \"code\": \"CAD\", \"name\": \"Canadian dollar\", \"symbol\": \"\$\", \"decimal_places\": 2 } } ], \"meta\": { \"pagination\": { \"total\": 3, \"count\": 20, \"per_page\": 100, \"current_page\": 1, \"total_pages\": 1 } }, \"links\": { \"self\": \"https://demo.firefly-iii.org/api/v1/OBJECT?&page=4\", \"first\": \"https://demo.firefly-iii.org/api/v1/OBJECT?&page=1\", \"next\": \"https://demo.firefly-iii.org/api/v1/OBJECT?&page=3\", \"prev\": \"https://demo.firefly-iii.org/api/v1/OBJECT?&page=2\", \"last\": \"https://demo.firefly-iii.org/api/v1/OBJECT?&page=12\" } }",
            200,
            headers: <String, String>{'content-type': 'application/json'},
          );
        }
        return http.Response('Not Found', 404);
      });

      final ChopperClient chopperClient = ChopperClient(
        client: mockHttpClient,
        services: <ChopperService>[FireflyIii.create(client: ChopperClient())],
        converter: $JsonSerializableConverter(),
      );

      final FireflyIii apiService =
          chopperClient.getService<FireflyIii>(); // Pass the mock client

      final CurrencyRead cadCurrency = const CurrencyRead(
        type: "testCadCurrency",
        id: "testCadCurrency",
        attributes: CurrencyProperties(
          code: "CAD",
          name: "Canadian Dollar",
          symbol: r"$",
        ),
      );

      final CurrencyRead amsCurrency = const CurrencyRead(
        type: "testAmsCurrency",
        id: "testAmsCurrency",
        attributes: CurrencyProperties(
          code: "AMS",
          name: "Ankh-Morpork dollar",
          symbol: r"AM$",
        ),
      );

      CurrencyRead? extractedCurrency;
      double extractedAmount;

      // Test with empty input
      (extractedCurrency, extractedAmount) = await parseNotificationText(
        apiService,
        r"",
        amsCurrency,
      );
      expect(extractedAmount, 0.0);

      // Test with input containing no numeric values
      (extractedCurrency, extractedAmount) = await parseNotificationText(
        apiService,
        r"A purchase was made from RBC credit card at VENDOR.",
        cadCurrency,
      );
      expect(extractedAmount, 0.0);

      // Test with local currency matching
      (extractedCurrency, extractedAmount) = await parseNotificationText(
        apiService,
        r"A purchase of $4.99 CAD was made at VENDOR.",
        cadCurrency,
      );
      expect(extractedAmount, 4.99);
      expect(extractedCurrency?.attributes.code, cadCurrency.attributes.code);

      // Test with local currency not matching
      (extractedCurrency, extractedAmount) = await parseNotificationText(
        apiService,
        r"A purchase of $4.99 CAD was made at VENDOR.",
        amsCurrency,
      );
      expect(extractedAmount, 4.99);
      expect(extractedCurrency?.attributes.code, "CAD");

      // Test with currency information in format that won't match either the
      // local or remote currency definitions
      (extractedCurrency, extractedAmount) = await parseNotificationText(
        apiService,
        r"A purchase of C$4.99 was made from at VENDOR.",
        amsCurrency,
      );
      expect(extractedAmount, 4.99);
      expect(extractedCurrency, null);

      // Test with multiple values that would match the regex
      (extractedCurrency, extractedAmount) = await parseNotificationText(
        apiService,
        r"A purchase of $4.99 CAD was made from RBC credit card 9999 at VENDOR.",
        amsCurrency,
      );
      expect(extractedAmount, 4.99);
      expect(extractedCurrency?.attributes.code, "CAD");

      // Test with multiple values that would match the regex, where the actual
      // amount is not the first match
      (extractedCurrency, extractedAmount) = await parseNotificationText(
        apiService,
        r"A purchase was made from RBC credit card 9999 at VENDOR for $4.99 CAD.",
        amsCurrency,
      );
      expect(extractedAmount, 4.99);
      expect(extractedCurrency?.attributes.code, "CAD");

      // Test other example strings provided by users
      (extractedCurrency, extractedAmount) = await parseNotificationText(
        apiService,
        r"LINE pay purchase NT$ 80. Payment complete. Merchant: vendor.",
        amsCurrency,
      );
      expect(extractedAmount, 80);

      (extractedCurrency, extractedAmount) = await parseNotificationText(
        apiService,
        r"Paid RON33.97 at Mega Image. RON balance: RON127.56",
        amsCurrency,
      );
      expect(extractedAmount, 33.97);

      (extractedCurrency, extractedAmount) = await parseNotificationText(
        apiService,
        r"Compra por $7.990 con T.Crédito ****8697 en MER-CADOPAGO *PATRICIO Las Condes CHL el 05/06/2025 17:28. Revisa Saldos y Movimientos en App Mi Bianco o Banco en Línea.",
        amsCurrency,
      );
      expect(extractedAmount, 7.99);

      (extractedCurrency, extractedAmount) = await parseNotificationText(
        apiService,
        r"U.S. Bank Visa Debit Card 0544 Caseys #2309 BLAINE US $8.20",
        amsCurrency,
      );
      expect(extractedAmount, 8.20);
    });
  });
}
