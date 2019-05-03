import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewerPage extends StatefulWidget {
  final List<String> _images;
  final int _currentIndex;
  final String _heroTag;
  ImageViewerPage(this._images, this._currentIndex, this._heroTag);

  @override
  State<StatefulWidget> createState() => ImageViewerState();
}

class ImageViewerState extends State<ImageViewerPage> {

  String _appBarTitle;

  PageController _pageController;
  int offsetImageNumber;

  @override
  void initState() {
    _appBarTitle = '${widget._currentIndex + 1} / ${widget._images.length}';
    _pageController = PageController(initialPage: widget._currentIndex);
    _setImageCount(widget._currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      _updateWidgetAfterSwiping();
    });

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(_appBarTitle),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, offsetImageNumber);
            },
          ),
        ),
        backgroundColor: Colors.black,
        body: PhotoViewGallery(
          pageController: _pageController,
          pageOptions: _showGallery(),
        ),
      ),
    );
  }

  void _updateWidgetAfterSwiping() {
    var currentPage = _pageController.page.round();

      _appBarTitle = '${currentPage + 1} / ${widget._images.length}';
     setState(() {
       _setImageCount(currentPage - widget._currentIndex);
    });
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



  void _setImageCount(int offset) {
    offsetImageNumber = offset;
  }
}
