import 'package:flutter/material.dart';

import '../main.dart';

class MovieList extends StatelessWidget {
  final List movieList;
  MovieList(this.movieList);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.89,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1 / 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0),
                itemCount: movieList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        MovieListRoute.movieDetails = movieList;
                        MovieListRoute.movieCounter = index;
                        print(index);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieListRoute()),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'http://image.tmdb.org/t/p/w500' +
                                        movieList[index]['poster_path']),
                              )),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Text(
                                  movieList[index]['title'] != null
                                      ? movieList[index]['title']
                                      : 'No-Name',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
