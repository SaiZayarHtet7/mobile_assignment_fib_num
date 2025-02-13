part of 'fibonacci_bloc.dart';

enum FibonacciStatus { initial, loading, success, failure }

class FibonacciState {
  final FibonacciStatus status;
  final List<FibonacciNumber> fibonacciList;
  final Map<FibonacciType, List<FibonacciNumber>> typeMap;
  final String message;
  final int removeIndex;

  FibonacciState({
    required this.status,
    required this.fibonacciList,
    required this.message,
    required this.typeMap,
    required this.removeIndex,
  });

  List<FibonacciNumber> get displayFibonaciList =>
      fibonacciList.where((element) => element.isEnable).toList();

  factory FibonacciState.initial() {
    return FibonacciState(
        status: FibonacciStatus.initial,
        fibonacciList: [],
        message: '',
        removeIndex: -1,
        typeMap: {
          FibonacciType.circle: [],
          FibonacciType.square: [],
          FibonacciType.cross: []
        });
  }

  FibonacciState copyWith(
      {FibonacciStatus? status,
      List<FibonacciNumber>? fibonacciList,
      Map<FibonacciType, List<FibonacciNumber>>? typeMap,
      int? removeIndex,
      String? message}) {
    return FibonacciState(
        status: status ?? this.status,
        fibonacciList: fibonacciList ?? this.fibonacciList,
        message: message ?? this.message,
        typeMap: typeMap ?? this.typeMap,
        removeIndex: removeIndex ?? this.removeIndex);
  }
}

class FibonacciNumber {
  final int number;
  final FibonacciType type;
  final int numberIndex;
  final bool isEnable;

  FibonacciNumber(
      {required this.type,
      required this.number,
      required this.numberIndex,
      this.isEnable = true});

  FibonacciNumber copyWith(
      {int? number, FibonacciType? type, bool? isEnable, int? numberIndex}) {
    return FibonacciNumber(
        number: number ?? this.number,
        type: type ?? this.type,
        isEnable: isEnable ?? this.isEnable,
        numberIndex: numberIndex ?? this.numberIndex
        );
  }
}

enum FibonacciType { circle, square, cross }
