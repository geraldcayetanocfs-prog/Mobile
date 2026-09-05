import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_monitoring/main.dart';

void main() {
  testWidgets('app loads with dashboard title and actions', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('UiPath Monitor'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
  });
}
