import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {}, 
          color: Theme.of(context).appColors.drawerBackground,
        icon: Icon(
          Icons.menu_outlined,
          color: Theme.of(context).appColors.boldBlack,
          
          
        )),
      ),
      
      
      body: Column(children: [Text('Home')]));
  }
}
