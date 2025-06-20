import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentButton extends StatelessWidget {
  final bool isProcessing;
  final String paymentMethod;
  final VoidCallback onPressed;

  const PaymentButton({
    super.key,
    required this.isProcessing,
    required this.paymentMethod,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: isProcessing ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: _getButtonColor(),
                disabledBackgroundColor: Colors.grey[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 2,
              ),
              child: isProcessing
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Processing in progress...'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_getButtonIcon(), size: 16, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    _getButtonText(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'By continuing, you agree to our terms of use.'.tr,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Color _getButtonColor() {
    return paymentMethod == 'paypal' ? Colors.blue[700]! : Colors.blue[600]!;
  }

  IconData _getButtonIcon() {
    return paymentMethod == 'paypal' ? Icons.account_balance_wallet : Icons.lock;
  }

  String _getButtonText() {
    return paymentMethod == 'paypal' ? 'Se connecter à PayPal' : 'Payer 35,99 €';
  }
}