import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewerPage extends StatefulWidget {
  final List<String> _images;
  final int _currentIndex;
  final String _heroTag;
  ImageViewerPage(this._images, this._currentIndex, this._heroTag);

  @override
  State<StatefulWidget> createState() {
    return ImageViewerState();
  }
}

class ImageViewerState extends State<ImageViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
      PhotoViewGallery(
        pageController: PageController(initialPage: widget._currentIndex),
        pageOptions: _showGallery(),
        backgroundDecoration: BoxDecoration(color: Colors.white24),
      ),
    );
  }

  List<PhotoViewGalleryPageOptions> _showGallery() {
    List<PhotoViewGalleryPageOptions> gallery = [];
    for (int i = 0; i < widget._images.length; i++) {
      gallery.add(PhotoViewGalleryPageOptions(
        imageProvider: AssetImage(widget._images[i]),
        heroTag: "${widget._heroTag}$i",
      ));

    }

    return gallery;
  }
}
