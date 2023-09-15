import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_messaging_system/common/repository/user_repository.dart';
import 'package:libary_messaging_system/common/widgets/custom_text_field.dart';
import 'package:libary_messaging_system/screens/add_broadcast/bloc/add_broadcast_bloc.dart';
import 'package:libary_messaging_system/screens/add_broadcast/bloc/add_broadcast_event.dart';
import 'package:libary_messaging_system/screens/add_broadcast/bloc/add_broadcast_state.dart';

import '../../locator.dart';

class AddBroadcastScreen extends StatefulWidget {
  AddBroadcastScreen({Key? key}) : super(key: key);

  @override
  State<AddBroadcastScreen> createState() => _AddBroadcastScreenState();
}

class _AddBroadcastScreenState extends State<AddBroadcastScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController broadcastMsgCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddBroadcastBloc, AddBroadCastState>(
      listener: (context, state) => _processBlocListener(state),
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    maxLines: 5,
                    controller: broadcastMsgCtrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a broadcast message';
                      } else {
                        return null;
                      }
                    },
                    hintText: 'Add Broadcast message',
                  ),
                ),
                SizedBox(height: 20),
                BlocBuilder<AddBroadcastBloc, AddBroadCastState>(
                  builder: (context, state) => _processBlocBuilder(state),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _processBlocBuilder(AddBroadCastState state) {
    switch (state.status) {
      case AddBroadcastStatus.loading:
        return CircularProgressIndicator();
      default:
        return ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<AddBroadcastBloc>().add(
                    AddBroadcastEvent(
                      broadcastMessage: broadcastMsgCtrl.text,
                      userId: getIt<UserRepository>().userModel!.userId!,
                    ),
                  );
            }
          },
          child: Text('SEND BROADCAST MESSAGE'),
        );
    }
  }

  _processBlocListener(AddBroadCastState state) {
    switch (state.status) {
      case AddBroadcastStatus.done:
        context.popRoute();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Broadcast message sent successfully')));
        break;
      default:
        return Text('Loaded');
    }
  }
}
