class RequestApi {
  static const String login = 'auth/login/?business_support=true';
  static const String register = 'auth/register/';
  static const String userData = 'user/';
  static const String forgetPassword = 'auth/reset-password/';
  static const String country = 'countries/';
  static const String terms = 'pages/transportation-terms/';
  static const String phonePrefix = 'phone-prefixes/';
  static const String giftCard = 'payment/gift-card/';
  static const String increaseBalance = 'payment/mobile-paytr/';
  static const String tariffCountry = 'get-countries/?no_page';
  static const String profile = 'user/settings/';
  static const String settings = 'settings/';
  static const String warehouse = 'warehouse/';
  static const String register_warehouses = 'warehouses/';
  static const String updatePassword = 'update-password/';
  static String tariff(String country) => 'tariffs/$country/';
  static String region = 'regions/';
  static String courierTariff = 'courier-tariffs/';
  static String tickets = 'tickets/';
  static String ticketStatus = 'tickets/statuses/';
  static String ticketCategory = 'tickets/categories/';
  static String addTicket = 'tickets/first/';
  static String orderStatus = 'orders-menu/';
  static String orders = 'orders/';
  static String orderPay = 'payment/orders/';
  static String logout = 'auth/logout/';
  static String deleteOrder(int id) => 'order/$id/delete/';
  static String transactions = 'payment/transactions/';
  static String notifications = 'notifications/';
  static String unreadNotificationsCount = 'get-notifications/';
  static String readNotification = 'read-notification/';
  static String courierStatus = 'courier-menu/';
  static String courier = 'courier/';
  static String courierPay = 'payment/couriers/';

  static String singleCourier(int id) =>
      'courier/$id/?meta_niceSerializer&meta_niceDiscounts';

  static String deleteCourier(int id) => 'courier/$id/delete/';
  static String courierDeclaration = 'courier-declarations/?meta_niceDiscounts';

  static String declarationStatus = 'declarations-menu/';
  static String declarations =
      'declarations/?meta_niceSerializer&meta_niceDiscounts';
  static String declarationPay = 'payment/declarations/';
  static String deleteDeclaration(int id) => 'declaration/$id/delete/';
  static String editDeclaration(int id) => 'declarations/$id/';
  static String declarationDetail(int id) =>
      'declarations/$id/?meta_niceSerializer&meta_niceDiscounts';
  static String pageUrl(String url) {
    return 'pages/$url/';
  }

  static String createDeclaration = 'declarations/';

  static String courierDone = 'couriers/done/';
  static String marginTariff = 'margin-tariff/';
  static String orderDone = 'orders/done/';
  static String signature = 'user/signature/';
  static String productType = 'product-types/';
  static String declarationDone(String country) {
    return 'declarations/done-$country/';
  }

  static String fcmDeviceRegister = 'fcm-device/register/';
  static String fcmDeviceUnregister = 'fcm-device/remove/';

  static String trustedPerson = 'user/trusted/';

  static String deleteTrustedPerson(int id) {
    return 'user/trusted/$id/';
  }

  static String returnedDeclaration = 'returndeclarations/';
  static String returnedDeclarationStatus = 'return-declarations-menu/';
}
