class GetCodes {
	String? result;
	String? documentation;
	String? termsOfUse;
	List<SupportedCodes>? supportedCodes;

	GetCodes({this.result, this.documentation, this.termsOfUse, this.supportedCodes});

	GetCodes.fromJson(Map<String, dynamic> json) {
		result = json['result'];
		documentation = json['documentation'];
		termsOfUse = json['terms_of_use'];
		if (json['supported_codes'] != null) {
			supportedCodes = <SupportedCodes>[];
			json['supported_codes'].forEach((v) { 
        print(v);
      supportedCodes!.add(SupportedCodes.fromJson(v));
        
      });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data =  Map<String, dynamic>();
		data['result'] = result;
		data['documentation'] = documentation;
		data['terms_of_use'] = termsOfUse;
		// if (this.supportedCodes != null) {
    //   data['supported_codes'] = this.supportedCodes!.map((v) => v.toJson()).toList();
    // }
		return data;
	}
}

class SupportedCodes {
  String? countryCode;
  String? country;

	SupportedCodes({this.countryCode,this.country});

	SupportedCodes.fromJson(List json) {
    countryCode = json[0];
    country =json[1];
  }

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		return data;
	}

  
}