import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class AddCardView extends StatefulWidget {
  const AddCardView({super.key});

  @override
  State<AddCardView> createState() => _AddCardViewState();
}

class _AddCardViewState extends State<AddCardView> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  bool _saveCard = true;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appColors.secondaryBackgroundColor,
      appBar: AddCardAppBar(),
      body: Padding(
        padding: PaddingsConstants.instance.homePagePadding,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),

                // Card Preview Section
                CardPreviewSection(
                  cardNumber: _cardNumberController.text,
                  cardHolder: _cardHolderController.text,
                  expiry: _expiryController.text,
                ),

                SizedBox(height: 40),

                // Card Form Section
                CardFormSection(
                  cardNumberController: _cardNumberController,
                  cardHolderController: _cardHolderController,
                  expiryController: _expiryController,
                  cvvController: _cvvController,
                  onCardNumberChanged: () => setState(() {}),
                  onCardHolderChanged: () => setState(() {}),
                  onExpiryChanged: () => setState(() {}),
                ),

                SizedBox(height: 20),

                // Save Card Toggle
                SaveCardToggleSection(
                  saveCard: _saveCard,
                  onToggle: (value) {
                    setState(() {
                      _saveCard = value;
                    });
                  },
                ),

                SizedBox(height: 40),

                // Add Card Button
                AddCardButtonSection(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _showSuccessDialog();
                    }
                  },
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).appColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).appColors.shopPageBuyGreen,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: Theme.of(context).appColors.whiteColor,
                  size: 30,
                ),
              ),
              SizedBox(height: 16),
              BoldOnboardingText(
                title: "Card Added Successfully!",
                titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
                titleColor: Theme.of(context).appColors.boldBlack,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).appColors.shopPageBuyGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: NormalText(
                    text: "Done",
                    color: Theme.of(context).appColors.whiteColor,
                    fontSize: TextSizeEnum.loginButtonTextSize.value,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Custom AppBar for Add Card
class AddCardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddCardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).appColors.whiteColor,
      elevation: 0,
      centerTitle: true,
      leading: Padding(
        padding: PaddingsConstants.instance.homeAppbarLeadingPadding,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).appColors.boldBlack,
            size: IconSizeEnum.homeSortFilterIconSize.value,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: BoldOnboardingText(
        title: "Add New Card",
        titleSize: TextSizeEnum.ProfileCheckoutTitleSize.value,
        titleColor: Theme.of(context).appColors.boldBlack,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// Card Preview Section Widget
class CardPreviewSection extends StatelessWidget {
  final String cardNumber;
  final String cardHolder;
  final String expiry;

  const CardPreviewSection({
    super.key,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).appColors.shopPageBlue,
            Theme.of(context).appColors.shopPageBlue.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).appColors.boldBlack.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Type
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NormalText(
                text: "VISA",
                color: Theme.of(context).appColors.whiteColor,
                fontSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
              ),
              Icon(
                Icons.credit_card,
                color: Theme.of(context).appColors.whiteColor,
                size: 30,
              ),
            ],
          ),

          Spacer(),

          // Card Number
          NormalText(
            text: _formatCardNumber(cardNumber),
            color: Theme.of(context).appColors.whiteColor,
            fontSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
          ),

          SizedBox(height: 20),

          // Card Holder and Expiry
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NormalText(
                    text: "CARD HOLDER",
                    color: Theme.of(
                      context,
                    ).appColors.whiteColor.withOpacity(0.7),
                    fontSize: TextSizeEnum.homeCardsDetailSize.value,
                  ),
                  NormalText(
                    text: cardHolder.isEmpty
                        ? "FULL NAME"
                        : cardHolder.toUpperCase(),
                    color: Theme.of(context).appColors.whiteColor,
                    fontSize: TextSizeEnum.homeCardsTitleSize.value,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  NormalText(
                    text: "EXPIRES",
                    color: Theme.of(
                      context,
                    ).appColors.whiteColor.withOpacity(0.7),
                    fontSize: TextSizeEnum.homeCardsDetailSize.value,
                  ),
                  NormalText(
                    text: expiry.isEmpty ? "MM/YY" : expiry,
                    color: Theme.of(context).appColors.whiteColor,
                    fontSize: TextSizeEnum.homeCardsTitleSize.value,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatCardNumber(String number) {
    if (number.isEmpty) return "•••• •••• •••• ••••";

    String formatted = number.replaceAll(' ', '');
    String result = '';

    for (int i = 0; i < 16; i++) {
      if (i > 0 && i % 4 == 0) result += ' ';
      if (i < formatted.length) {
        result += formatted[i];
      } else {
        result += '•';
      }
    }

    return result;
  }
}

// Card Form Section Widget
class CardFormSection extends StatelessWidget {
  final TextEditingController cardNumberController;
  final TextEditingController cardHolderController;
  final TextEditingController expiryController;
  final TextEditingController cvvController;
  final VoidCallback onCardNumberChanged;
  final VoidCallback onCardHolderChanged;
  final VoidCallback onExpiryChanged;

  const CardFormSection({
    super.key,
    required this.cardNumberController,
    required this.cardHolderController,
    required this.expiryController,
    required this.cvvController,
    required this.onCardNumberChanged,
    required this.onCardHolderChanged,
    required this.onExpiryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card Number
        BoldOnboardingText(
          title: "Card Number",
          titleSize: TextSizeEnum.homeCardsTitleSize.value,
          titleColor: Theme.of(context).appColors.boldBlack,
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: cardNumberController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
            CardNumberInputFormatter(),
          ],
          onChanged: (value) => onCardNumberChanged(),
          decoration: InputDecoration(
            hintText: "1234 5678 9012 3456",
            hintStyle: TextStyle(
              color: Theme.of(context).appColors.starNumberGreyColor,
              fontSize: TextSizeEnum.homeCardsTitleSize.value,
            ),
            filled: true,
            fillColor: Theme.of(context).appColors.paymentBoxFillGrey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter card number";
            }
            if (value.replaceAll(' ', '').length < 16) {
              return "Please enter a valid card number";
            }
            return null;
          },
        ),

        SizedBox(height: 20),

        // Card Holder Name
        BoldOnboardingText(
          title: "Card Holder Name",
          titleSize: TextSizeEnum.homeCardsTitleSize.value,
          titleColor: Theme.of(context).appColors.boldBlack,
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: cardHolderController,
          textCapitalization: TextCapitalization.words,
          onChanged: (value) => onCardHolderChanged(),
          decoration: InputDecoration(
            hintText: "John Doe",
            hintStyle: TextStyle(
              color: Theme.of(context).appColors.starNumberGreyColor,
              fontSize: TextSizeEnum.homeCardsTitleSize.value,
            ),
            filled: true,
            fillColor: Theme.of(context).appColors.paymentBoxFillGrey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter card holder name";
            }
            return null;
          },
        ),

        SizedBox(height: 20),

        // Expiry and CVV Row
        Row(
          children: [
            // Expiry Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoldOnboardingText(
                    title: "Expiry Date",
                    titleSize: TextSizeEnum.homeCardsTitleSize.value,
                    titleColor: Theme.of(context).appColors.boldBlack,
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: expiryController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                      ExpiryDateInputFormatter(),
                    ],
                    onChanged: (value) => onExpiryChanged(),
                    decoration: InputDecoration(
                      hintText: "MM/YY",
                      hintStyle: TextStyle(
                        color: Theme.of(context).appColors.starNumberGreyColor,
                        fontSize: TextSizeEnum.homeCardsTitleSize.value,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).appColors.paymentBoxFillGrey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter expiry date";
                      }
                      if (value.length < 5) {
                        return "Invalid date";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),

            SizedBox(width: 16),

            // CVV
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoldOnboardingText(
                    title: "CVV",
                    titleSize: TextSizeEnum.homeCardsTitleSize.value,
                    titleColor: Theme.of(context).appColors.boldBlack,
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: cvvController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    decoration: InputDecoration(
                      hintText: "123",
                      hintStyle: TextStyle(
                        color: Theme.of(context).appColors.starNumberGreyColor,
                        fontSize: TextSizeEnum.homeCardsTitleSize.value,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).appColors.paymentBoxFillGrey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter CVV";
                      }
                      if (value.length < 3) {
                        return "Invalid CVV";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Save Card Toggle Section Widget
class SaveCardToggleSection extends StatelessWidget {
  final bool saveCard;
  final Function(bool) onToggle;

  const SaveCardToggleSection({
    super.key,
    required this.saveCard,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: saveCard,
          onChanged: onToggle,
          activeColor: Theme.of(context).appColors.shopPageBuyGreen,
        ),
        SizedBox(width: 12),
        BoldOnboardingText(
          title: "Save this card for future payments",
          titleSize: TextSizeEnum.homeCardsTitleSize.value,
          titleColor: Theme.of(context).appColors.boldBlack,
        ),
      ],
    );
  }
}

// Add Card Button Section Widget
class AddCardButtonSection extends StatelessWidget {
  final VoidCallback onPressed;

  const AddCardButtonSection({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: WidgetSizeEnum.loginButtonHeight.value,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).appColors.sizzlingRed,
          foregroundColor: Theme.of(context).appColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: BoldOnboardingText(
          title: "Add Card",
          titleSize: TextSizeEnum.loginButtonTextSize.value,
          titleColor: Theme.of(context).appColors.whiteColor,
        ),
      ),
    );
  }
}

// Card Number Input Formatter
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

// Expiry Date Input Formatter
class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll('/', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i == 2) buffer.write('/');
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
