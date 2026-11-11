// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:zoma_clone_flutter/main.dart';

final List<int> _transparentImage = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==',
);

class _FakeHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) => _FakeHttpClient();
}

class _FakeHttpClient implements HttpClient {
  @override
  bool autoUncompress = true;

  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _FakeHttpClientRequest();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeHttpClientRequest implements HttpClientRequest {
  @override
  final HttpHeaders headers = _FakeHttpHeaders();

  @override
  Future<HttpClientResponse> close() async => _FakeHttpClientResponse();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeHttpHeaders implements HttpHeaders {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeHttpClientResponse implements HttpClientResponse {
  @override
  int get statusCode => HttpStatus.ok;

  @override
  int get contentLength => _transparentImage.length;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.fromIterable(<List<int>>[_transparentImage]).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  setUpAll(() {
    HttpOverrides.global = _FakeHttpOverrides();
  });

  testWidgets('HomePage renders bottom navigation tabs and switches screens', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final navBar = find.byType(BottomNavigationBar);

    expect(find.descendant(of: navBar, matching: find.text('Order')), findsOneWidget);
    expect(find.descendant(of: navBar, matching: find.text('Go Out')), findsOneWidget);
    expect(find.descendant(of: navBar, matching: find.text('Gold')), findsOneWidget);
    expect(find.descendant(of: navBar, matching: find.text('Explore')), findsOneWidget);
    expect(find.descendant(of: navBar, matching: find.text('Profile')), findsOneWidget);

    await tester.tap(find.descendant(of: navBar, matching: find.text('Go Out')));
    await tester.pumpAndSettle();
    expect(find.text('dining'), findsOneWidget);

    await tester.tap(find.descendant(of: navBar, matching: find.text('Gold')));
    await tester.pumpAndSettle();
    expect(find.text('Select your membership'), findsOneWidget);

    await tester.tap(find.descendant(of: navBar, matching: find.text('Explore')));
    await tester.pumpAndSettle();
    expect(find.text('feed'), findsOneWidget);

    await tester.tap(find.descendant(of: navBar, matching: find.text('Profile')));
    await tester.pumpAndSettle();
    expect(find.text('Zomato ProGold'), findsOneWidget);
  });
}
