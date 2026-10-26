import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/constants/portfolio_data.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/url_helper.dart';
import 'custom_button.dart';

class BookingForm extends StatefulWidget {
  final String? initialEventType;

  const BookingForm({super.key, this.initialEventType});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _messageController = TextEditingController();

  String _selectedEventType = "Wedding";
  DateTime? _selectedDate;
  bool _isSending = false;

  static const List<String> eventTypes = [
    "Wedding",
    "Corporate Event",
    "Private Show",
    "Concert",
    "Learning Session",
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialEventType != null && eventTypes.contains(widget.initialEventType)) {
      _selectedEventType = widget.initialEventType!;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now.add(const Duration(days: 7)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 730)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.gold,
              onPrimary: Color(0xFF1A1208),
              surface: AppColors.surface,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _handleWhatsAppSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSending = true);
    await Future.delayed(const Duration(milliseconds: 500));

    final dateStr = _selectedDate != null
        ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
        : "To be decided";

    final text = """Hello Balu Saxophonist!
I would like to book an alto saxophone performance for an upcoming event.

Details:
• Name: ${_nameController.text.trim()}
• Phone: ${_phoneController.text.trim()}
• Event Type: $_selectedEventType
• Preferred Date: $dateStr
• Location: ${_locationController.text.trim()}
• Special Requests: ${_messageController.text.trim().isEmpty ? 'None' : _messageController.text.trim()}

Looking forward to connecting with you!""";

    if (mounted) {
      await UrlHelper.launchWhatsApp(context, BaluSaxData.phoneDigits, text);
      setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.surface.withOpacity(0.85),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.goldLine),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Event Booking Inquiry",
                  style: TextStyle(
                    fontFamily: AppTheme.fontPlayfair,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Share your event requirements. Upon clicking Send, your inquiry opens directly in WhatsApp for prompt personal confirmation.",
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),

                // Name and Phone
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 500;
                    return isWide
                        ? Row(
                            children: [
                              Expanded(child: _buildNameField()),
                              const SizedBox(width: 16),
                              Expanded(child: _buildPhoneField()),
                            ],
                          )
                        : Column(
                            children: [
                              _buildNameField(),
                              const SizedBox(height: 16),
                              _buildPhoneField(),
                            ],
                          );
                  },
                ),
                const SizedBox(height: 16),

                // Event Type and Date
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 500;
                    return isWide
                        ? Row(
                            children: [
                              Expanded(child: _buildEventTypeDropdown()),
                              const SizedBox(width: 16),
                              Expanded(child: _buildDatePicker()),
                            ],
                          )
                        : Column(
                            children: [
                              _buildEventTypeDropdown(),
                              const SizedBox(height: 16),
                              _buildDatePicker(),
                            ],
                          );
                  },
                ),
                const SizedBox(height: 16),

                // Location
                _buildLocationField(),
                const SizedBox(height: 16),

                // Message
                _buildMessageField(),
                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: "Send via WhatsApp",
                    icon: Icons.chat_bubble_outline_rounded,
                    variant: ButtonVariant.gold,
                    isLoading: _isSending,
                    onPressed: _handleWhatsAppSubmit,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                const SizedBox(height: 12),

                // Email fallback
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      UrlHelper.launchEmail(
                        context,
                        BaluSaxData.email,
                        subject: "Performance Booking Inquiry - Balu Saxophonist",
                      );
                    },
                    icon: const Icon(Icons.alternate_email_rounded, size: 14, color: AppColors.gold),
                    label: const Text(
                      "Prefer email? Click to send directly to booking@balusax.com",
                      style: TextStyle(color: AppColors.textMuted, fontSize: 11),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return _fieldWrapper(
      label: "YOUR NAME",
      child: TextFormField(
        controller: _nameController,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        validator: (v) => v == null || v.trim().isEmpty ? "Name is required" : null,
        decoration: _inputDecoration(hint: "e.g. Rahul Sharma", icon: Icons.person_outline_rounded),
      ),
    );
  }

  Widget _buildPhoneField() {
    return _fieldWrapper(
      label: "PHONE NUMBER",
      child: TextFormField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        validator: (v) => v == null || v.trim().isEmpty ? "Phone number is required" : null,
        decoration: _inputDecoration(hint: "+91 98765 43210", icon: Icons.phone_outlined),
      ),
    );
  }

  Widget _buildEventTypeDropdown() {
    return _fieldWrapper(
      label: "EVENT TYPE",
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: AppColors.background.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedEventType,
            dropdownColor: AppColors.surface,
            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.gold),
            isExpanded: true,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            items: eventTypes.map((type) {
              return DropdownMenuItem(value: type, child: Text(type));
            }).toList(),
            onChanged: (val) {
              if (val != null) setState(() => _selectedEventType = val);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    final dateDisplay = _selectedDate != null
        ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
        : "Select Date";

    return _fieldWrapper(
      label: "EVENT DATE",
      child: InkWell(
        onTap: _selectDate,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.background.withOpacity(0.6),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateDisplay,
                style: TextStyle(
                  color: _selectedDate != null ? Colors.white : AppColors.textMuted,
                  fontSize: 14,
                ),
              ),
              const Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.gold),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationField() {
    return _fieldWrapper(
      label: "EVENT VENUE / LOCATION",
      child: TextFormField(
        controller: _locationController,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        validator: (v) => v == null || v.trim().isEmpty ? "Location is required" : null,
        decoration: _inputDecoration(hint: "e.g. Taj Palace, Mumbai or Udaipur", icon: Icons.location_on_outlined),
      ),
    );
  }

  Widget _buildMessageField() {
    return _fieldWrapper(
      label: "MESSAGE / SPECIAL REQUESTS",
      child: TextFormField(
        controller: _messageController,
        maxLines: 3,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: _inputDecoration(
          hint: "Tell us about guest count, timing, acoustic preferences, or favorite melodies...",
          icon: Icons.music_note_outlined,
        ),
      ),
    );
  }

  Widget _fieldWrapper({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.gold,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }

  InputDecoration _inputDecoration({required String hint, required IconData icon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
      prefixIcon: Icon(icon, color: AppColors.gold.withOpacity(0.8), size: 18),
      filled: true,
      fillColor: AppColors.background.withOpacity(0.6),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.glassBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.glassBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.accentRed),
      ),
    );
  }
}
