import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_messaging_system/screens/general_broadcast/broadcast_model.dart';

import 'bloc/general_broadcast_bloc.dart';

class GeneralBroadcastScreen extends StatefulWidget {
  final String departmentId;
  const GeneralBroadcastScreen({Key? key, required this.departmentId})
      : super(key: key);

  @override
  State<GeneralBroadcastScreen> createState() => _GeneralBroadcastScreenState();
}

class _GeneralBroadcastScreenState extends State<GeneralBroadcastScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GeneralBroadcastBloc>(context)
        .add(GetBroadcastEvent(departmentId: widget.departmentId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('General Broadcast'),
      ),
      body: BlocBuilder<GeneralBroadcastBloc, GeneralBroadcastState>(
        builder: (context, state) {
          switch (state.status) {
            case GeneralBroadcastStatus.loading:
              return Center(
                child: CircularProgressIndicator(),
              );
            case GeneralBroadcastStatus.error:
              return Center(
                child: Text(state.error!),
              );
            case GeneralBroadcastStatus.unknown:
              return Center(
                child: Text('UNKNOWN'),
              );
            case GeneralBroadcastStatus.loaded:
              if (state.generalBroadcastModelList!.isEmpty) {
                return Center(
                  child: Text('There is no broadcast at the moment'),
                );
              } else {
                return ListView.builder(
                    itemCount: state.generalBroadcastModelList!.length,
                    itemBuilder: (context, index) {
                      GeneralBroadcastModel generalBroadcast = state
                          .generalBroadcastModelList!.reversed
                          .toList()[index];
                      return generalBroadcastCard(generalBroadcast);
                    });
              }
          }
        },
      ),
    );
  }

  Widget generalBroadcastCard(GeneralBroadcastModel generalBroadcast) {
    return Card(
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              generalBroadcast.message!,
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              DateFormat.yMMMMd().format(generalBroadcast.dateTime!),
              textAlign: TextAlign.end,
            )
          ],
        ),
      ),
    );
  }
}
