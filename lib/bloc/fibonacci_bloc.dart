import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'fibonacci_event.dart';
part 'fibonacci_state.dart';

class FibonacciBloc extends Bloc<FibonacciEvent, FibonacciState> {
  FibonacciBloc() : super(FibonacciState.initial()) {
    on<FibonacciGenerateList>(_onFibonacciGenerateList);
    on<FibonacciAddNumber>(_addDataToBottomSheet);
    on<FibonacciRemoveNumber>(_removeDataFromBottomSheet);
  }

  FutureOr<void> _onFibonacciGenerateList(event, emit) {
    emit(state.copyWith(status: FibonacciStatus.loading));
    try {
      final fibonacci = _generateFibonacci(event.n);
      emit(state.copyWith(
          status: FibonacciStatus.success, fibonacciList: fibonacci));
    } catch (e) {
      emit(state.copyWith(
          status: FibonacciStatus.failure, message: e.toString()));
    }
  }

  FutureOr<void> _addDataToBottomSheet(FibonacciAddNumber event, emit) {
    // adding the number to the typeMap
    final typeMap = state.typeMap;
    final typeList = typeMap[event.type] ?? [];
    final number = state.fibonacciList
        .firstWhere((element) => element.numberIndex == event.numberIndex);
    typeList.add(number);
    typeMap[event.type] = typeList;

    // disable the number from the fibonacciList
    final (fibonacciList, _) =
        _enableOrDisableNumber(event.numberIndex, isEnable: false);

    emit(state.copyWith(typeMap: typeMap, fibonacciList: fibonacciList,removeIndex: -1));
  }


  FutureOr<void> _removeDataFromBottomSheet(FibonacciRemoveNumber event, emit) {
    // removing the number from the typeMap
    final typeMap = state.typeMap;
    final typeList = typeMap[event.type] ?? [];
    typeList.removeWhere((element) => element.numberIndex == event.numberIndex);
    typeMap[event.type] = typeList;

    // enable the number from the fibonacciList
    var (fibonacciList, removeIndex) =
        _enableOrDisableNumber(event.numberIndex, isEnable: true);

    emit(state.copyWith(typeMap: typeMap, fibonacciList: fibonacciList,removeIndex: removeIndex));
  }

  (List<FibonacciNumber>, int) _enableOrDisableNumber(int numberIndex,
      {required bool isEnable}) {
    int index = state.fibonacciList
        .indexWhere((element) => element.numberIndex == numberIndex);
    var fibonacciList =  state.fibonacciList;
    
    fibonacciList[index] = fibonacciList[index].copyWith(isEnable: isEnable);
    return (fibonacciList , index);
  }

  /// Generates a list of Fibonacci numbers up to the nth number.
  /// 
  /// The parameter [n] specifies the number of Fibonacci numbers to generate.
  List<FibonacciNumber> _generateFibonacci(int n) {
    
    List<FibonacciNumber> fibonacciNumbers = [
      FibonacciNumber(type: _generateType(0), number: 0, numberIndex: 0),
      FibonacciNumber(type: _generateType(1), number: 1, numberIndex: 1),
    ];

    for (int i = 2; i <= n; i++) {
      int number =
          fibonacciNumbers[i - 1].number + fibonacciNumbers[i - 2].number;
      fibonacciNumbers
          .add(FibonacciNumber(
          type: _generateType(i), number: number, numberIndex: i));
    }

    return fibonacciNumbers;
  }

  FibonacciType _generateType(int index) {
    var remainder = index % 4;
    var quotient = index ~/ 4;
    if (remainder == 0) return FibonacciType.circle;

    return (quotient % 2 == 0) 
        ? (remainder == 3 ? FibonacciType.cross : FibonacciType.square)
        : (remainder == 3 ? FibonacciType.square : FibonacciType.cross);
  }
}
