import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:core/common/constants.dart';
import 'package:core/common/ssl_pinning.dart';
import 'package:core/common/utils.dart';
import 'package:about/about_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:tv/presentation/pages/home_tv_page.dart';
import 'package:tv/presentation/pages/on_the_air_tvs_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:tv/presentation/pages/popular_tvs_page.dart';
import 'package:movie/presentation/pages/search_page.dart';
import 'package:tv/presentation/pages/search_tv_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:tv/presentation/pages/top_rated_tvs_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/presentation/pages/tv_season_detail_page.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:tv/presentation/pages/watchlist_tvs_page.dart';

import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:tv/presentation/bloc/on_the_air_tvs/on_the_air_tvs_bloc.dart';
import 'package:tv/presentation/bloc/popular_tvs/popular_tvs_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tvs/top_rated_tvs_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_season_detail/tv_season_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_search/tv_search_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tvs/watchlist_tvs_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinning.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnTheAirTVsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSeasonDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTVsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTVsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTVsBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          drawerTheme: kDrawerTheme,
        ),
        home: const HomeMoviePage(),
        navigatorObservers: [
          routeObserver,
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        ],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case '/home-tv':
              return MaterialPageRoute(builder: (_) => const HomeTVPage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => const PopularMoviesPage());
            case PopularTVsPage.routeName:
              return CupertinoPageRoute(builder: (_) => const PopularTVsPage());
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => const TopRatedMoviesPage());
            case TopRatedTVsPage.routeName:
              return CupertinoPageRoute(builder: (_) => const TopRatedTVsPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TVDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVDetailPage(id: id),
                settings: settings,
              );
            case TVSeasonDetailPage.routeName:
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (_) => TVSeasonDetailPage(
                  id: args['id'],
                  seasonNumber: args['seasonNumber'],
                ),
                settings: settings,
              );
            case SearchPage.routeName:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case SearchTVPage.routeName:
              return CupertinoPageRoute(builder: (_) => const SearchTVPage());
            case WatchlistMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => const WatchlistMoviesPage());
            case WatchlistTVsPage.routeName:
              return MaterialPageRoute(builder: (_) => const WatchlistTVsPage());
            case OnTheAirTVsPage.routeName:
              return CupertinoPageRoute(builder: (_) => const OnTheAirTVsPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
