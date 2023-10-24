import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StarRating extends StatefulWidget {
  StarRating({this.rating = 5, this.size = 14});
  int? rating;
  double? size;
  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              widget.rating = index + 1;
            });
          },
          child: Icon(
            Icons.star,
            size: widget.size,
            color: index < widget.rating!
                ? Colors.amber
                : Colors.grey, // Star color
          ),
        );
      }),
    );
  }
}
