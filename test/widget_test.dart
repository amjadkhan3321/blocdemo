import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_bloc_api_demo/Intent/quote_bloc.dart';
import 'package:test_bloc_api_demo/View/quote_screen.dart';

void main() {
  testWidgets('Button press should trigger FetchQuote event',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => QuoteBloc(),
          child: const QuotePage(
            title: 'Random Quote',
          ),
        ),
      ),
    );

    // Tap the floating action button to trigger the FetchQuote event.
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
  });
}
