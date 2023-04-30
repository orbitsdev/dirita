import 'package:dirita_tourist_spot_app/pages/auth/controller/auth_controller.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/widgets/h_space.dart';
import 'package:dirita_tourist_spot_app/widgets/profile_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/rectangle_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final authcontroller = Get.find<AuthController>();
  final _key = GlobalKey<FormState>();

  void _openDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
            )),
        title: Text('Manage Tourist Spot'),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: () => _openDrawer(context),
              icon: ProfileWidget(
                url: authcontroller.user.value.profile_image,
              ),
            );
          }),
          const HSpace(10),
        ],
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: ListView(children: [
            ListTile(
                onTap: () => authcontroller.logout(context),
                leading: Icon(
                  Icons.logout,
                  color: AppTheme.FONT,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 18, color: AppTheme.FONT),
                )),
          ]),
        ),
      ),
      body: ListView.separated(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            minVerticalPadding: 0.0,
            leading: RectangleImageWidget(
              width: 50,
              height: 200,
              viewable: true,
            ),
            title: Text('Balot Island'),
            subtitle: Text('Quelio 123 St Pampangga'),
            trailing: IconButton(onPressed: (){}, icon: Icon(Icons.delete, ), ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[300],
          );
        },
      ),
    );
  }
}
