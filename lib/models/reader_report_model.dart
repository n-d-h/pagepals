class ReaderReportModel {
  List<String>? milestones;
  List<int>? completedBookingData;
  List<int>? canceledBookingData;
  int? successBookingRate;
  int? totalFinishBookingInThisPeriod;
  String? totalIncomeInThisPeriod;
  String? totalAmountShareInThisPeriod;
  String? totalProfitInThisPeriod;
  String? totalRefundInThisPeriod;
  int? allTimeTotalFinishBooking;
  String? allTimeIncome;
  int? totalActiveServices;

  ReaderReportModel({
    this.milestones,
    this.completedBookingData,
    this.canceledBookingData,
    this.successBookingRate,
    this.totalFinishBookingInThisPeriod,
    this.totalIncomeInThisPeriod,
    this.totalAmountShareInThisPeriod,
    this.totalProfitInThisPeriod,
    this.totalRefundInThisPeriod,
    this.allTimeTotalFinishBooking,
    this.allTimeIncome,
    this.totalActiveServices,
  });

  ReaderReportModel.fromJson(Map<String, dynamic> json) {
    if (json['milestones'] != null) {
      milestones = <String>[];
      json['milestones'].forEach((v) {
        milestones!.add(v);
      });
    }
    if (json['completedBookingData'] != null) {
      completedBookingData = <int>[];
      json['completedBookingData'].forEach((v) {
        completedBookingData!.add(v);
      });
    }
    if (json['canceledBookingData'] != null) {
      canceledBookingData = <int>[];
      json['canceledBookingData'].forEach((v) {
        canceledBookingData!.add(v);
      });
    }
    successBookingRate = json['successBookingRate'];
    totalFinishBookingInThisPeriod = json['totalFinishBookingInThisPeriod'];
    totalIncomeInThisPeriod = json['totalIncomeInThisPeriod'];
    totalAmountShareInThisPeriod = json['totalAmountShareInThisPeriod'];
    totalProfitInThisPeriod = json['totalProfitInThisPeriod'];
    totalRefundInThisPeriod = json['totalRefundInThisPeriod'];
    allTimeTotalFinishBooking = json['allTimeTotalFinishBooking'];
    allTimeIncome = json['allTimeIncome'];
    totalActiveServices = json['totalActiveServices'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['milestones'] = milestones != null ? milestones!.toList() : null;
    data['completedBookingData'] =
        completedBookingData != null ? completedBookingData!.toList() : null;
    data['canceledBookingData'] =
        canceledBookingData != null ? canceledBookingData!.toList() : null;
    data['successBookingRate'] = successBookingRate;
    data['totalFinishBookingInThisPeriod'] = totalFinishBookingInThisPeriod;
    data['totalIncomeInThisPeriod'] = totalIncomeInThisPeriod;
    data['totalAmountShareInThisPeriod'] = totalAmountShareInThisPeriod;
    data['totalProfitInThisPeriod'] = totalProfitInThisPeriod;
    data['totalRefundInThisPeriod'] = totalRefundInThisPeriod;
    data['allTimeTotalFinishBooking'] = allTimeTotalFinishBooking;
    data['allTimeIncome'] = allTimeIncome;
    data['totalActiveServices'] = totalActiveServices;
    return data;
  }
}
