import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_assignment_fib_num/bloc/fibonacci_bloc.dart';
import 'package:mobile_assignment_fib_num/widget/item_type_list_bottom_sheet.dart';
import 'package:mobile_assignment_fib_num/widget/item_widget.dart';
import 'package:flutter/material.dart';

class FibonacciListScreen extends StatefulWidget {
  const FibonacciListScreen({super.key});

  @override
  State<FibonacciListScreen> createState() => _FibonacciListScreenState();
}

class _FibonacciListScreenState extends State<FibonacciListScreen> {
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  Future<void> _animateToIndex(int index) async {
    await controller.animateTo(
      index * kToolbarHeight,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext _) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fibonacci Numbers'),
      ),
      body: BlocConsumer<FibonacciBloc, FibonacciState>(
        listener: (context, state) async {
          if (state.status == FibonacciStatus.success &&
              state.removeIndex != -1) {
            int scrollIndex = state.displayFibonaciList.indexWhere((element) =>
                element.index == state.removeIndex);
            await _animateToIndex(scrollIndex);
          }
        },
        builder: (context, state) {
          final fibonacciList = state.displayFibonaciList;
          final removeIndex = state.removeIndex;

          return ListView.builder(
            controller: controller,
            itemBuilder: (_, index) {
              final number = fibonacciList[index].number;
              final type = fibonacciList[index].type;
              final numberIndex = fibonacciList[index].index;
              return ItemWidget(
                  onTap: () {
                    context
                        .read<FibonacciBloc>()
                        .add(FibonacciAddNumber(type: type, number: number));
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => ItemTypeListBottomSheet(
                              type: type,
                              highLighNumber: number,
                            ));
                  },
                  color: Colors.red,
                  index: numberIndex,
                  selected: removeIndex == numberIndex,
                  fibonacciNumber: number.toString(),
                  type: type);
            },
            itemCount: fibonacciList.length,
          );
        },
      ),
    );
  }
}
