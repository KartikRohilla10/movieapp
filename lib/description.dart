import 'package:flutter/material.dart';
import 'package:movieapp/utils/text.dart';

class Description extends StatefulWidget {
  final String name, description, bannerurl, posterurl, vote, launch_on;

  const Description({
    Key? key,
    required this.name,
    required this.description,
    required this.bannerurl,
    required this.posterurl,
    required this.vote,
    required this.launch_on,
  }) : super(key: key);

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  bool isFavorite = false;

  // Placeholder for favorite movies list
  List<String> favoriteMovies = [];

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
        favoriteMovies.add(widget.name);
      } else {
        favoriteMovies.remove(widget.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                Positioned(
                  child: SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      widget.bannerurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: modified_text(
                    text: '⭐ Average Rating:-${widget.vote}',
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: modified_text(
              text: widget.name,
              color: Colors.black,
              size: 18,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: modified_text(
              text: 'Releasing on ${widget.launch_on}',
              color: Colors.white,
              size: 14,
            ),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                height: 200,
                width: 100,
                child: Image.network(widget.posterurl),
              ),
              Flexible(
                child: Container(
                  child: modified_text(
                      text: widget.description, color: Colors.black, size: 18),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
