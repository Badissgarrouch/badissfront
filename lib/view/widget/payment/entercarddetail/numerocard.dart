import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../conroller/payment/enterdetailcard_controller.dart';
import '../../../../core/function/numerocard.dart';

class Numerocard extends StatelessWidget {
  final CardField field;
  final EnterDetailCardControllerImp controller;
  final int index;

  const Numerocard({
    super.key,
    required this.field,
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: field.numberController,
      focusNode: field.focusNode,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(19),
        CardNumberFormatter(),
      ],
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        labelText: "Card number".tr,
        labelStyle: TextStyle(
          color: Colors.grey[700],
          fontSize: 16,
        ),
        hintText: "xxxx xxxx xxxx xxxx".tr,
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        suffixIcon: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'edit',
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('Modify'.tr),
              ),
            ),
            PopupMenuItem(
              value: 'add',
              child: ListTile(
                leading: Icon(Icons.add),
                title: Text('Add a field'.tr),
              ),
            ),
            if (controller.cardFields.length > 1 || field.cardId != null)
              PopupMenuItem(
                value: 'delete',
                child: ListTile(
                  leading: Icon(Icons.delete, color: Colors.red),
                  title: Text('Delete'.tr, style: TextStyle(color: Colors.red)),
                ),
              ),
            if (field.numberController.text.isNotEmpty)
              PopupMenuItem(
                value: 'clear',
                child: ListTile(
                  leading: Icon(Icons.clear),
                  title: Text('Erase'.tr),
                ),
              ),
          ],
          onSelected: (value) {
            if (value == 'edit') {
              controller.cardFields[index].isEditing = true;
              controller.requestFocus(index);
              controller.update();
            } else if (value == 'add') {
              controller.addCardField();
            } else if (value == 'delete') {
              controller.removeCardField(index);
            } else if (value == 'clear') {
              field.numberController.clear();
              field.isEditing = false;
              controller.update();
            }
          },
        ),
      ),
    );
  }
}