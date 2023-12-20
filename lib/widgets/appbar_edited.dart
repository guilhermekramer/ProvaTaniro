import 'package:flutter/material.dart';

class AppbarEdited extends StatelessWidget implements PreferredSizeWidget {
  const AppbarEdited({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      title: Container(
        width: double.infinity,
        child: Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              Image.asset(
                'lib/assets/pokeball_icon_use.png',
                height: 40,
                width: 40,
              ),
              Image.asset(
                'lib/assets/pokemon.png',
                height: 60,
                width: 200,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(165, 214, 167, 1),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
