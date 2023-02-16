import 'app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  // if (action is UserLogoutAction) {
  return new AppState.initial();
  /*} else
    return new AppState(
        authState: authReducer(state.authState, action),
        loginState: loginReducer(state.loginState, action),
        signUpState: signUpReducer(state.signUpState, action),
        passwordState: passwordReducer(state.passwordState, action),
        venueState: venueReducer(state.venueState, action),
        accountState: accountReducer(state.accountState, action),
        menuState: menuReducer(state.menuState, action),
        productState: productReducer(state.productState, action),
        checkoutState: checkoutReducer(state.checkoutState, action),
        ordersState: ordersReducer(state.ordersState, action),
        deliveryState: deliveryReducer(state.deliveryState, action),
        validationState: validationReducer(state.validationState, action),
        activationState: activationReducer(state.activationState, action));*/
}
