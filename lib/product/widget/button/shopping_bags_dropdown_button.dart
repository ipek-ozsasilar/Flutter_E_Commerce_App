  
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class ShoppinBagsDropDownButton extends StatefulWidget {
  const ShoppinBagsDropDownButton({Key? key}) : super(key: key);

  @override
  State<ShoppinBagsDropDownButton> createState() => _ShoppinBagsDropDownButtonState();
}

class _ShoppinBagsDropDownButtonState extends State<ShoppinBagsDropDownButton> {
   // Seçilebilir bedenler
  final List<String> sizes = ["38", "40", "42", "44", "46"];

  String? selectedSize = "42"; 
 // default seçili beden
  @override
  //dropdown menuye donusturulebılır
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isDense: true, // 👈 yükseklik küçülür
      value: selectedSize,
      underline: SizedBox(), // alt çizgiyi kaldırır
      items: sizes.map((size) {
        return DropdownMenuItem(
          value: size,
          child: NormalText(
            text: size,
            color: Theme.of(context).appColors.boldBlack,
            fontSize: TextSizeEnum.homeCardsDetailSize.value,
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedSize = value;
        });
      },
    );
  }
}