import 'package:scalers_job_portal/utils/APIresult.dart';
import 'package:scalers_job_portal/data/models/JobDetails.dart';
import 'package:scalers_job_portal/data/models/Jobs.dart';
import 'package:scalers_job_portal/data/services/jobs_services.dart';

class JobsUseCase{

  Future<APIresult<Jobs>> getJobsList() async {
    return await JobsServices().getJobsList();    
  }


  Future<APIresult<JobDetails>> getJobDetails(String uuid) async {
    return await JobsServices().getJobDetails(uuid);    
  }

}