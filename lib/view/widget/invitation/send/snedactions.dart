import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendActions extends StatelessWidget {
  final VoidCallback onSend;
  final VoidCallback onCancel;
  final bool hasSentInvitation;
  final bool isLoading;

  const SendActions({
    super.key,
    required this.onSend,
    required this.onCancel,
    required this.hasSentInvitation,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isLoading)
          const CircularProgressIndicator()
        else
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: hasSentInvitation
                    ? [Color(0xFFEF9A9A), Color(0xFFFFEBEE)]
                    : [Color(0xFF90CAF9), Color(0xFFE3F2FD)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: hasSentInvitation ? onCancel : onSend,
                borderRadius: BorderRadius.circular(10),
                splashColor: Colors.grey.withOpacity(0.2),
                highlightColor: Colors.white.withOpacity(0.1),
                child: Container(
                  width: double.infinity,
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        hasSentInvitation ? Icons.delete : Icons.send,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        hasSentInvitation
                            ? "Delete invitation".tr
                            : "Send invitation".tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}