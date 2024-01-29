import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/services/common_api/common_api_service.dart';

class NetworkImageWidget extends StatefulWidget {
  String? imageName;
  double? width;
  double? height;

  NetworkImageWidget({
    required this.imageName,
    required width,
    required height,
  });
  @override
  State<StatefulWidget> createState() => _NetworkImageWidget();
}

class _NetworkImageWidget extends State<NetworkImageWidget> {
  var _commonService = locator<CommonApiService>();
  var imageUrl = '';
  bool isLoading = true;

  @override
  void initState() {
    _commonService.getImageByName(widget.imageName ?? "").then((value) {
      if (value.hasError == false) {
        setState(() {
          imageUrl = value.result['Image'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(height: 10, width: 10, child: CircularProgressIndicator())
        : imageUrl.isEmpty
            ? Container(
                width: widget.width,
                height: widget.height,
                child: Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: widget.height,
                    color: disableColor,
                  ),
                ),
              )
            : CachedNetworkImage(
                imageUrl: imageUrl,
                width: widget.width,
                height: widget.height,
                fit: BoxFit.cover,
              );
  }
}
