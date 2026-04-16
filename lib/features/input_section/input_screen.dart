import 'package:flutter/material.dart';
import 'package:lecture/core/widgets/custom_appbar.dart'; // Your custom appbar

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  // --- MASTER STATE ---
  String selectedConcept = 'Text Entry';

  // --- TEXT ENTRY STATE ---
  String liveText = '';
  bool isPasswordHidden = true;

  // --- TOGGLES STATE ---
  bool isSwitchOn = false;
  bool isChecked = false;
  String selectedRadio = 'Free'; // Default selected tier

  // --- FORM VALIDATION STATE ---
  // A GlobalKey is required to trigger validation on a Form
  final _formKey = GlobalKey<FormState>();
  String formStatus = 'Awaiting Submission...';

  // --- THE LIVE PREVIEW RENDERER ---
  Widget _buildCanvasContent() {
    switch (selectedConcept) {
      case 'Text Entry':
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You typed: ${liveText.isEmpty ? '...' : liveText}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 30),

                // Standard Text Field
                TextField(
                  // onChanged fires every single time a key is pressed
                  onChanged: (value) => setState(() => liveText = value),
                  decoration: const InputDecoration(
                    labelText: 'Standard Input',
                    hintText: 'Type something here...',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.edit),
                  ),
                ),
                const SizedBox(height: 20),

                // Password Text Field
                TextField(
                  obscureText: isPasswordHidden, // Hides the text
                  decoration: InputDecoration(
                    labelText: 'Password Input',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    // A button inside the text field to toggle visibility
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordHidden
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () =>
                          setState(() => isPasswordHidden = !isPasswordHidden),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

      case 'Toggles & Choices':
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Switch (On/Off)
              SwitchListTile(
                title: const Text('Notifications (Switch)'),
                subtitle: Text(
                  isSwitchOn ? 'Enabled' : 'Disabled',
                  style: TextStyle(
                    color: isSwitchOn ? Colors.green : Colors.red,
                  ),
                ),
                value: isSwitchOn,
                onChanged: (val) => setState(() => isSwitchOn = val),
              ),
              const Divider(),

              //Checkbox (Yes/No)
              CheckboxListTile(
                title: const Text('Agree to Terms (Checkbox)'),
                value: isChecked,
                onChanged: (val) => setState(() => isChecked = val ?? false),
              ),
              const Divider(),

              // 3. Radio Buttons 
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select a Tier (Radio):",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              RadioGroup<String>(
                groupValue: selectedRadio,
                onChanged: (val) {
                  if (val != null) {
                    setState(() => selectedRadio = val);
                  }
                },
                // RadioGroup only takes one child, so we use a Column
                child: Column(
                  children: const [
                    // The individual tiles now ONLY need their unique 'value'
                    RadioListTile<String>(
                      title: Text('Free Tier'),
                      value: 'Free',
                    ),
                    RadioListTile<String>(
                      title: Text('Pro Tier'),
                      value: 'Pro',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      case 'Form Validation':
      default:
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Notice this is a TextFORMField, not a standard TextField!
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Username (Required)',
                      border: OutlineInputBorder(),
                    ),
                    // The Validator checks the rules before allowing submission
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username'; // Shows red error text
                      }
                      if (value.length < 4) {
                        return 'Username must be at least 4 characters';
                      }
                      return null; // Null means it passed validation!
                    },
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(
                        double.infinity,
                        50,
                      ), // Full width button
                    ),
                    onPressed: () {
                      // Trigger the validation check!
                      if (_formKey.currentState!.validate()) {
                        setState(() => formStatus = 'Success! Form Submitted.');
                      } else {
                        setState(
                          () => formStatus = 'Failed. Fix the errors above.',
                        );
                      }
                    },
                    child: const Text('Submit Form'),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    formStatus,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: formStatus.contains('Success')
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Your custom Appbar remains perfectly intact!
      appBar: const CustomAppbar(text: "Input Playground"),

      // We inject the Controls and Canvas directly into the body
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- SECTION 1: CONTROLS ---
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "Controls",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Input Concept",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        DropdownButton<String>(
                          value: selectedConcept,
                          items:
                              [
                                'Text Entry',
                                'Toggles & Choices',
                                'Form Validation',
                              ].map((String val) {
                                return DropdownMenuItem(
                                  value: val,
                                  child: Text(
                                    val,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }).toList(),
                          onChanged: (val) {
                            if (val != null)
                              setState(() => selectedConcept = val);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              "Live Preview:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // --- SECTION 2: THE CANVAS ---
            Expanded(
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _buildCanvasContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
