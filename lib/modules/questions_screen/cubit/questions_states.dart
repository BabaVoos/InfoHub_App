abstract class QuestionStates {}

class QuestionInitialState extends QuestionStates {}

class AddQuestionsSuccessState extends QuestionStates{}

class AddQuestionsErrorState extends QuestionStates {
  final String error;
  AddQuestionsErrorState(this.error);
}

class DeleteQuestionsSuccessState extends QuestionStates {}

class DeleteQuestionsErrorState extends QuestionStates {
  final String error;
  DeleteQuestionsErrorState(this.error);
}

class UpdateQuestionSuccessState extends QuestionStates {}

class UpdateQuestionErrorState extends QuestionStates {
  final String error;
  UpdateQuestionErrorState(this.error);
}