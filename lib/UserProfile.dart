import 'package:flutter/material.dart';

const Color charcoal = Color(0xFF333333);
const Color oliveGreen = Color(0xFF97B469);

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(5.0),
          child: Container(color: oliveGreen, height: 3.0),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 70.0,
          vertical: 70.0,
        ), // Equal margins
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Section - Profile Image & Buttons
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                          Icons.person,
                          size: 120,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 35),
                      Row(
                        children: [
                          _buildButton("Upload", oliveGreen),
                          SizedBox(width: 10),
                          _buildOutlinedButton("Remove", oliveGreen),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 50), // Space between image section and card
                  // Right Section - Profile Info Card
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: oliveGreen, width: 3.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "User Profile",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 18),
                          Row(
                            children: [
                              Expanded(child: _buildTextField("First Name")),
                              SizedBox(width: 10),
                              Expanded(child: _buildTextField("Last Name")),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(child: _buildTextField("Date Joined")),
                              SizedBox(width: 10),
                              Expanded(child: _buildTextField("Streak")),
                            ],
                          ),
                          SizedBox(height: 16),
                          _buildTextField("Email"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // Bottom Buttons
            Column(
              children: [
                _buildButton("Delete Account", Colors.grey[900]!),
                SizedBox(height: 10),
                _buildButton("Logout", Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(String text, Color color) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        minimumSize: Size(160, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Text(text, textAlign: TextAlign.center),
    );
  }

  Widget _buildOutlinedButton(String text, Color color) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        foregroundColor: color,
        minimumSize: Size(160, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Text(text, textAlign: TextAlign.center),
    );
  }
}
