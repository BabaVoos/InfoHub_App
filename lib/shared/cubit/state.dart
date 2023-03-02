abstract class InfoHubState {}

class InfoHubInitialState extends InfoHubState {}

class ChangeNavBarState extends InfoHubState {}

class AddNewsSuccessState extends InfoHubState{}

class AddNewsErrorState extends InfoHubState {
  final String error;
  AddNewsErrorState(this.error);
}

class GetNewsSuccessState extends InfoHubState{}

class GetNewsErrorState extends InfoHubState {
  final String error;
  GetNewsErrorState(this.error);
}

class DeleteNewsSuccessState extends InfoHubState {}

class DeleteNewsErrorState extends InfoHubState {
  final String error;
  DeleteNewsErrorState(this.error);
}



// Question States
class AddQuestionsSuccessState extends InfoHubState{}

class AddQuestionsErrorState extends InfoHubState {
  final String error;
  AddQuestionsErrorState(this.error);
}

class GetQuestionsSuccessState extends InfoHubState{}

class GetQuestionsErrorState extends InfoHubState {
  final String error;
  GetQuestionsErrorState(this.error);
}

class DeleteQuestionsSuccessState extends InfoHubState {}

class DeleteQuestionsErrorState extends InfoHubState {
  final String error;
  DeleteQuestionsErrorState(this.error);
}


// Jobs States
class AddJobsSuccessState extends InfoHubState{}

class AddJobsErrorState extends InfoHubState {
  final String error;
  AddJobsErrorState(this.error);
}

class GetJobsSuccessState extends InfoHubState{}

class GetJobsErrorState extends InfoHubState {
  final String error;
  GetJobsErrorState(this.error);
}

// Addresses States

class AddAddressesSuccessState extends InfoHubState {}

class AddAddressesErrorState extends InfoHubState {
  final String error;
  AddAddressesErrorState(this.error);
}

class DeleteJobsSuccessState extends InfoHubState {}

class DeleteJobsErrorState extends InfoHubState {
  final String error;
  DeleteJobsErrorState(this.error);
}

class AppCreateDatabaseState extends InfoHubState {}