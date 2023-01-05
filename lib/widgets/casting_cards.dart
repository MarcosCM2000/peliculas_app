import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCardsScreen extends StatelessWidget {
  const CastingCardsScreen({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.getMovieCast(id),
      builder: (BuildContext _, AsyncSnapshot<List<Cast>> snapshot) {
        //  Al momento de crearse el widget
        if (!snapshot.hasData) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            child: const CupertinoActivityIndicator(),
          );
        }
        final cast = snapshot.data!;
        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
              itemCount: cast.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                return _CastCard(actor: cast[index]);
              })),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  _CastCard({super.key, required this.actor});
  final Cast actor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            image: NetworkImage(actor.fullProfilePath),
            placeholder: const AssetImage('assets/no-image.jpg'),
            width: 100,
            height: 140,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(actor.name, maxLines: 2, overflow: TextOverflow.ellipsis)
      ]),
    );
  }
}
