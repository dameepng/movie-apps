import os

def replace_in_file(filepath, old_text, new_text):
    if not os.path.exists(filepath): return
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    content = content.replace(old_text, new_text)
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

# Fix main.dart
replace_in_file('lib/main.dart', 
    "import 'package:ditonton/presentation/pages/about_page.dart';", 
    "import 'package:about/about_page.dart';")
replace_in_file('lib/main.dart', 
    "const MyApp({super.key});", 
    "const MyApp({Key? key}) : super(key: key);")

# Fix home_movie_page.dart
replace_in_file('movie/lib/presentation/pages/home_movie_page.dart',
    "import 'package:ditonton/presentation/pages/about_page.dart';",
    "")
replace_in_file('movie/lib/presentation/pages/home_movie_page.dart',
    "import 'package:tv/presentation/pages/home_tv_page.dart';",
    "")
replace_in_file('movie/lib/presentation/pages/home_movie_page.dart',
    "AboutPage.routeName",
    "'/about'")
replace_in_file('movie/lib/presentation/pages/home_movie_page.dart',
    "HomeTVPage.routeName",
    "'/home-tv'")

# Fix home_tv_page.dart
replace_in_file('tv/lib/presentation/pages/home_tv_page.dart',
    "import 'package:ditonton/presentation/pages/about_page.dart';",
    "")
replace_in_file('tv/lib/presentation/pages/home_tv_page.dart',
    "AboutPage.routeName",
    "'/about'")

# Fix unused variables in pages
replace_in_file('movie/lib/presentation/pages/movie_detail_page.dart',
    "final genre =",
    "// final genre =")
replace_in_file('movie/lib/presentation/pages/movie_detail_page.dart',
    "final minutes =",
    "// final minutes =")
replace_in_file('tv/lib/presentation/pages/tv_detail_page.dart',
    "final genre =",
    "// final genre =")

# Fix ssl_pinning.dart
replace_in_file('core/lib/common/ssl_pinning.dart',
    "static HttpSSLPinning? _instance;",
    "")
replace_in_file('core/lib/common/ssl_pinning.dart',
    "catch (e) {",
    "catch (_) {")

# Fix unused imports in tests
replace_in_file('movie/test/presentation/pages/popular_movies_page_test.dart',
    "import 'package:core/common/state_enum.dart';",
    "")
replace_in_file('movie/test/presentation/pages/top_rated_movies_page_test.dart',
    "import 'package:core/common/state_enum.dart';",
    "")

# Add flutter_lints to dev_dependencies of all pubspecs
modules = ['core', 'about', 'movie', 'tv']
for m in modules:
    pubspec = f'{m}/pubspec.yaml'
    if os.path.exists(pubspec):
        with open(pubspec, 'r') as f:
            content = f.read()
        if 'flutter_lints:' not in content:
            content = content.replace('dev_dependencies:', 'dev_dependencies:\n  flutter_lints: ^2.0.0')
            with open(pubspec, 'w') as f:
                f.write(content)

print("Fixes applied.")
