import 'package:flutter/material.dart';

const double _kSpaceWidth = 10.0;
const double _kBorderWidth = 1.0;
const Color _kBorderColor = Colors.grey;

class SeriesCircleProfile extends StatelessWidget {
  final double size;
  final List<String> urlList;
  final bool isAsset;
  final double spaceWidth;
  final List<Map<bool, String>> mixUrlList;
  final bool isCoverUp;
  final bool isBorder;
  final Color borderColor;
  final double borderWidth;
  final Widget endIcon;

  SeriesCircleProfile(this.size,
      {this.urlList,
      this.isAsset,
      this.spaceWidth,
      this.mixUrlList,
      this.isCoverUp,
      this.isBorder,
      this.borderColor,
      this.borderWidth,
      this.endIcon});

  @override
  Widget build(BuildContext context) {
    List<Widget> _listWid = [Container(height: size)];
    if (isCoverUp ?? true) {
      if (urlList != null) {
        if (endIcon != null) {
          _listWid
              .add(_itemWid(isAsset ?? false, null, urlList.length, endIcon));
        }
        for (int i = urlList.length - 1; i >= 0; i--) {
          _listWid.add(_itemWid(isAsset ?? false, urlList[i], i, null));
        }
      } else if (mixUrlList != null) {
        if (endIcon != null) {
          _listWid.add(
              _itemWid(isAsset ?? false, null, mixUrlList.length, endIcon));
        }
        for (int i = mixUrlList.length - 1; i >= 0; i--) {
          _listWid.add(_itemWid(
              mixUrlList[i].keys.first, mixUrlList[i].values.first, i, null));
        }
      }
    } else {
      if (urlList != null) {
        for (int i = 0; i < urlList.length; i++) {
          _listWid.add(_itemWid(isAsset ?? false, urlList[i], i, null));
        }
        if (endIcon != null) {
          _listWid
              .add(_itemWid(isAsset ?? false, null, urlList.length, endIcon));
        }
      } else if (mixUrlList != null) {
        for (int i = 0; i < mixUrlList.length; i++) {
          _listWid.add(_itemWid(mixUrlList[i].keys.first ?? false,
              mixUrlList[i].values.first, i, null));
        }
        if (endIcon != null) {
          _listWid.add(
              _itemWid(isAsset ?? false, null, mixUrlList.length, endIcon));
        }
      }
    }

    return Stack(children: _listWid);
  }

  _itemWid(asset, url, index, endIcon) {
    return Positioned(
        left: (spaceWidth ?? _kSpaceWidth) * index,
        child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
                border: (isBorder ?? false) == false
                    ? null
                    : Border.all(
                        color: borderColor ?? _kBorderColor,
                        width: borderWidth ?? _kBorderWidth),
                color: Colors.grey,
                shape: BoxShape.circle),
            child: PhysicalModel(
                color: Colors.transparent,
                shape: BoxShape.circle,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: Container(
                    width: size,
                    height: size,
                    child: endIcon ??
                        (asset ? Image.asset(url) : Image.network(url))))));
  }
}
