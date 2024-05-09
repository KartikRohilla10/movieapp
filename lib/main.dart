import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:movieapp/widgets/bottom.dart';
import 'package:movieapp/widgets/toprated.dart';
import 'package:movieapp/widgets/tv.dart';
import 'package:movieapp/widgets/trending.dart';
import 'package:movieapp/widgets/hamburger.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromARGB(255, 74, 219, 245),
        scaffoldBackgroundColor: Colors.black,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  Brightness _currentBrightness = Brightness.dark;
  TextEditingController _searchController = TextEditingController();
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];
  List<String> favoriteMovies = [];

  @override
  void initState() {
    loadmovies();
    super.initState();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys('395f8d4d09a0f44dd87820ceabe113c6',
          'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOTVmOGQ0ZDA5YTBmNDRkZDg3ODIwY2VhYmUxMTNjNiIsInN1YiI6IjY1ZmQyOTk1NjA2MjBhMDE3YzI5MzIwZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.tS2k4_KBjxdeg5EAq2ZaGnkFs1P07YmLp0NvUEYYLD8'),
      logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true),
    );

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPopular();

    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
    });
  }

  void toggleTheme() {
    setState(() {
      _currentBrightness = _currentBrightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: _currentBrightness,
        primaryColor: const Color.fromARGB(255, 74, 219, 245),
        scaffoldBackgroundColor:
        _currentBrightness == Brightness.dark ? Colors.black : Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Flutter Movie App 📽️ ❤️',
            style: TextStyle(
              color: _currentBrightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MovieSearchDelegate(),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.lightbulb),
              onPressed: toggleTheme,
            ),
          ],
        ),
        body: _selectedIndex == 0
            ? HomePageView(
          trendingmovies: trendingmovies,
          topratedmovies: topratedmovies,
          tv: tv,
        )
            : _selectedIndex == 1
            ? ListView(
          children: [
            TopRated(
              topRated: topratedmovies,
            ),
          ],
        )
            : _selectedIndex == 2
            ? ListView(
          children: [
            TvWidget(
              tvShows: tv,
            ),
          ],
        )
            : _selectedIndex == 3
            ? ListView(
          children: [
            TrendingMovies(
              trending: trendingmovies,
            ),
          ],
        )
            : null,
        bottomNavigationBar: Bottom(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
        drawer: HamburgerMenu(
          favoriteMovies: favoriteMovies,
          onTapFavorites: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoriteMoviesScreen(
                  favoriteMovies: favoriteMovies,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class HomePageView extends StatelessWidget {
  final List trendingmovies;
  final List topratedmovies;
  final List tv;

  HomePageView({
    required this.trendingmovies,
    required this.topratedmovies,
    required this.tv,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              TopRated(topRated: topratedmovies),
              TvWidget(tvShows: tv),
              TrendingMovies(trending: trendingmovies),
            ],
          ),
        ),
      ],
    );
  }
}

class FavoriteMoviesScreen extends StatelessWidget {
  final List<String> favoriteMovies;

  const FavoriteMoviesScreen({Key? key, required this.favoriteMovies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite Movies')),
      body: ListView.builder(
        itemCount: favoriteMovies.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteMovies[index]),
          );
        },
      ),
    );
  }
}

class MovieSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(); // Implement search results here
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(); // Implement search suggestions here
  }
}
