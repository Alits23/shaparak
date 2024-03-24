abstract class CardEvent {}

class CardRequestDataEvent extends CardEvent {}

class CardPaymentInitEvent extends CardEvent {}

class CardPaymentRequestEvent extends CardEvent {}

class CardRemoveProductEvent extends CardEvent {
  int index;
  CardRemoveProductEvent(this.index);
}
