import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_season_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TVSeasonDetailPage extends StatefulWidget {
  static const routeName = '/tv-season-detail';

  final int id;
  final int seasonNumber;

  const TVSeasonDetailPage(
      {Key? key, required this.id, required this.seasonNumber})
      : super(key: key);

  @override
  State<TVSeasonDetailPage> createState() => _TVSeasonDetailPageState();
}

class _TVSeasonDetailPageState extends State<TVSeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TVSeasonDetailNotifier>(context, listen: false)
          .fetchTVSeasonDetail(widget.id, widget.seasonNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Season ${widget.seasonNumber} Episodes'),
      ),
      body: Consumer<TVSeasonDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.state == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.state == RequestState.Loaded) {
            final episodes = provider.seasonDetail.episodes;
            if (episodes.isEmpty) {
              return const Center(child: Text('No episodes found.'));
            }
            return ListView.builder(
              itemCount: episodes.length,
              itemBuilder: (context, index) {
                final episode = episodes[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 80,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(8)),
                          child: episode.stillPath != null
                              ? CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w500${episode.stillPath}',
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )
                              : Container(
                                  color: Colors.grey,
                                  child:
                                      const Icon(Icons.tv, color: Colors.white),
                                ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${episode.episodeNumber}. ${episode.name}',
                                style: kHeading6,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: kMikadoYellow, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${episode.voteAverage}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                episode.overview.isNotEmpty
                                    ? episode.overview
                                    : 'No overview available.',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[400]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (provider.state == RequestState.Error) {
            return Center(
              child: Text(provider.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
