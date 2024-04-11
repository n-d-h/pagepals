import 'package:flutter/material.dart';
import 'package:pagepals/models/reader_models/popular_reader_model.dart';

class FavoriteButton extends StatefulWidget {
  final List<PopularReader> readers;
  final int index;

  const FavoriteButton({super.key, required this.readers, required this.index});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late List<bool> _clickedList;

  @override
  void initState() {
    super.initState();
    _clickedList = List.generate(widget.readers.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        setState(() {
          _clickedList[widget.index] = !_clickedList[widget.index];
        });
      },
      icon: Icon(
        _clickedList[widget.index]
            ? Icons.favorite
            : Icons.favorite_border_sharp,
        size: 25,
        color: _clickedList[widget.index] ? Colors.red : Colors.black12,
      ),
    );
  }
}
