import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app1/model/database_helper_model.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  StandardAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: [
        IconButton(
            icon: Icon(Icons.refresh, color: Colors.red),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Look at houses again'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(onPressed: (){Navigator.of(context).pop();}, child: Text("cancel")),
                            SizedBox(width: 20,),
                            ElevatedButton(onPressed: (){
                              Provider.of<DatabaseHelper>(context,listen:false).updateAll();
                              Navigator.of(context).pop();
                            }, child: Text("Restart")),
                          ],
                      )],
                    ),
                  )
              );
            }),
        IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black), onPressed: () {})
      ],
      title: Text(this.title,style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.black),
        onPressed: () {},
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
