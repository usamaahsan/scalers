import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalers_job_portal/data/models/JobDetails.dart';
import 'package:scalers_job_portal/usecases/jobs_usecase.dart';

class JobDetailsPageCubitState{}
class JobDetailsPageCubitInitial extends JobDetailsPageCubitState{}
class JobDetailsPageCubitLoading extends JobDetailsPageCubitState{}
class JobDetailsPageCubitLoaded extends JobDetailsPageCubitState{
  JobDetails details;
  JobDetailsPageCubitLoaded(this.details);
}
class JobDetailsPageCubitError extends JobDetailsPageCubitState{
  String message;
  JobDetailsPageCubitError(this.message);
}


class JobDetailsPageCubit extends Cubit<JobDetailsPageCubitState>{

  JobDetailsPageCubit():super(JobDetailsPageCubitInitial());


  Future getDetails(String uuid) async {
    
    emit(JobDetailsPageCubitLoading());
    
    final response = await JobsUseCase().getJobDetails(uuid);
    response.when(
      success: (data){
        emit(JobDetailsPageCubitLoaded(data));
      }, 
      error: (error){
        emit(JobDetailsPageCubitError(error));
      }
    );
  }
}