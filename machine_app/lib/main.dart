import 'package:charity/modules/main/app.dart';
import 'package:flutter/material.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

void main() {
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
  runApp(const CharityApp());
}
