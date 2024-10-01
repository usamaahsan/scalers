class JobDetails {
  Data? data;

  JobDetails({this.data});

  JobDetails.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? createdDate;
  List<int>? salaryRange;
  List<String>? benefits;
  Location? location;
  bool? openForDiscussion;
  bool? commissionBased;
  Type? type;
  Status? status;
  Status? workplacePreference;
  Status? workplaceType;
  Status? vertical;
  bool? isPredefinedListSet;
  Company? company;
  bool? isApplicationCanceled;
  IcpAnswers? icpAnswers;
  String? application;
  String? uuid;
  String? title;
  String? updatedDate;
  Description? description;
  Description? filters;
  String? uniqueToken;
  String? createdSource;
  bool? isCurationRequested;
  String? curationRequestedDateTime;
  String? cancellationReason;
  int? editAttempts;
  bool? isDefault;
  int? order;
  int? jobBucket;
  List<String>? genericCandidateApplications;

  Data(
      {this.id,
      this.createdDate,
      this.salaryRange,
      this.benefits,
      this.location,
      this.openForDiscussion,
      this.commissionBased,
      this.type,
      this.status,
      this.workplacePreference,
      this.workplaceType,
      this.vertical,
      this.isPredefinedListSet,
      this.company,
      this.isApplicationCanceled,
      this.icpAnswers,
      this.application,
      this.uuid,
      this.title,
      this.updatedDate,
      this.description,
      this.filters,
      this.uniqueToken,
      this.createdSource,
      this.isCurationRequested,
      this.curationRequestedDateTime,
      this.cancellationReason,
      this.editAttempts,
      this.isDefault,
      this.order,
      this.jobBucket,
      this.genericCandidateApplications});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDate = json['created_date'];
    salaryRange = json['salary_range'].cast<int>();
    benefits = json['benefits'].cast<String>();
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    openForDiscussion = json['open_for_discussion'];
    commissionBased = json['commission_based'];
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
    status =
        json['status'] != null ? Status.fromJson(json['status']) : null;
    workplacePreference = json['workplace_preference'] != null
        ? Status.fromJson(json['workplace_preference'])
        : null;
    workplaceType = json['workplace_type'] != null
        ? Status.fromJson(json['workplace_type'])
        : null;
    vertical =
        json['vertical'] != null ? Status.fromJson(json['vertical']) : null;
    isPredefinedListSet = json['is_predefined_list_set'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    isApplicationCanceled = json['isApplicationCanceled'];
    icpAnswers = json['icp_answers'] != null
        ? IcpAnswers.fromJson(json['icp_answers'])
        : null;
    application = json['application'];
    uuid = json['uuid'];
    title = json['title'];
    updatedDate = json['updated_date'];
    description = json['description'] != null
        ? Description.fromJson(json['description'])
        : null;
    filters = json['filters'] != null
        ? Description.fromJson(json['filters'])
        : null;
    uniqueToken = json['unique_token'];
    createdSource = json['created_source'];
    isCurationRequested = json['is_curation_requested'];
    curationRequestedDateTime = json['curation_requested_date_time'];
    cancellationReason = json['cancellation_reason'];
    editAttempts = json['edit_attempts'];
    isDefault = json['is_default'];
    order = json['order'];
    jobBucket = json['job_bucket'] ?? null;
      genericCandidateApplications = (json['generic_candidate_applications'] != null) 
    ? (json['generic_candidate_applications'] as List<dynamic>).cast<String>() 
    : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['created_date'] = createdDate;
    data['salary_range'] = salaryRange;
    data['benefits'] = benefits;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['open_for_discussion'] = openForDiscussion;
    data['commission_based'] = commissionBased;
    if (type != null) {
      data['type'] = type!.toJson();
    }
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (workplacePreference != null) {
      data['workplace_preference'] = workplacePreference!.toJson();
    }
    if (workplaceType != null) {
      data['workplace_type'] = workplaceType!.toJson();
    }
    if (vertical != null) {
      data['vertical'] = vertical!.toJson();
    }
    data['is_predefined_list_set'] = isPredefinedListSet;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    data['isApplicationCanceled'] = isApplicationCanceled;
    if (icpAnswers != null) {
      data['icp_answers'] = icpAnswers!.toJson();
    }
    data['application'] = application;
    data['uuid'] = uuid;
    data['title'] = title;
    data['updated_date'] = updatedDate;
    if (description != null) {
      data['description'] = description!.toJson();
    }
    if (filters != null) {
      data['filters'] = filters!.toJson();
    }
    data['unique_token'] = uniqueToken;
    data['created_source'] = createdSource;
    data['is_curation_requested'] = isCurationRequested;
    data['curation_requested_date_time'] = curationRequestedDateTime;
    data['cancellation_reason'] = cancellationReason;
    data['edit_attempts'] = editAttempts;
    data['is_default'] = isDefault;
    data['order'] = order;
    data['job_bucket'] = jobBucket;
    data['generic_candidate_applications'] = genericCandidateApplications;
    return data;
  }
}

