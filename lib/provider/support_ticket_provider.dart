import 'package:sixvalley_ui_kit/helper/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/body/support_ticket_body.dart';
import 'package:sixvalley_ui_kit/data/model/response/support_ticket_model.dart';
import 'package:sixvalley_ui_kit/data/repository/support_ticket_repo.dart';

class SupportTicketProvider extends ChangeNotifier {
  final SupportTicketRepo supportTicketRepo;
  SupportTicketProvider({@required this.supportTicketRepo});

  List<SupportTicketModel> _supportTicketList;
  bool _isLoading = false;

  List<SupportTicketModel> get supportTicketList => _supportTicketList;
  bool get isLoading => _isLoading;

  void sendSupportTicket(SupportTicketBody supportTicketBody, Function(bool isSuccess, String message) callback) async {
    String message = "successful";
    callback(true, message);
    _isLoading = false;
    _supportTicketList.add(SupportTicketModel(description: supportTicketBody.description, type: supportTicketBody.type,
        subject: supportTicketBody.subject, createdAt: DateConverter.formatDate(DateTime.now()), status: 'pending'));
    notifyListeners();
      _isLoading = false;
      notifyListeners();
  }

  void getSupportTicketList() async {
    if(_supportTicketList == null) {
      _supportTicketList = [];
      supportTicketRepo.getSupportTicketList().forEach((supportTicket) => _supportTicketList.add(supportTicket));
      notifyListeners();
    }
  }
}
