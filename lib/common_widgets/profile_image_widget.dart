import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/network_image_widget.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';

class ProfileImageWidget extends StatelessWidget {
  late double circleSize;
  ProfileImageWidget({required this.circleSize});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: circleSize,
      width: circleSize,
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: Border.all(color: Colors.black)),
      child: SessionManager.profileImageUrl!.isNotEmpty
          ? SizedBox(
              height: circleSize,
              width: circleSize,
              child: ClipOval(
                  child: NetworkImageWidget(
                imageName: SessionManager.profileImageUrl ?? "",
                height: circleSize,
                width: circleSize,
              )))
          : CircleAvatar(
              backgroundColor: Colors.white,
              child: SizedBox(
                  height: circleSize,
                  width: circleSize,
                  child: CircleAvatar(
                      backgroundImage:
                          Image.asset("images/dashboard/profile_dummy.png")
                              .image)),
            ),
    );
  }
}
