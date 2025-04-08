import 'package:credit_app/core/class/statusrequest.dart';
import 'package:flutter/material.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandlingDataView({
    Key? key,
    required this.statusRequest,
    required this.widget
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (statusRequest == StatusRequest.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    else if (statusRequest == StatusRequest.offlinefailure) {
      return const Center(child: Text("No Internet Connection"));
    }
    else if (statusRequest == StatusRequest.serverfailure) {
      return const Center(child: Text("Server Error"));
    }
    else if (statusRequest == StatusRequest.fail) {
      return const Center(child: Text("No Data Available"));
    }
    else {
      return widget;
    }
  }
}