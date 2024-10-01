import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalers_job_portal/data/models/Jobs.dart';
import 'package:scalers_job_portal/usecases/jobs_usecase.dart';

class JobsPageCubitState{}
class JobsPageCubitInitial extends JobsPageCubitState{}
class JobsPageCubitLoading extends JobsPageCubitState{}
class JobsPageCubitLoaded extends JobsPageCubitState{
  Jobs jobsData;
  JobsPageCubitLoaded(this.jobsData);
}
class JobsPageCubitError extends JobsPageCubitState{
  String errorMessage;
  JobsPageCubitError(this.errorMessage);
}

class JobsPageCubit extends Cubit<JobsPageCubitState>{

  JobsPageCubit(this.useCase):super(JobsPageCubitInitial()){
    getJobs();
  }
  JobsUseCase useCase;


  Future<void> getJobs() async {

    emit(JobsPageCubitLoading());
    final response = await useCase.getJobsList();
    response.when(
      success: (data){
        emit(JobsPageCubitLoaded(data));
      }, 
      error: (error){
        emit(JobsPageCubitError(error));
      }
    );

  }
}
