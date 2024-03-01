import 'package:flutter/material.dart';
import 'package:pagepals/helpers/space_helper.dart';

class SignInBoxWidget extends StatefulWidget {
  final String text;

  const SignInBoxWidget({super.key, required this.text});

  @override
  State<SignInBoxWidget> createState() => _SignInBoxWidgetState();
}

class _SignInBoxWidgetState extends State<SignInBoxWidget> {
  late String widgetText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widgetText = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        borderRadius: BorderRadius.circular(SpaceHelper.space16),
        color: Colors.white,
        elevation: 8,
        shadowColor: Colors.black87,
        child: InkWell(
          borderRadius: BorderRadius.circular(SpaceHelper.space16),
          onTap: () {},
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Material(
                  borderRadius: BorderRadius.circular(SpaceHelper.space16),
                  clipBehavior: Clip.antiAlias,
                  child: const Image(
                    image: AssetImage('assets/signin_home.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                widgetText,
                style: const TextStyle(
                  fontSize: SpaceHelper.fontSize12,
                  fontWeight: FontWeight.bold,
                  height: 2.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
