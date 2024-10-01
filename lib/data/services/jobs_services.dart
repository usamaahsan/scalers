import 'dart:convert';
import 'package:scalers_job_portal/utils/APIresult.dart';
import 'package:http/http.dart' as http;
import 'package:scalers_job_portal/data/models/JobDetails.dart';
import 'package:scalers_job_portal/data/models/Jobs.dart';

class JobsServices{

  http.Client client = http.Client();

  Future<APIresult<Jobs>> getJobsList() async {
    try{
      final response = await client.get(Uri.parse("https://mpa0771a40ef48fcdfb7.free.beeceptor.com/jobs"), 
      headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
      Jobs jobs =  Jobs.fromJson(jsonDecode(response.body));
      return APIresult.success(jobs);
    }
    catch(e){
      print(e);
      return APIresult.error("Some error occured while getting jobs list");
    }

  }


  Future<APIresult<JobDetails>> getJobDetails(String uuid) async {

    try{
      final response = await client.get(Uri.parse("https://mpa0771a40ef48fcdfb7.free.beeceptor.com/jobs/$uuid"), 
      headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
      JobDetails details =  JobDetails.fromJson(jsonDecode(response.body));
      return APIresult.success(details);
    }
    catch(e){
      print(e);
      return APIresult.error("Some error occured while getting jobs details");
    }

  }

}