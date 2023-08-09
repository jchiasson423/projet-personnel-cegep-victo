import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

/// Carrousel de base pour afficher une liste de widgets
class BaseCarousel extends StatefulWidget {
  /// Message à afficher si la liste est vide
  final String noResultMessage;

  /// Liste des widgets à afficher
  final List<Widget> items;

  /// Hauteur du carrousel
  final double height;

  /// Constructeur
  const BaseCarousel({
    super.key,
    required this.noResultMessage,
    required this.items,
    this.height = 350,
  });

  @override
  State<BaseCarousel> createState() => _BaseCarouselState();
}

class _BaseCarouselState extends State<BaseCarousel> {
  @override
  Widget build(BuildContext context) {
    // Affiche un message si la liste est vide
    if (widget.items.isEmpty) {
      return SizedBox(
        height: widget.height,
        child: Center(
          child: Text(widget.noResultMessage),
        ),
      );
    }

    // Affiche le carrousel
    return CarouselSlider(
      items: widget.items,
      options: CarouselOptions(
        aspectRatio: 1,
        height: widget.height,
        enableInfiniteScroll: false,
        disableCenter: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
      ),
    );
  }
}
