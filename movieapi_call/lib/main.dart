import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'widgets/movieList.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(initialRoute: '/', routes: {
    '/': (maincontext) => MainRoute(),
    '/movielist': (movielistcontext) => MovieListRoute(),
  }));
}

class MainRoute extends StatefulWidget {
  @override
  State<MainRoute> createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  List movieList = [];
  final String apiKeyV3 = '84e235a0591e5abcda81cd66b0b2a735'; //fetch API key
  final apiReadAccessTokenv4 =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NGUyMzVhMDU5MWU1YWJjZGE4MWNkNjZiMGIyYTczNSIsInN1YiI6IjYyY2U4NTZjMGQ1ZDg1MDA2MGRmOTBjYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wwzbzk1sJlL6vJYvGTmPvOut9m1w2AXZ5Qw4WZHVsaI';
  @override
  //Movie Function
  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKeyV3, apiReadAccessTokenv4),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));

    Map movieResult = await tmdbWithCustomLogs.v3.trending.getTrending();
    setState(() {
      movieList = movieResult['results'];
    });
    print(movieList);
  }

//Caller Function
  @override
  void initPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void initState() {
    initPortrait();
    loadmovies();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MovieListAPI"),
        backgroundColor: Colors.black87,
      ),
      body: ListView(
        children: [
          MovieList(movieList),
        ],
      ),
    );
  }
}

class MovieListRoute extends StatelessWidget {
  static List movieDetails;
  static int movieCounter;
  void showToast() {
    Fluttertoast.showToast(
      msg: 'Thank You For watching',
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage('http://image.tmdb.org/t/p/w500' +
                      movieDetails[movieCounter]['poster_path']),
                )),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    movieDetails[movieCounter]['title'] != null
                        ? movieDetails[movieCounter]['title']
                        : 'No-Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    movieDetails[movieCounter]['title'] != null
                        ? 'Released Date: ' +
                            movieDetails[movieCounter]['release_date']
                                .toString() +
                            "   " +
                            'Vote Average: ' +
                            movieDetails[movieCounter]['vote_average']
                                .toString() +
                            "   " +
                            'Vote Count: ' +
                            movieDetails[movieCounter]['vote_count'].toString()
                        : 'No-Name',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.18,
                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: SingleChildScrollView(
                  child: SizedBox(
                    child: Text(
                      movieDetails[movieCounter]['title'] != null
                          ? movieDetails[movieCounter]['overview']
                          : 'No-Name',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[900],
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    showToast();
                  },
                  child: Text(
                    'WATCH TRAILER',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
