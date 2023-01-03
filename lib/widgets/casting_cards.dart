import 'package:flutter/material.dart';

class CastingCardsScreen extends StatelessWidget {
  const CastingCardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      width: double.infinity,
      height: 180,
      child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            return const _CastCard();
          })),
    );
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: const FadeInImage(
            image: NetworkImage(
                'https://images.nintendolife.com/b4fb0f19f7ab7/twilight-princess.large.jpg'),
            placeholder: AssetImage('assets/no-image.jpg'),
            width: 100,
            height: 140,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text('Actor.name', maxLines: 2, overflow: TextOverflow.ellipsis)
      ]),
    );
  }
}
