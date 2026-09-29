import 'package:material_ui/material_ui.dart';

class ValueSourceOptionCard extends StatelessWidget {
  const ValueSourceOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.expanded,
    required this.onTap,
    required this.child,
  });

  final IconData icon;
  final String title;
  final Widget subtitle;
  final bool expanded;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: AnimatedSize(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeInOut,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(icon),
            title: Text(title),
            subtitle: subtitle,
            trailing: AnimatedRotation(
              turns: expanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 180),
              child: const Icon(Icons.expand_more),
            ),
            onTap: onTap,
          ),
          if (expanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: child,
            ),
        ],
      ),
    ),
  );
}
