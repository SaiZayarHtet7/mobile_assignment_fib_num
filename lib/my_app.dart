import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_assignment_fib_num/bloc/fibonacci_bloc.dart';
import 'package:mobile_assignment_fib_num/screen/fibonacci_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FibonacciBloc()..add(FibonacciGenerateList(n: 40)),
      child: MaterialApp(
        home: FibonacciListScreen(),
      ),
    );
  }
}

