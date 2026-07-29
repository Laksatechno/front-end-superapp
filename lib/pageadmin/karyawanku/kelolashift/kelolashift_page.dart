import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/kelola_shift_bloc.dart';

class KelolaShiftPage extends StatelessWidget {
  const KelolaShiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KelolaShiftBloc()..add(LoadShiftEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kelola Shift'),
        ),
        body: BlocBuilder<KelolaShiftBloc, KelolaShiftState>(
          builder: (context, state) {
            if (state is KelolaShiftLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is KelolaShiftLoaded) {
              return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.data[index].toString()),
                  );
                },
              );
            } else if (state is KelolaShiftError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Tidak ada data shift'));
          },
        ),
      ),
    );
  }
}
