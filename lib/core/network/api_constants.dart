class ApiConstants {
  ////base url
  static const String baseUrl = "http://shoping-online.runasp.net/api";
  /// auth and user endpoints >>>>>>>>>>>>>>>
  static const String singUpEndpoint = "/Account/Register";
  static const String loginEndpoint = "/Account/Login";
  static const String forgetPasswordEndpoint = "/Account/ForgetPassword";
  static const String verifyOtpEndpoint = "/Account/VerifyOTP";
  static const String resetPasswordEndpoint = "/Account/ResetPassword";

  /// home_repo endpoints >>>>>>>>>>>>>>>>>>>>
  static const String getCollectionsEndpoint = "/Collections";
  static const String getCategoriesEndpoint = "/Categories";

  static String getCollectionDetailsEndpoint({required String collectionId}) =>
      "/Collections/$collectionId";

  static String getProductDetailsEndpoint({required String productId}) =>
      "/Products/$productId";
  static const String addReviewEndpoint = "/Products/AddReview";
  static const String getProductsEndPoint = "/Home";
  static const String getOffersEndPoint = "/Home/offeredProducts";

  /// profile endpoints >>>>>>>>>>>>>>>>>>>>
  static const String getProfileEndpoint = "/Profile/get-user";
  static const String editProfileEndpoint = "/Profile";
  static const String changePasswordEndpoint = "/Profile/change-password";

  static String updateFcmTokenEndpoint({required String fcmToken}) =>
      "/Profile/$fcmToken";

  ///search endpoint >>>>>>>>>>>>>>>>>
  static const String searchEndpoint = "/Home/Search";

  ///// favorite endpoints >>>>>>>>>>>>>>>>>>>>
  static String addToFavoriteEndpoint({required String productId}) =>
      "/Favorite/$productId";
  static const String getFavoritesEndPoint = "/Favorite";

  //////////cart endpoints >>>>>>>>>>>>>>>>>>>>
  static const String cartEndPoint = "/Cart";
  static String incrementCartEndPoint({required String productId}) =>
      "/Cart/increment/$productId";

  static String decrementCartEndPoint({required String productId}) =>
      "/Cart/decrement/$productId";

  static String deleteFromCartEndPoint({required String productId}) =>
      "/Cart/$productId";
  static const String payWithPaymobEndpoint = "/Paymob/pay";
  static const String getPaymentStatusEndpoint = "/Paymob/GetPaymentStatus";
  static const String getOrdersEndpoint = "/Account/GetAllTrans";

  ///////////////////admin endpoints >>>>>>>>>>>>>>>>>>>>
  static const String allChatsEndPoint = "/Chat/GetAllChats";
  static const String sendMessageEndpoint = "/Chat/SendMassage";

  static String getChatHistoryEndPoint({required String receiverId}) =>
      "/Chat/history/$receiverId";
}
