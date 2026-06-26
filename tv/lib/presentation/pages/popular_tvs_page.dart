import 'package:tv/presentation/bloc/popular_tvs/popular_tvs_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTVsPage extends StatefulWidget {
  static const routeName = '/popular-tv';

  const PopularTVsPage({Key? key}) : super(key: key);

  @override
  State<PopularTVsPage> createState() => _PopularTVsPageState();
}

class _PopularTVsPageState extends State<PopularTVsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<PopularTVsBloc>().add(FetchPopularTVs());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTVsBloc, PopularTVsState>(
          builder: (context, state) {
            if (state is PopularTVsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTVsHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TVCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is PopularTVsError) {
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
