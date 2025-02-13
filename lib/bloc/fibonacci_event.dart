part of 'fibonacci_bloc.dart';

sealed class FibonacciEvent {}

class FibonacciGenerateList extends FibonacciEvent {
  final int n;

  FibonacciGenerateList({required this.n});
}

class FibonacciAddNumber extends FibonacciEvent {
  final int numberIndex;
  final FibonacciType type;

  FibonacciAddNumber({required this.numberIndex, required this.type});
}

class FibonacciRemoveNumber extends FibonacciEvent {
  final int numberIndex;
  final FibonacciType type;

  FibonacciRemoveNumber({required this.numberIndex, required this.type});
}