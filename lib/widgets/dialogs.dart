import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String type;
  final String title;
  final String content;
  const CustomDialog({super.key, required this.type, required this.title, required this.content});

  Color getDialogColor(BuildContext context){
    switch(type){
      case 'error':
        return Theme.of(context).colorScheme.errorContainer;
      case 'success':
        return Theme.of(context).colorScheme.secondaryContainer;
      default:
        return Theme.of(context).colorScheme.surfaceVariant;
    }
  }
  

  Color getContentColor(BuildContext context){
    switch(type){
      case 'error':
        return Theme.of(context).colorScheme.onErrorContainer;
      case 'success':
        return Theme.of(context).colorScheme.onSecondaryContainer;
      default:
        return Theme.of(context).colorScheme.onSurfaceVariant;
    }
  }

   Icon getContentIcon(BuildContext context){
    switch(type){
      case 'error':
        return Icon(Icons.error, color: getContentColor(context), size: 32);
      case 'success':
        return Icon(Icons.check_circle_outline, color: getContentColor(context), size: 32);
      default:
        return Icon(Icons.info, color: getContentColor(context), size: 32);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: getDialogColor(context)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                getContentIcon(context),
                const SizedBox(height: 16,),
                Text(title, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: getContentColor(context))),
                const SizedBox(height: 16,),
                Text(content, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: getContentColor(context))),
                const SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('OK', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: getContentColor(context)),))
                  ],
                )
              ],
            ),
      ),
    );
  }
}
