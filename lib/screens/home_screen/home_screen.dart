import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_messaging_system/common/models/department_model.dart';
import 'package:libary_messaging_system/screens/authentication/bloc/auth_event.dart';
import 'package:libary_messaging_system/screens/authentication/bloc/auth_state.dart';
import 'package:libary_messaging_system/screens/home_screen/bloc/home_screen_bloc.dart';
import 'package:libary_messaging_system/screens/home_screen/bloc/home_screen_event.dart';
import 'package:libary_messaging_system/screens/home_screen/bloc/home_screen_state.dart';
import '../../router.gr.dart';
import '../authentication/bloc/auth_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeScreenBloc>(context).add(GetAllDepartmentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Departments'),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              authBloc.add(LogOutRequestEvent());
            },
            child: Text(
              'LOG OUT',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushRoute(AddBroadcastScreen()),
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) => _processAuthListener(state),
          child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
            builder: (context, state) {
              switch (state.status) {
                case HomeScreenStatus.loaded:
                  if (state.departments!.isEmpty) {
                    return Center(child: Text('NO DEPARTMENT AT THE MOMENT'));
                  }

                  return ListView.builder(
                    itemCount: state.departments!.length,
                    itemBuilder: (context, index) {
                      DepartmentModel departmentModel =
                          state.departments![index];
                      return homeScreenCard(departmentModel);
                    },
                  );

                default:
                  return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  _processAuthListener(AuthState state) {
    if (state.status == AuthStatus.unauthenticated) {
      context.router.replaceAll([LoginScreen()]);
    }
  }

  String getDepartmentName(String departmentName) {
    return departmentName.split('@')[0];
  }

  Widget homeScreenCard(DepartmentModel departmentModel) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${departmentModel.departmentEmail!.split('@')[0].toUpperCase()} Department',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.pushRoute(
                      ChatScreen(
                        otherDepartmentId: departmentModel.departmentId!,
                        otherDepartmentName: getDepartmentName(
                          departmentModel.departmentEmail!,
                        ),
                      ),
                    );
                  },
                  child: Text('CHAT'),
                ),
                ElevatedButton(
                    onPressed: () {
                      context.pushRoute(GeneralBroadcastScreen(
                          departmentId: departmentModel.departmentId!));
                    },
                    child: Text('GENERAL BROADCAST')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
