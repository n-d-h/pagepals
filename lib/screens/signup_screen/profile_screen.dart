import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/signup_screen/signup_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String email;

  const ProfileScreen({super.key, required this.email});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _obscurePassword = true;
  late String userEmail;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool isChecked = false;

  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String? selectedGender;

  @override
  void initState() {
    super.initState();
    userEmail = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            // Handle tap on screen to dismiss keyboard
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: ScrollController(),
            child: Container(
              width: MediaQuery.of(context).size.width *
                  SpaceHelper.spaceNineTenths,
              margin: const EdgeInsets.fromLTRB(20, 55, 20, 0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      height: 28,
                      child: const Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                    ),
                    TextField(
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      readOnly: true,
                      controller: TextEditingController(text: userEmail),
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.check),
                        suffixIconColor:
                            ColorHelper.getColor(ColorHelper.green),
                        prefixIcon: const Icon(Icons.alternate_email_outlined),
                        prefixIconColor: Colors.grey,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 12),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorHelper.getColor(ColorHelper.grey),
                              width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorHelper.getColor(ColorHelper.grey),
                              width: 1),
                          // Customize the focused border color if needed
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.none,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      height: 28,
                      child: const Text(
                        'Username',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                    ),
                    TextField(
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      controller: _userNameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        prefixIconColor: Colors.grey,
                        // hintText: 'Username',
                        // hintStyle:
                        //     const TextStyle(fontSize: 16, color: Colors.grey),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 12),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorHelper.getColor(ColorHelper.grey),
                              width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorHelper.getColor(ColorHelper.green),
                              width: 2),
                          // Customize the focused border color if needed
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      height: 28,
                      child: const Text(
                        'Password',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                    ),
                    TextField(
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        prefixIconColor: Colors.grey,
                        // hintText: 'Password',
                        // hintStyle:
                        //     const TextStyle(fontSize: 16, color: Colors.grey),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 12),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorHelper.getColor(ColorHelper.grey),
                              width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorHelper.getColor(ColorHelper.green),
                              width: 2),
                          // Customize the focused border color if needed
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscurePassword,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      height: 28,
                      child: const Text(
                        'Full Name',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                    ),
                    TextField(
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.description),
                        prefixIconColor: Colors.grey,
                        // hintText: 'Full Name',
                        // hintStyle:
                        //     const TextStyle(fontSize: 16, color: Colors.grey),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 12),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorHelper.getColor(ColorHelper.grey),
                              width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorHelper.getColor(ColorHelper.green),
                              width: 2),
                          // Customize the focused border color if needed
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      height: 28,
                      child: const Text(
                        'Phone number',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                    ),
                    TextField(
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      controller: _phoneController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        prefixIconColor: Colors.grey,
                        // hintText: 'Phone number',
                        // hintStyle:
                        //     const TextStyle(fontSize: 16, color: Colors.grey),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 12),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorHelper.getColor(ColorHelper.grey),
                              width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorHelper.getColor(ColorHelper.green),
                              width: 2),
                          // Customize the focused border color if needed
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      height: 28,
                      child: const Text(
                        'Gender',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                    ),
                    DropdownButtonFormField2<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        prefixIcon: selectedGender == 'Male'
                            ? const Icon(
                                Icons.male_sharp,
                                color: Colors.grey,
                              )
                            : selectedGender == 'Female'
                                ? const Icon(
                                    Icons.female_sharp,
                                    color: Colors.grey,
                                  )
                                : null,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 12),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorHelper.getColor(ColorHelper.grey),
                              width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorHelper.getColor(ColorHelper.green),
                              width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      hint: const Text(
                        'Select Your Gender',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      items: genderItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select gender.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Update selectedGender to control the visibility of the icon
                        setState(() {
                          selectedGender = value.toString();
                        });
                      },
                      onSaved: (value) {
                        selectedGender = value.toString();
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: MediaQuery.of(context).size.width *
                            SpaceHelper.spaceNineTenths,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 48),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            flex: 0,
                            child: Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateColor.resolveWith((states) {
                                  const Set<MaterialState> interactiveStates =
                                      <MaterialState>{
                                    MaterialState.pressed,
                                    MaterialState.hovered,
                                    MaterialState.selected,
                                  };
                                  if (states.any(interactiveStates.contains)) {
                                    return ColorHelper.getColor(
                                        ColorHelper.green);
                                  }
                                  return ColorHelper.getColor(
                                      ColorHelper.white
                                  );
                                }),

                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                })),
                        Expanded(
                          flex: 9,
                          child: RichText(
                            textAlign: TextAlign.start,
                            // Align the text inside RichText
                            text: TextSpan(
                              text: 'By Signing up, you agree to PagePals ',
                              style: TextStyle(
                                fontSize: SpaceHelper.fontSize14,
                                fontWeight: FontWeight.w400,
                                color: ColorHelper.getColor(ColorHelper.black),
                              ),
                              children: [
                                TextSpan(
                                  text: 'Terms of Services ',
                                  style: TextStyle(
                                    fontSize: SpaceHelper.fontSize14,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        ColorHelper.getColor(ColorHelper.green),
                                  ),
                                ),
                                TextSpan(
                                  text: '& ',
                                  style: TextStyle(
                                    fontSize: SpaceHelper.fontSize14,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        ColorHelper.getColor(ColorHelper.black),
                                  ),
                                ),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    fontSize: SpaceHelper.fontSize14,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        ColorHelper.getColor(ColorHelper.green),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity, // <-- match_parent
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageTransition(
                              child: const SignupScreen(),
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 300),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              ColorHelper.getColor(ColorHelper.white),
                          backgroundColor:
                              ColorHelper.getColor(ColorHelper.green),
                          padding: const EdgeInsets.symmetric(
                            horizontal: SpaceHelper.space16,
                            vertical: 9,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: SpaceHelper.fontSize16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
