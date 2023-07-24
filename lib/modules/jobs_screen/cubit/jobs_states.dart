abstract class JobsStates {}

class JobsInitialState extends JobsStates {}

class AddJobsSuccessState extends JobsStates {}

class AddJobsErrorState extends JobsStates {
  final String error;

  AddJobsErrorState(this.error);
}

class GetJobsSuccessState extends JobsStates {}

class GetJobsErrorState extends JobsStates {
  final String error;

  GetJobsErrorState(this.error);
}

class DeleteJobSuccessState extends JobsStates {}

class DeleteJobErrorState extends JobsStates {
  final String error;

  DeleteJobErrorState(
    this.error,
  );
}

class UpdateJobSuccessState extends JobsStates {}

class UpdateJobErrorState extends JobsStates {
  final String error;

  UpdateJobErrorState(
      this.error,
      );
}