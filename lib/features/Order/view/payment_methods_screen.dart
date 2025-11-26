import 'package:flutter/material.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/features/Order/data/model/payment_method_model.dart';
import 'package:x_express/features/Order/data/repository/order_repository.dart';

class PaymentMethodsScreen extends StatefulWidget {
  final String orderId;

  const PaymentMethodsScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final OrderRepository _repository = OrderRepository();
  List<PaymentMethod> _paymentMethods = [];
  bool _isLoading = true;
  String? _error;
  String? _selectedPaymentMethodId;
  bool _isApproving = false;

  @override
  void initState() {
    super.initState();
    _loadPaymentMethods();
  }

  Future<void> _loadPaymentMethods() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final methods = await _repository.getPaymentMethods();
      setState(() {
        _paymentMethods = methods;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _approveOrder() async {
    if (_selectedPaymentMethodId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a payment method'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isApproving = true;
    });

    try {
      await _repository.approveOrder(
        orderId: widget.orderId,
        paymentMethodId: _selectedPaymentMethodId!,
      );

      setState(() {
        _isApproving = false;
      });

      // Return success to previous screen
      Navigator.pop(context, true);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order approved successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      setState(() {
        _isApproving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to approve order: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Select Payment Method',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 64, color: Colors.red),
                      SizedBox(height: 16),
                      Text('Error loading payment methods'),
                      SizedBox(height: 8),
                      Text(_error!, textAlign: TextAlign.center),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadPaymentMethods,
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: _paymentMethods.length,
                        itemBuilder: (context, index) {
                          final method = _paymentMethods[index];
                          final isSelected = _selectedPaymentMethodId == method.id;

                          return Container(
                            margin: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? kLightPrimary
                                    : Colors.grey[300]!,
                                width: isSelected ? 2 : 1,
                              ),
                              boxShadow: [
                                if (isSelected)
                                  BoxShadow(
                                    color: kLightPrimary.withOpacity(0.1),
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    offset: Offset(0, 2),
                                  ),
                              ],
                            ),
                            child: RadioListTile<String>(
                              value: method.id,
                              groupValue: _selectedPaymentMethodId,
                              onChanged: (value) {
                                setState(() {
                                  _selectedPaymentMethodId = value;
                                });
                              },
                              title: Text(
                                method.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? kLightPrimary
                                      : Colors.black87,
                                ),
                              ),
                              subtitle: method.description != null
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        method.description!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    )
                                  : null,
                              activeColor: kLightPrimary,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Approve Button
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isApproving ? null : _approveOrder,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kLightPrimary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: _isApproving
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : Text(
                                  'Approve Order',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}


