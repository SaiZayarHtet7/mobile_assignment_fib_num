import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_assignment_fib_num/bloc/fibonacci_bloc.dart';
import 'package:mobile_assignment_fib_num/widget/item_widget.dart';

const name = 'ItemTypeListBottomSheet';

class ItemTypeListBottomSheet extends StatefulWidget {
  final int? highLighNumber;
  final FiboanacciType type;
  const ItemTypeListBottomSheet(
      {super.key, this.highLighNumber, required this.type});

  @override
  State<ItemTypeListBottomSheet> createState() =>
      _ItemTypeListBottomSheetState();
}

class _ItemTypeListBottomSheetState extends State<ItemTypeListBottomSheet> {
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.animateTo(controller.position.maxScrollExtent,
          duration: Durations.medium1, curve: Curves.easeInOut);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FibonacciBloc, FibonacciState, List<FibonacciNumber>>(
      selector: (state) => state.typeMap[widget.type] ?? [],
      builder: (context, fibonacciList) {
        return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return ListView.builder(
                controller: controller,
                itemBuilder: (context, index) {
                  final number = fibonacciList[index].number;
                  final isHighLighted = number == widget.highLighNumber;
                  final type = fibonacciList[index].type;
                  final numberIndex = fibonacciList[index].index;

                  return ItemWidget(
                      onTap: () {
                        Navigator.of(context).pop();
                        context.read<FibonacciBloc>().add(
                              FibonacciRemoveNumber(
                                type: type,
                                number: number,
                              ),
                            );
                      },
                      index: numberIndex,
                      selected: isHighLighted,
                      fibonacciNumber: number.toString(),
                      type: type);
                },
                itemCount: fibonacciList.length,
              );
            });
      },
    );
  }
}
