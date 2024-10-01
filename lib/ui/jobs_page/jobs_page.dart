import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalers_job_portal/utils/timeUtils.dart';
import 'package:scalers_job_portal/core/textStyles.dart';
import 'package:scalers_job_portal/core/theme.dart';
import 'package:scalers_job_portal/data/models/Jobs.dart';
import 'package:scalers_job_portal/usecases/jobs_usecase.dart';
import 'package:scalers_job_portal/ui/job_details_page/job_details_page.dart';
import 'package:scalers_job_portal/ui/jobs_page/cubit/jobs_page_cubit.dart';


class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {

  JobsPageCubit cubit = JobsPageCubit(JobsUseCase());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: const Key('refresh_indicator'),
      color: primaryColor,      
      onRefresh: ()async{
        cubit.getJobs();
      },
      child: Scaffold(
        appBar: appBar(),
        body: bodyLayout()
      ),
    );
  }

  PreferredSizeWidget appBar(){
    return PreferredSize(
      preferredSize: const Size.fromHeight(44),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xffF6f8f6), width: 1))
        ),
        child: AppBar(
          toolbarHeight: 44,
          backgroundColor: Colors.white,          
          title: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text("Jobs", style: appBarTextStyle,)),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: IconButton(
                key: const Key('notifications_btn'),
                color: primaryColor,
                onPressed: (){},
                icon: const Icon(Icons.notifications_outlined),
              ),
            )
          ],
        ),
      )
    );
  }


  Widget bodyLayout(){
    return BlocProvider(
      create: (context) => cubit,
      child: const JobsView()
    );
  }
}

class JobsView extends StatelessWidget {
  const JobsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobsPageCubit, JobsPageCubitState>(
        builder: (context, state) {
          if(state is JobsPageCubitInitial || state is JobsPageCubitLoading){
            return const Center(child: CupertinoActivityIndicator(key: Key('progress_indicator'),));
          }
          else if(state is JobsPageCubitLoaded){

            if(state.jobsData.data == null){
              return const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: Text("No Jobs Found", textAlign: TextAlign.center,),));
            }

            if(state.jobsData.data!.isEmpty){
              return const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: Text("No Jobs Found", textAlign: TextAlign.center,),));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.jobsData.data?.length ?? 0,
              itemBuilder: (context, index) {
                return jobCard(state.jobsData.data![index], context);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16,);
              },
            );
          }
          else if(state is JobsPageCubitError){
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Center(child: Text(state.errorMessage, textAlign: TextAlign.center,),));
          }
          else {
            return const SizedBox();
          }
        },
      );
  }


  Widget jobCard(JobData data, BuildContext context){
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: (){
          Navigator.push(
            context,
              MaterialPageRoute(builder: (context) => JobDetailsPage(uuid: data.job?.uuid ?? "",)),
            );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xfff8f6f8), width: 1)
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  companyLogo(data.job?.company?.logo ?? ""),
                  const SizedBox(width: 8,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(data.job?.title ?? "", style: jobCardTitleTextStyle,),
                        Text(data.job?.company?.name ?? "", style: jobCardDetailsTextStyle,),
                        Text(key: Key('job_location:${data.job?.id}'), "${data.job?.location?.nameEn} . ${data.job?.workplacePreference?.nameEn} . ${data.job?.type?.nameEn}", style: jobCardDetailsTextStyle,),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(getTimePosted(data.job?.createdDate ?? ""), style: jobCardTimeTextStyle,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget companyLogo(String logo){
    return CachedNetworkImage(
      height: 54,
      width: 54,
      fit: BoxFit.cover,
      imageUrl: logo,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover
          )
        ),
      ),
      placeholder: (context, url) => const CupertinoActivityIndicator(),
      errorWidget: (context, url, error) => const SizedBox(),
      fadeInDuration: const Duration(milliseconds: 200),
    );
  }

}