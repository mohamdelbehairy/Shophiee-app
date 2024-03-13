import 'package:app/widgets/verification_page/verificaton_text_field.dart';
import 'package:flutter/material.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.withOpacity(.010),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verification Security Code',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
                'Just enable the dark mode and be\n king to the nightmare world',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                VerificationTextField(
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                VerificationTextField(
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  }
                ),
                VerificationTextField(
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  }
                ),
                VerificationTextField(
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  }
                ),
              ],
            ),
            SizedBox(height: 32),
            Center(child: CircularProgressIndicator()),
            SizedBox(height: 8),
            Center(child: Text('Verifing Code')),
            SizedBox(height: 32),
            TextButton(onPressed: (){},
            child: Center(child: Text("Didn't Get Code?Resend")))
          ],
        ),
      ),
    );
  }
}
