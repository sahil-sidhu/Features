import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // top row with multiple columns
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    FooterLink(text: 'Blog'),
                    FooterLink(text: 'Jobs'),
                    FooterLink(text: 'Contact Us'),
                    FooterLink(text: 'Donor Bill of Rights'),
                    FooterLink(text: 'Privacy Policy'),
                  ],
                ),
              ),
              // Middle Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    FooterLink(text: 'AODA Compliancy & Procedures'),
                    FooterLink(text: 'Complaints Policy'),
                    FooterLink(text: 'Terms & Conditions'),
                    FooterLink(text: 'Site Map'),
                  ],
                ),
              ),
              // Right Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ContactRow(
                      icon: Icons.phone,
                      label: 'x-xxx-xxx-xxxx',
                    ),
                    SizedBox(height: 8),
                    ContactRow(
                      icon: Icons.email,
                      label: 'info@CHAMBAS.ca',
                    ),
                    SizedBox(height: 8),
                    ContactRow(
                      icon: Icons.location_on,
                      label:
                          'Task helper Canada\n108 University avenue west,\nSuite 1100,\nWaterloo, ON, L5C 4R3',
                    ),
                    SizedBox(height: 8),
                    ContactRow(
                      icon: Icons.access_time,
                      label:
                          'Mon - Fri: 9am - 7pm EST\nSat - Sun: 12pm - 5pm EST',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Social media icons row
          Row(
            children: [
              SocialIcon(
                icon: Icons.facebook,
                onTap: () {
                  // handle FB link
                },
              ),
              const SizedBox(width: 12),
              SocialIcon(
                icon: Icons.train,
                onTap: () {
                  // handle Twitter link
                },
              ),
              const SizedBox(width: 12),
              SocialIcon(
                icon: Icons.bus_alert,
                onTap: () {
                  // handle IG link
                },
              ),
              const SizedBox(width: 12),
              SocialIcon(
                icon: Icons.video_library, //  for YouTube
                onTap: () {
                  // handle YouTube link
                },
              ),
              const SizedBox(width: 12),
              SocialIcon(
                icon: Icons.business, //  for LinkedIn
                onTap: () {
                  // handle LinkedIn link
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Simple clickable text link for the footer
class FooterLink extends StatelessWidget {
  final String text;
  const FooterLink({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          // TODO: open link or navigate
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

// Icon + label row for contact info
class ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const ContactRow({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color.fromARGB(255, 231, 157, 237)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}

// Circular social icon
class SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const SocialIcon({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(icon,
            size: 24, color: const Color.fromARGB(255, 190, 172, 235)),
      ),
    );
  }
}
