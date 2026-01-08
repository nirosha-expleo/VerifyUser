import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';

class DocumentViewerScreen extends StatefulWidget {
  const DocumentViewerScreen({super.key});

  @override
  State<DocumentViewerScreen> createState() => _DocumentViewerScreenState();
}

class _DocumentViewerScreenState extends State<DocumentViewerScreen> {
  int _currentScreenIndex = 0;
  
  final List<Map<String, dynamic>> screens = [
    {'path': '/screen1', 'title': 'Screen 1', 'description': 'Welcome Screen'},
    {'path': '/screen2', 'title': 'Screen 2', 'description': 'User Information'},
    {'path': '/screen3', 'title': 'Screen 3', 'description': 'Verification Process'},
    {'path': '/screen4', 'title': 'Screen 4', 'description': 'Details View'},
    {'path': '/screen5', 'title': 'Screen 5', 'description': 'Summary Screen'},
  ];

  void _navigateToScreen(int index) {
    setState(() {
      _currentScreenIndex = index;
    });
    context.go(screens[index]['path']);
  }

  void _navigatePrevious() {
    if (_currentScreenIndex > 0) {
      _navigateToScreen(_currentScreenIndex - 1);
    }
  }

  void _navigateNext() {
    if (_currentScreenIndex < screens.length - 1) {
      _navigateToScreen(_currentScreenIndex + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('VerifyUser'),
        leading: _currentScreenIndex > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _navigatePrevious,
              )
            : null,
      ),
      body: Row(
        children: [
          // Sidebar Navigation (hidden on mobile)
          if (!isMobile)
            Container(
              width: 250,
              color: AppColors.containerColor,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: AppColors.appHeader_bg,
                    child: const Text(
                      'Navigation',
                      style: TextStyle(
                        color: AppColors.whiteAppColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: screens.length,
                      itemBuilder: (context, index) {
                        final isSelected = index == _currentScreenIndex;
                        return ListTile(
                          selected: isSelected,
                          selectedTileColor: AppColors.adColorlight,
                          title: Text(
                            screens[index]['title'],
                            style: TextStyle(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected
                                  ? AppColors.appButtonColor
                                  : AppColors.appTitleBlack,
                            ),
                          ),
                          subtitle: Text(
                            screens[index]['description'],
                            style: const TextStyle(fontSize: 12),
                          ),
                          onTap: () => _navigateToScreen(index),
                          leading: CircleAvatar(
                            backgroundColor: isSelected
                                ? AppColors.appButtonColor
                                : AppColors.appCirclebackground,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.whiteAppColor
                                    : AppColors.appTitleBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          // Main Content Area
          Expanded(
            child: Container(
              color: AppColors.backgroundColor,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: ResponsiveHelper.getMobileMaxWidth(context),
                  ),
                  child: Container(
                    margin: ResponsiveHelper.getScreenPadding(context),
                    decoration: BoxDecoration(
                      color: AppColors.whiteAppColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.boxShadowColor,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.description,
                                  size: 80,
                                  color: AppColors.appButtonColor,
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  'Document Viewer',
                                  style: Theme.of(context).textTheme.displaySmall,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Navigate through screens like pages in a document',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 32),
                                Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  alignment: WrapAlignment.center,
                                  children: screens.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final screen = entry.value;
                                    return ElevatedButton(
                                      onPressed: () => _navigateToScreen(index),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: index == _currentScreenIndex
                                            ? AppColors.appButtonColor
                                            : AppColors.appCirclebackground,
                                        foregroundColor: index == _currentScreenIndex
                                            ? AppColors.whiteAppColor
                                            : AppColors.appTitleBlack,
                                      ),
                                      child: Text(screen['title']),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Navigation Footer
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.containerColor,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed: _currentScreenIndex > 0
                                    ? _navigatePrevious
                                    : null,
                                icon: const Icon(Icons.chevron_left),
                                label: const Text('Previous'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.appButtonColor,
                                  disabledBackgroundColor: AppColors.disableAppColor,
                                ),
                              ),
                              Text(
                                '${_currentScreenIndex + 1} / ${screens.length}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.appTitleBlack,
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: _currentScreenIndex < screens.length - 1
                                    ? _navigateNext
                                    : null,
                                icon: const Icon(Icons.chevron_right),
                                label: const Text('Next'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.appButtonColor,
                                  disabledBackgroundColor: AppColors.disableAppColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar for Mobile
      bottomNavigationBar: isMobile
          ? Container(
              height: 60,
              color: AppColors.appHeader_bg,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, color: AppColors.whiteAppColor),
                    onPressed: _currentScreenIndex > 0 ? _navigatePrevious : null,
                    disabledColor: AppColors.disableAppColor,
                  ),
                  Text(
                    '${_currentScreenIndex + 1} / ${screens.length}',
                    style: const TextStyle(
                      color: AppColors.whiteAppColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right, color: AppColors.whiteAppColor),
                    onPressed: _currentScreenIndex < screens.length - 1 ? _navigateNext : null,
                    disabledColor: AppColors.disableAppColor,
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

