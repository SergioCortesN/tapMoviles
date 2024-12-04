import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_application_1/models/popular_model.dart';
import 'package:flutter_application_1/network/api_popular.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailPopular extends StatefulWidget {
  const DetailPopular({super.key});

  @override
  State<DetailPopular> createState() => _DetailPopularState();
}

class _DetailPopularState extends State<DetailPopular> {
  YoutubePlayerController? _youtubeController;
  String? trailerUrl;
  String? videoKey; 
  bool isVideoAvailable = false; 
  List<Map<String, dynamic>> actors = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final popular = ModalRoute.of(context)!.settings.arguments as PopularModel;

    ApiPopular().getTrailer(popular.id).then((url) {
      if (url != null) {
        setState(() {
          trailerUrl = url;
          videoKey = YoutubePlayer.convertUrlToId(trailerUrl!);
          if (videoKey != null) {
            isVideoAvailable = true;
            _youtubeController = YoutubePlayerController(
              initialVideoId: videoKey!,
              flags: const YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
              ),
            );
          }
        });
      }
    });

    ApiPopular().getActors(popular.id).then((actorList) {
      setState(() {
        actors = actorList;
      });
    });
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context)!.settings.arguments as PopularModel;

    
    Color starCol;
    if (popular.voteAverage < 5) {
      starCol = const Color.fromARGB(255, 255, 48, 48); 
    } else if (popular.voteAverage >= 5 && popular.voteAverage < 8) {
      starCol = const Color.fromARGB(255, 255, 255, 0); 
    } else {
      starCol = const Color.fromARGB(255, 28, 255, 35); 
    }

    double rating = (popular.voteAverage / 2).clamp(0, 5);
    return Scaffold(
      appBar: AppBar(
        title: Text(popular.title),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${popular.posterPath}'),
                colorFilter: ColorFilter.mode(
                    const Color.fromARGB(255, 0, 3, 54).withOpacity(0.8), BlendMode.darken),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: popular.id,
                        child: Container(
                          width: 175,
                          height: 275,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500/${popular.posterPath}'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20), 
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              popular.title,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              popular.overview,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                              ),
                              maxLines: 10, 
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  RatingBarIndicator(
                    rating: rating,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: starCol, 
                    ),
                    itemCount: 5,
                    itemSize: 30.0,
                  ),
                  Text(
                    'Calificación: ${popular.voteAverage} / 10',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Reparto: ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  actors.isNotEmpty
                      ? SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal, 
                            itemCount: actors.length,
                            itemBuilder: (context, index) {
                              final actor = actors[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: actor['profilePath'] !=
                                              null
                                          ? NetworkImage(
                                              'https://image.tmdb.org/t/p/w500/${actor['profilePath']}')
                                          : const AssetImage(
                                                  'assets/default_actor.png')
                                              as ImageProvider,

                                          fit: BoxFit.cover
                                              ),
                                      ),
                                      
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      actor['name'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      actor['character'],
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 192, 242, 203),
                                        fontSize: 10,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: Text(
                            "Cargando actores...",
                            style: TextStyle(color: Colors.white),
                          ),
                      ),
                  if (isVideoAvailable)
                  YoutubePlayer(
                      controller: _youtubeController!,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.amber,
                    )
                  else
                    const Center(
                      child: Text(
                        "No hay tráiler disponible.",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const SizedBox(height: 20), 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
