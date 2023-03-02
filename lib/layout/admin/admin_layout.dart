import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLayout extends StatelessWidget {
  const AdminLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<InfoHubCubit, InfoHubState>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: adminColor,
            leading: Icon(Icons.admin_panel_settings),
            title: Text(InfoHubCubit.get(context).titles[InfoHubCubit.get(context).currentIndex]),
            centerTitle: true,
          ),
          body: Center(child: InfoHubCubit.get(context).screens[InfoHubCubit.get(context).currentIndex]),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: adminColor,
            type: BottomNavigationBarType.fixed,
            currentIndex: InfoHubCubit.get(context).currentIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.white,
            iconSize: size.width * .08,
            onTap: (index)
            {
              InfoHubCubit.get(context).changeIndex(index);
            },
            items:
            const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.newspaper_outlined,
                  ),
                ),
                label: 'news',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.question_answer,
                  ),
                ),
                label: 'questions',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.work,
                  ),
                ),
                label: 'jobs',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.grid_view_sharp,
                  ),
                ),
                label: 'control',
              ),
            ],
          ),
        );
      },
    );
  }
}
