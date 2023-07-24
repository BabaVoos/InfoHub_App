abstract class AddressesStates {}

class AddressesInitialStates extends AddressesStates {}

class AddAddressesSuccessState extends AddressesStates {}

class AddAddressesErrorState extends AddressesStates {
  final String error;
  AddAddressesErrorState(this.error);
}

class DeleteAddressesSuccessState extends AddressesStates {}

class DeleteAddressesErrorState extends AddressesStates {
  final String error;
  DeleteAddressesErrorState(this.error);
}

class UpdateAddressSuccessState extends AddressesStates {}

class UpdateAddressErrorState extends AddressesStates {
  final String error;
  UpdateAddressErrorState(this.error);
}