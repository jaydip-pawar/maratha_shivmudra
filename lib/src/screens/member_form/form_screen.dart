import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/src/widgets/responsive_rc.dart';
import 'package:maratha_shivmudra/src/widgets/section.dart';
import 'package:maratha_shivmudra/src/widgets/textfields/text_field.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  List<Widget> get _personalDetails {
    return [
      CustomTextField(
        labelText: 'पहिले नाव',
        isCompulsory: true,
        prefixIconData: Icons.person_outline,
      ),
      CustomTextField(
        labelText: 'मधले नाव',
      ),
      CustomTextField(
        labelText: 'आडनाव',
        isCompulsory: true,
      ),
    ];
  }

  List<List<Widget>> get _addressDetails {
    return [
      [
        CustomTextField(
          labelText: 'शहर',
          isCompulsory: true,
        ),
        CustomTextField(
          labelText: 'राज्य',
          isCompulsory: true,
        ),
      ],
      [
        CustomTextField(
          labelText: 'पिनकोड',
          isCompulsory: true,
        ),
        CustomTextField(
          labelText: 'देश',
          isCompulsory: true,
        ),
      ]
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 32,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Text(
                      'सभासद फॉर्म',
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Section(
                    spacing: 16,
                    children: [
                      ResponsiveRC(children: _personalDetails),
                      CustomTextField(
                        labelText: 'वय ',
                        isCompulsory: true,
                        prefixIconData: Icons.onetwothree,
                      ),
                    ],
                  ),
                  Section(
                    spacing: 16,
                    children: [
                      CustomTextField(
                        labelText: 'पत्ता',
                        isCompulsory: true,
                      ),
                      CustomTextField(
                        labelText: 'रूम नं व सोसायटी नाव',
                        isCompulsory: true,
                      ),
                      ResponsiveRC(children: _addressDetails[0]),
                      ResponsiveRC(children: _addressDetails[1]),
                    ],
                  ),
                  Section(
                    child: CustomTextField(
                      labelText: 'मोबाईल नंबर',
                      isCompulsory: true,
                      prefixIconData: Icons.phone_outlined,
                    ),
                  ),
                  Section(
                    child: CustomTextField(
                      labelText: 'ईमेल',
                      isCompulsory: true,
                      prefixIconData: Icons.email_outlined,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
