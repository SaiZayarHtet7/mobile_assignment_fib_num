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
            int scrollIndex = state.displayFibonaciList.indexWhere(
                (element) => element.numberIndex == state.removeIndex);
            await _animateToIndex(scrollIndex);
          }
        },
        builder: (context, state) {
          final fibonacciList = state.displayFibonaciList;
          final removeIndex = state.removeIndex;

          return FibonacciListWidget(
              controller: controller,
              fibonacciList: fibonacciList,
              removeIndex: removeIndex);
        },
      ),
    );
  }
}

/// A widget that displays a list of Fibonacci numbers.
///
/// This widget takes a [ScrollController], a list of [FibonacciNumber] objects,
/// and an index of the number to be highlighted. It builds a scrollable list
/// of items, each representing a Fibonacci number. When an item is tapped,
/// it triggers an event to add a new Fibonacci number and shows a bottom sheet
/// with the item type list.
///
/// Parameters:
/// - [controller]: The [ScrollController] for the list view.
/// - [fibonacciList]: The list of [FibonacciNumber] objects to display.
/// - [removeIndex]: The index of the Fibonacci number to be highlighted.
class FibonacciListWidget extends StatelessWidget {
  const FibonacciListWidget({
    super.key,
    required this.controller,
    required this.fibonacciList,
    required this.removeIndex,
  });

  final ScrollController controller;
  final List<FibonacciNumber> fibonacciList;
  final int removeIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemBuilder: (_, index) {
        final number = fibonacciList[index].number;
        final type = fibonacciList[index].type;
        final numberIndex = fibonacciList[index].numberIndex;
        return ItemWidget(
            onTap: () async {
              context.read<FibonacciBloc>().add(
                  FibonacciAddNumber(type: type, numberIndex: numberIndex));
              await showModalBottomSheet(
                context: context,
                builder: (context) => ItemTypeListBottomSheet(
                  type: type,
                  highlightNumberIndex: numberIndex,
                ),
              );
            },
            color: Colors.red,
            index: numberIndex,
            selected: removeIndex == numberIndex,
            fibonacciNumber: number.toString(),
            type: type,);
      },
      itemCount: fibonacciList.length,
    );
  }
}
