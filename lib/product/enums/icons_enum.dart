import 'package:flutter/material.dart';

enum IconsEnum {
  iconMenu(Icons.menu_outlined),
  iconUpward(Icons.arrow_upward_rounded),
  iconDownward(Icons.arrow_downward_rounded),
  iconFilter(Icons.filter_list_rounded),
  iconForward(Icons.arrow_forward_ios_outlined),
  iconTimer(Icons.timer),
  iconCalendar(Icons.calendar_month),
  iconStar(Icons.star),
  iconVoice(Icons.keyboard_voice_outlined),
  iconSearch(Icons.search),
  iconHome(Icons.home_outlined),
  iconSettings(Icons.settings_outlined),
  iconFavorite(Icons.favorite_border),
  iconShoppingBasket(Icons.shopping_basket_outlined),
  iconBack(Icons.arrow_back_ios),
  iconEdit(Icons.edit),
  iconLocation(Icons.location_on),
  iconCoupon(Icons.local_offer_outlined),
  iconArrowDown(Icons.keyboard_arrow_down),
  iconCreditCard(Icons.credit_card),
  iconCheck(Icons.check);

  const IconsEnum(this.icon);
  final IconData icon;
  String get iconName => icon.toString();
}
