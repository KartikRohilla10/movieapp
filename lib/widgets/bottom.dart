import 'package:flutter/material.dart';

class Bottom extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const Bottom({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Top Rated',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tv),
          label: 'TV Shows',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up),
          label: 'Trending',
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: Color.fromARGB(255, 255, 143, 0),
      unselectedItemColor: Color.fromARGB(255, 246, 175, 116),
      onTap: widget.onItemTapped,
    );
  }
}
