abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class AddNewsSuccessState extends NewsStates{}

class AddNewsErrorState extends NewsStates {
  final String error;
  AddNewsErrorState(this.error);
}

class GetNewsSuccessState extends NewsStates{}

class GetNewsErrorState extends NewsStates {
  final String error;
  GetNewsErrorState(this.error);
}

class DeleteNewsSuccessState extends NewsStates {}

class DeleteNewsErrorState extends NewsStates {
  final String error;
  DeleteNewsErrorState(this.error);
}


class UpdateNewsSuccessState extends NewsStates {}

class UpdateNewsErrorState extends NewsStates {
  final String error;
  UpdateNewsErrorState(this.error);
}