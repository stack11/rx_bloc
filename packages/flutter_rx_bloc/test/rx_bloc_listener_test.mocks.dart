// Mocks generated by Mockito 5.0.10 from annotations
// in flutter_rx_bloc/test/rx_bloc_listener_test.dart.
// Do not manually edit this file.

import 'package:flutter/src/widgets/framework.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

import 'rx_bloc_listener_test.dart' as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [CallbackFunctions].
///
/// See the documentation for Mockito's code generation for more information.
class MockCallbackFunctions extends _i1.Mock implements _i2.CallbackFunctions {
  MockCallbackFunctions() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void onString(_i3.BuildContext? context, String? value) =>
      super.noSuchMethod(Invocation.method(#onString, [context, value]),
          returnValueForMissingStub: null);
}