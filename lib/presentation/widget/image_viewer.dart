import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageViewerPage extends StatefulWidget {
  final List<String> _images;
  final int _currentIndex;
  final String _heroTag;
  ImageViewerPage(this._images, this._currentIndex, this._heroTag);

  @override
  State<StatefulWidget> createState() => ImageViewerState();
}

class ImageViewerState extends State<ImageViewerPage> {
  @override
  Widget build(BuildContext context) {
    _setImageCount(widget._currentIndex);

    var page = PageController(initialPage: widget._currentIndex);
    page.addListener(() {
      var currentPage = page.page.round();
      _setImageCount(currentPage - widget._currentIndex);
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,

      ),
      backgroundColor: Colors.black,
      body: PhotoViewGallery(
        pageController: page,
        pageOptions: _showGallery(),
      ),
    );
  }

  List<PhotoViewGalleryPageOptions> _showGallery() {

    List<PhotoViewGalleryPageOptions> gallery = [];
    for (int i = 0; i < widget._images.length; i++) {
      gallery.add(PhotoViewGalleryPageOptions(
        imageProvider: AssetImage(widget._images[i]),
        heroTag: '${widget._heroTag}$i',
      ));
    }
    return gallery;
  }

  void _setImageCount(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('BanknoteDetailsPage_imageNumber', index);
  }
}
