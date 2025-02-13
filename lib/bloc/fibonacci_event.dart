part of 'fibonacci_bloc.dart';

sealed class FibonacciEvent {}

class FibonacciGenerateList extends FibonacciEvent {
  final int n;

  FibonacciGenerateList({required this.n});
}

class FibonacciAddNumber extends FibonacciEvent {
  final int number;
  final FiboanacciType type;

  FibonacciAddNumber({required this.number,required this.type});
}

class FibonacciRemoveNumber extends FibonacciEvent {
 final int number;
  final FiboanacciType type;
   FibonacciRemoveNumber({required this.number, required this.type});
}