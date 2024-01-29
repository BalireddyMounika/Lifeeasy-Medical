import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/viewmodel/dashboard/dashboard_viewmodel.dart';
import 'package:stacked/stacked.dart';

class DashBoardAppBar extends ViewModelWidget<DashBoardViewModel>
    implements PreferredSizeWidget {
  late BuildContext context, _context;
  late DashBoardViewModel viewModel;
  DashBoardAppBar(this.context);
  @override
  Widget build(BuildContext context, DashBoardViewModel viewModel) {
    _context = context;
    this.viewModel = viewModel;
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _topView(),
      ],
    ));
  }

  Widget _topView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            Icons.menu_outlined,
            size: 24,
            color: baseColor,
          ),
          onPressed: () {
            Scaffold.of(_context).openDrawer();
          },
        ),
        Spacer(),
        Image.asset(
          'images/lifeeazy.png',
          width: 150,
        ),
        Spacer(),
        Text(
          '${viewModel.authCode}',
          style: mediumTextStyle.copyWith(
              fontWeight: FontWeight.bold, color: secondaryColor),
        ),
        horizontalSpaceSmall,
        IconButton(
          icon: Icon(
            Icons.notifications,
            size: 24,
            color: baseColor,
          ),
          onPressed: () {
            locator<NavigationService>()
                .navigateTo(Routes.notificationsAlertsView);
          },
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
