import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/settings/global_values.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('TAP AGOS-DIC 2024',
          style: TextStyle(fontFamily: 'poke'),
          ),
      ),
      drawer: myDrawer(context),
    );
  }

  Widget myDrawer(context){
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/perfil.png'),
            ),
            accountName: Text('Serch CV'), 
            accountEmail: Text('22031446@itcelaya.edu.mx')
            ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/chal');
            } ,
            title: const Text('Practica 1'),
            subtitle: const Text('Challenge'),
            leading: const Icon(Icons.code),
            trailing: const Icon(Icons.chevron_right),
            onLongPress: () {
              
            },
          ),
          ListTile(
            onTap: ()=>Navigator.pushNamed(context,'/movie'),
            title: const Text('Popular Movies'),
            subtitle: const Text('Test API'),
            leading: const Icon(Icons.movie),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            title: const Text('Salir'),
            leading: const Icon(Icons.exit_to_app),
            trailing: const Icon(Icons.chevron_right),
          ),
          
          DayNightSwitcher(
            isDarkModeEnabled: GlobalValues.bandThemeDark.value, 
            onStateChanged: (isDarkModeEnabled){
              GlobalValues.bandThemeDark.value = isDarkModeEnabled;
            })
        ]
      ),
    );
  }
}