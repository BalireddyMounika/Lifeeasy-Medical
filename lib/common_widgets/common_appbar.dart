import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/margins.dart';
import 'package:lifeeazy_medical/constants/styles.dart';

class CommonAppBar extends StatelessWidget implements PreferredSize{
  final String? title;
  final VoidCallback? onBackPressed;
  final VoidCallback? onClearPressed;
  final bool? isClearButtonVisible;
  CommonAppBar({
    this.title,
    this.onBackPressed,
    this.onClearPressed,
    this.isClearButtonVisible,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      backgroundColor: appBarColor,
      elevation: 0,
      title: Text(this.title ?? "",style: appBarTitleTextStyle,overflow: TextOverflow.ellipsis,),
      shadowColor: appBarShadowColor,
      leading: InkWell(
        onTap: onBackPressed,
        child: Icon(
          Icons.arrow_back_outlined,
          size: 24,
          color: Colors.black,
        ),
      ),
      actions: [
        Visibility(
          visible:isClearButtonVisible??true,
          child: InkWell(
            onTap:onClearPressed,
            child: Padding(
              padding: const EdgeInsets.only(right: appBarClearButtonPaddingRight),
              child: Icon(
                Icons.clear,
                size: 24,
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }


  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}
