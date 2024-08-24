import 'package:flutter/material.dart';
import 'TennisDataModel.dart';

class TennisDetail extends StatelessWidget {
  final TennisDataModel tennisDataModel;
  const TennisDetail({Key? key, required this.tennisDataModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tennisDataModel.name),
      ),
      body: Column(
        children: [
          Image.network(tennisDataModel.imageUrl),
          Text("El Tenista ${tennisDataModel.desc} ")
        ],
      ),
    );
  }
}
