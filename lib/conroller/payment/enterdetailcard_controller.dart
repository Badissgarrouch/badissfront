import 'package:credit_app/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/data/datasource/remote/payment/enterdetailcard.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import '../../core/class/crud.dart';

class CardField {
  TextEditingController numberController;
  FocusNode focusNode;
  String selectedCardName;
  String? cardId;
  bool isEditing;

  CardField({
    required this.numberController,
    required this.focusNode,
    required this.selectedCardName,
    this.cardId,
    this.isEditing = false,
  });
}

abstract class EnterDetailCardController extends GetxController {
  void addCardField();
  void removeCardField(int index);
  void requestFocus(int index);
  Future<void> submitCards();
  Future<void> loadUserCards();
}

class EnterDetailCardControllerImp extends EnterDetailCardController {
  List<String> cardNames = [
    'Visa', 'MasterCard', 'Visa Electron', 'Maestro', 'American Express',
    'UnionPay', 'Diners Club', 'Discover', 'JCB', 'Revolut', 'N26', 'Wise',
    'Carte e-Dinar', 'Carte Technologique', 'Girocard', 'Bancontact',
    'Payoneer', 'Skrill', 'Neteller'
  ];

  late RxList<CardField> cardFields;
  final PaymentCardService paymentService = PaymentCardService();
  StatusRequest statusRequest = StatusRequest.none;
  late final String token;
  final box = GetStorage();
  List<dynamic> existingCards = [];

  @override
  void onInit() {
    super.onInit();
    token = box.read('token') ?? '';
    cardFields = <CardField>[
      CardField(
        numberController: TextEditingController(),
        focusNode: FocusNode(),
        selectedCardName: cardNames[0],
      )
    ].obs;
    loadUserCards();
  }

  @override
  void onClose() {
    for (var field in cardFields) {
      field.numberController.dispose();
      field.focusNode.dispose();
    }
    super.onClose();
  }

  @override
  Future<void> loadUserCards() async {
    if (token.isEmpty) {
      Get.snackbar('Erreur', 'Token non trouvé', backgroundColor: Colors.red);
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    final response = await paymentService.getUserCards(token: token);

    response.fold(
          (failure) {
        statusRequest = StatusRequest.failure;
        Get.snackbar('Erreur', 'Échec du chargement des cartes', backgroundColor: Colors.red);
      },
          (response) {
        if (response['success'] == true) {
          existingCards = response['cards'] ?? [];
          cardFields.clear();

          if (existingCards.isEmpty) {
            cardFields.add(
              CardField(
                numberController: TextEditingController(),
                focusNode: FocusNode(),
                selectedCardName: cardNames[0],
                isEditing: false,
              ),
            );
          } else {
            for (var card in existingCards) {
              cardFields.add(
                CardField(
                  numberController: TextEditingController(text: card['cardNumber']),
                  focusNode: FocusNode(),
                  selectedCardName: card['cardType'] ?? cardNames[0],
                  cardId: card['cardId']?.toString(),
                  isEditing: false,
                ),
              );
            }
          }
          statusRequest = StatusRequest.success;
        } else {
          statusRequest = StatusRequest.failure;
          Get.snackbar('Erreur', response['message'] ?? 'Réponse invalide du serveur', backgroundColor: Colors.red);
        }
      },
    );
    update();
  }

  @override
  Future<void> submitCards() async {
    if (token.isEmpty) {
      Get.snackbar('Erreur', 'Token non trouvé', backgroundColor: Colors.red);
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    try {
      final List<Map<String, dynamic>> cardsToAdd = [];
      final List<Map<String, dynamic>> cardsToUpdate = [];
      final List<Map<String, dynamic>> cardsToDelete = [];

      for (var field in cardFields) {
        final cleanNumber = field.numberController.text.replaceAll(RegExp(r'[^0-9]'), '');
        if (cleanNumber.isEmpty && field.cardId == null) continue;

        final cardData = {
          'cardType': field.selectedCardName,
          'cardNumber': cleanNumber,
          if (field.cardId != null) 'cardId': field.cardId,
        };

        if (field.cardId == null && cleanNumber.isNotEmpty) {
          cardsToAdd.add(cardData);
        } else if (field.cardId != null && field.isEditing && cleanNumber.isNotEmpty) {
          cardsToUpdate.add(cardData);
        }
      }

      for (var existingCard in existingCards) {
        if (!cardFields.any((field) => field.cardId == existingCard['cardId']?.toString())) {
          cardsToDelete.add({
            'cardId': existingCard['cardId']?.toString(),
            'cardType': existingCard['cardType'],
            'cardNumber': existingCard['cardNumber'],
          });
        }
      }

      bool allSuccess = true;
      String? errorMessage;

      if (cardsToDelete.isNotEmpty) {
        final response = await paymentService.postData(
          cards: cardsToDelete,
          action: 'delete',
          token: token,
        );
        response.fold(
              (failure) {
            allSuccess = false;
            errorMessage = 'Échec de la suppression des cartes';
          },
              (r) {
            if (!r['success']) {
              allSuccess = false;
              errorMessage = r['message'] ?? 'Échec de la suppression';
            }
          },
        );
      }

      if (cardsToAdd.isNotEmpty && allSuccess) {
        final response = await paymentService.postData(
          cards: cardsToAdd,
          action: 'add',
          token: token,
        );
        response.fold(
              (failure) {
            allSuccess = false;
            errorMessage = 'Échec de l\'ajout des cartes';
          },
              (r) {
            if (!r['success']) {
              allSuccess = false;
              errorMessage = r['message'] ?? 'Échec de l\'ajout';
            }
          },
        );
      }

      if (cardsToUpdate.isNotEmpty && allSuccess) {
        final response = await paymentService.postData(
          cards: cardsToUpdate,
          action: 'update',
          token: token,
        );
        response.fold(
              (failure) {
            allSuccess = false;
            errorMessage = 'Échec de la mise à jour des cartes';
          },
              (r) {
            if (!r['success']) {
              allSuccess = false;
              errorMessage = r['message'] ?? 'Échec de la mise à jour';
            }
          },
        );
      }

      if (allSuccess) {
        Get.snackbar('SUCCESS', 'Opération réussi', backgroundColor: AppColors.blue300);
        await loadUserCards();
      } else {
        Get.snackbar('Erreur', errorMessage ?? 'Erreur inconnue', backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Exception : $e', backgroundColor: Colors.red);
    } finally {
      for (var field in cardFields) {
        field.isEditing = false;
      }
      statusRequest = StatusRequest.none;
      update();
    }
  }

  @override
  void addCardField() {
    cardFields.add(
      CardField(
        numberController: TextEditingController(),
        focusNode: FocusNode(),
        selectedCardName: cardNames[0],
      ),
    );
    update();
  }

  @override
  void removeCardField(int index) {
    if (cardFields.length <= 1 && cardFields[index].cardId == null && cardFields[index].numberController.text.isEmpty) {
      Get.snackbar('Info', 'Impossible de supprimer le dernier champ vide', backgroundColor: Colors.grey);
      return;
    }

    cardFields[index].numberController.dispose();
    cardFields[index].focusNode.dispose();
    cardFields.removeAt(index);
    update();
  }

  @override
  void requestFocus(int index) {
    cardFields[index].focusNode.requestFocus();
    update();
  }
}