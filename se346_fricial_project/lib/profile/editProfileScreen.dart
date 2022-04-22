import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se346_fricial_project/utils/colors.dart';
import 'dart:typed_data';

import '../authentication/widget/comomAuthMethod.dart';
import '../navigationBar/navigationBar.dart';
import '../resources/cloud_data_management.dart';
import '../utils/loading_widget.dart';
import '../utils/utils.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _isLoading = false;

  final GlobalKey<FormState> _infoKey = GlobalKey<FormState>();
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  Uint8List? _image;
  final CloudStoreDataManagement _cloudStoreDataManagement =
      CloudStoreDataManagement();

  @override
  void dispose() {
    super.dispose();
    _fullname.dispose();
    _username.dispose();
    _phone.dispose();
    _bio.dispose();
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _infoKey,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/ChangePassword.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: _isLoading
                ? LoadingWidget()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 62,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 71,
                          ),
                          Text(
                            "Update Your Profile",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: AppColors.white2,
                                fontSize: 24,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      GestureDetector(
                        onTap: selectImage,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Row(
                                children: [
                                  _image != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Image.memory(
                                            _image!,
                                            width: 120,
                                            height: 120,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : ClipRRect(
                                          child: Container(
                                            width: 120,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.grey1),
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                  'assets/icons/camera.svg'),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text(
                          "Full Name",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: AppColors.white1,
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InfomationTextFormField(
                        textEditingController: _fullname,
                        hintText: '  Enter your full name',
                        size: size,
                        validator: (inputVal) {
                          if (inputVal!.isEmpty) {
                            showSnackBar(context,
                                'Password must be at least 6 characters');
                            return '';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text(
                          "User Name",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: AppColors.white1,
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InfomationTextFormField(
                        textEditingController: _username,
                        hintText: '  Enter your user name',
                        size: size,
                        validator: (inputVal) {
                          if (inputVal!.isEmpty) {
                            showSnackBar(context,
                                'Password must be at least 6 characters');
                            return '';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text(
                          "Phone number",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: AppColors.white1,
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InfomationTextFormField(
                        textEditingController: _phone,
                        hintText: '  Enter your phone number',
                        size: size,
                        validator: (inputVal) {
                          if (inputVal!.isEmpty) {
                            showSnackBar(context,
                                'Password must be at least 10 characters');
                            return '';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text(
                          "Biography",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: AppColors.white1,
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InfomationTextFormField(
                        textEditingController: _bio,
                        hintText: '  Enter your biography',
                        size: size,
                        validator: (inputVal) {
                          if (inputVal!.isEmpty) {
                            showSnackBar(context,
                                'Password must be at least 10 characters');
                            return '';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      ConFirmButton(context, 'Confirm', size),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget ConFirmButton(BuildContext context, String buttonName, Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 122, right: 122),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(size.width, 32.0),
          elevation: 5.0,
          primary: AppColors.white1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
        child: Text(
          buttonName,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: AppColors.black,
              fontSize: 12,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        onPressed: () async {
          if (this._infoKey.currentState!.validate()) {
            print('Validated');
            SystemChannels.textInput.invokeMethod('TextInput.hide');

            if (mounted) {
              setState(() {
                this._isLoading = true;
              });
            }

            String msg = '';

            final bool canRegisterNewUser = await _cloudStoreDataManagement
                .checkThisUserAlreadyPresentOrNot(
                    userName: this._username.text);

            if (!canRegisterNewUser)
              msg = 'User Name Already Present';
            else {
              final bool _userEntryResponse =
                  await _cloudStoreDataManagement.registerNewUser(
                fullname: this._fullname.text,
                userName: this._username.text,
                phone: this._phone.text,
                bio: this._bio.text,
                file: _image!,
              );

              if (_userEntryResponse) {
                msg = 'User data Entry Successfully';

                /// Calling Local Databases Methods To Intitialize Local Database with required MEthods
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => navigationBar(),
                    ),
                    (route) => false);
              } else
                msg = 'User Data Not Entry Successfully';
            }

            showSnackBar(context, msg);
            if (mounted) {
              setState(() {
                this._isLoading = true;
              });
            }
          } else {
            print('Not Validated');
          }
        },
      ),
    );
  }
}