class Location {
  int? id;
  String? nameAr;
  String? nameEn;
  int? listOrder;

  Location({this.id, this.nameAr, this.nameEn, this.listOrder});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    listOrder = json['list_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['list_order'] = listOrder;
    return data;
  }
}

class Type {
  int? id;
  String? nameAr;
  String? nameEn;
  int? order;

  Type({this.id, this.nameAr, this.nameEn, this.order});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['order'] = order;
    return data;
  }
}

class Status {
  int? id;
  String? nameAr;
  String? nameEn;

  Status({this.id, this.nameAr, this.nameEn});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    return data;
  }
}

class Company {
  String? name;
  String? logo;
  String? industry;
  String? description;
  String? website;
  String? linkedin;
  String? twitter;

  Company(
      {this.name,
      this.logo,
      this.industry,
      this.description,
      this.website,
      this.linkedin,
      this.twitter});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'];
    industry = json['industry'];
    description = json['description'];
    website = json['website'];
    linkedin = json['linkedin'];
    twitter = json['twitter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['logo'] = logo;
    data['industry'] = industry;
    data['description'] = description;
    data['website'] = website;
    data['linkedin'] = linkedin;
    data['twitter'] = twitter;
    return data;
  }
}

class IcpAnswers {
  List<JobRole>? jobRole;
  List<TypeOfSales>? typeOfSales;

  IcpAnswers({this.jobRole, this.typeOfSales});

  IcpAnswers.fromJson(Map<String, dynamic> json) {
    if (json['job-role'] != null) {
      jobRole = <JobRole>[];
      json['job-role'].forEach((v) {
        jobRole!.add(JobRole.fromJson(v));
      });
    }
    if (json['type-of-sales'] != null) {
      typeOfSales = <TypeOfSales>[];
      json['type-of-sales'].forEach((v) {
        typeOfSales!.add(TypeOfSales.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (jobRole != null) {
      data['job-role'] = jobRole!.map((v) => v.toJson()).toList();
    }
    if (typeOfSales != null) {
      data['type-of-sales'] = typeOfSales!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobRole {
  int? id;
  String? titleAr;
  String? titleEn;
  List<String>? nextQuestion;
  String? descriptionAr;
  String? descriptionEn;

  JobRole(
      {this.id,
      this.titleAr,
      this.titleEn,
      this.nextQuestion,
      this.descriptionAr,
      this.descriptionEn});

  JobRole.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleAr = json['title_ar'];
    titleEn = json['title_en'];
    nextQuestion = json['next_question'].cast<String>();
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title_ar'] = titleAr;
    data['title_en'] = titleEn;
    data['next_question'] = nextQuestion;
    data['description_ar'] = descriptionAr;
    data['description_en'] = descriptionEn;
    return data;
  }
}

class TypeOfSales {
  int? id;
  String? titleAr;
  String? titleEn;
  List<String>? nextQuestion;
  String? descriptionAr;
  String? descriptionEn;

  TypeOfSales(
      {this.id,
      this.titleAr,
      this.titleEn,
      this.nextQuestion,
      this.descriptionAr,
      this.descriptionEn});

  TypeOfSales.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleAr = json['title_ar'];
    titleEn = json['title_en'];

    nextQuestion = (json['next_question'] != null) 
    ? (json['next_question'] as List<dynamic>).cast<String>() 
    : [];

    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title_ar'] = titleAr;
    data['title_en'] = titleEn;
    data['next_question'] = nextQuestion;
    data['description_ar'] = descriptionAr;
    data['description_en'] = descriptionEn;
    return data;
  }
}

class Description {
  int? test;

  Description({this.test});

  Description.fromJson(Map<String, dynamic> json) {
    test = json['test'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['test'] = test;
    return data;
  }
}