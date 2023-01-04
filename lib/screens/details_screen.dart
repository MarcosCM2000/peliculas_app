import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  //  TODO: Cambiar luego por una instancia de movie

  @override
  Widget build(BuildContext context) {
    //  Leer argumentos
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    //  print(movie);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(
            title: movie.title,
            backdropPath: movie.fullBackdropPath,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            _PosterAndTitle(
              fullPosterImg: movie.fullPosterImg,
              originalTitle: movie.originalTitle,
              title: movie.title,
              voteAverage: movie.voteAverage,
            ),
            _Overview(overview: movie.overview),
            const CastingCardsScreen()
          ]))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar(
      {super.key, required this.title, required this.backdropPath});

  final String title;
  final String backdropPath;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(backdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  _PosterAndTitle(
      {super.key,
      required this.title,
      required this.originalTitle,
      required this.fullPosterImg,
      required this.voteAverage});

  final String title;
  final String originalTitle;
  final String fullPosterImg;
  final double voteAverage;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            height: 150,
            width: 110,
            placeholder: const AssetImage('assets/no-image.jpg'),
            image: NetworkImage(fullPosterImg),
          ),
        ),
        const SizedBox(width: 20),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: size.width - 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2),
              Text(
                originalTitle,
                style: textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_outline,
                    size: 25,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  Text('$voteAverage', style: textTheme.caption)
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}

class _Overview extends StatelessWidget {
  _Overview({super.key, required this.overview});

  final String overview;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        overview,
        textAlign: TextAlign.justify,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
