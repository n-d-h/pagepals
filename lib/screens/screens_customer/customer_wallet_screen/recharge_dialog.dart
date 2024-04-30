import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/services/momo_service.dart';
import 'package:pagepals/services/setting_service.dart';
import 'package:url_launcher/url_launcher.dart';

class RechargeDialog extends StatefulWidget {
  final AccountModel? account;

  const RechargeDialog({super.key, this.account});

  @override
  State<RechargeDialog> createState() => _RechargeDialogState();
}

class _RechargeDialogState extends State<RechargeDialog> {
  TextEditingController _controller = TextEditingController();
  int _amount = 0;
  int exchange = 24000;

  Future<void> init() async {
    Map<String, String> settings = await SettingsService.getAllSettings();
    String? dollarExchangeRate = settings['DOLLAR_EXCHANGE_RATE'];
    setState(() {
      exchange =
          dollarExchangeRate != null ? int.parse(dollarExchangeRate) : exchange;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recharge',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorHelper.getColor(ColorHelper.green),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            keyboardType: TextInputType.number,
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter amount',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _amount = value.isEmpty ? 0 : int.parse(value);
              });
            },
          ),
          SizedBox(height: 8),
          if (_amount > 0)
            Text(
              textAlign: TextAlign.center,
              '${NumberFormat.compact(
                locale: 'en_US',
                explicitSign: false,
              ).format(_amount)} pals = ${NumberFormat.currency(
                locale: 'vi_VN',
                decimalDigits: 0,
              ).format(_amount * exchange)}',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
              ),
            ),
          SizedBox(height: 8),
          InkWell(
            onTap: () async {
              Future.delayed(const Duration(milliseconds: 500), () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.greenAccent,
                        size: 60,
                      ),
                    );
                  },
                );
              });
              var response = await MoMoService.getMoMoResponse(
                  int.parse(_controller.text),
                  widget.account?.customer?.id ?? '');
              Uri url = Uri.parse(response.payUrl!);

              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }

              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pop(context);
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.monetization_on,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Recharge',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
