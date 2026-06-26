import 'package:ditonton/presentation/bloc/on_the_air_tvs/on_the_air_tvs_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnTheAirTVsPage extends StatefulWidget {
  static const routeName = '/on-the-air-tv';

  const OnTheAirTVsPage({Key? key}) : super(key: key);

  @override
  State<OnTheAirTVsPage> createState() => _OnTheAirTVsPageState();
}

class _OnTheAirTVsPageState extends State<OnTheAirTVsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<OnTheAirTVsBloc>().add(FetchOnTheAirTVs());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Air TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnTheAirTVsBloc, OnTheAirTVsState>(
          builder: (context, state) {
            if (state is OnTheAirTVsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OnTheAirTVsHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TVCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is OnTheAirTVsError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
