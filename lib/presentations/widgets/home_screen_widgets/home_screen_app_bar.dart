import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 76,
      // Set the preferredSize
      elevation: 0,
      automaticallyImplyLeading: false,
      // Remove the shadow
      backgroundColor: Colors.transparent,
      // Make the background transparent
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16.0, bottom: 5),
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.settings),
          ),
        ),
      ],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/show_icon.svg',
            width: 20,
            height: 19.84,
            fit: BoxFit.none,
          ),
        ],
      ),
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(76);
}
