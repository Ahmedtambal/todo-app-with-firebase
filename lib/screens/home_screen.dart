import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:to_do_app_with_firebase/config.dart';
import 'package:to_do_app_with_firebase/controllers/home_controller.dart';
import 'package:to_do_app_with_firebase/screens/login_screen.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController _homeController = Get.put(HomeController());
  final TextEditingController _taskTxtController = TextEditingController();

  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(context),
        body: GetBuilder<HomeController>(
          builder: (_) {
            if (_homeController.state)
              return Center(child: CircularProgressIndicator());
            else if (_homeController.tasks.isEmpty)
              return Container(
                child: Center(
                  child: Image(
                    image: AssetImage("assets/no_task.png"),
                  ),
                ),
              );

            return ListView.builder(
              itemCount: _homeController.tasks.length,
              itemBuilder: (context, int index) {
                return ListTile(
                  title: Text(_homeController.tasks[index].task),
                  onTap: null,
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _homeController.deleteTask(task: _homeController.tasks[index]);
                    },
                  ),
                );
              },
            );
          },
        ),


        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showDiloag(
              context: context,
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
          elevation: 4,
          backgroundColor: k_primaryColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[],
          ),
        ),

          drawer: Drawer(
            child: Container(
              decoration:BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                      colors: [
                        Colors.blueGrey,
                        Colors.white,
                      ]
                  )
              ) ,
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.cyan[900],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                        colors: [ Colors.cyan,Theme.of(context).accentColor,],
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: Text("Ahmed Tambal",
                        style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.login_rounded,size: _drawerIconSize,color: Theme.of(context).accentColor),
                    title: Text('Login Page', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()),);
                    },
                  ),
                  Divider(color: Theme.of(context).primaryColor, height: 1,),

                  Divider(color: Theme.of(context).primaryColor, height: 1,),


                  Divider(color: Theme.of(context).primaryColor, height: 1,),
                  ListTile(
                    leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                    title: Text('Logout',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                    onTap: () {
                      SystemNavigator.pop();
                    },
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }



  Future<dynamic> _showDiloag({
    required BuildContext context,
  }) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text("Add Task"),
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              controller: _taskTxtController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Write your task here",
                labelText: "Task Name",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Get.back();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: k_primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 40),
                  ),
                  child: Text("Add"),
                  onPressed: () async {
                    _homeController.createTask(textTask: _taskTxtController.text);
                    FocusScope.of(context).unfocus();
                    _taskTxtController.clear();
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      title: Text("To Do App"),
      actions: [],
    );
  }
}
