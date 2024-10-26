import 'package:flutter/material.dart';

class SettingsBoard extends StatelessWidget {
  const SettingsBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Change title'),
          centerTitle: true,
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.close),
          //     onPressed: () {},
          //   ),
          // ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'الإعدادات', icon: Icon(Icons.settings)),
              Tab(text: 'المستخدمين', icon: Icon(Icons.people)),
              Tab(text: 'الخصوصية', icon: Icon(Icons.visibility)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SettingsTab(),
            UsersTab(),
            PrivacyTab(),
          ],
        ),
      ),
    );
  }
}

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('أيقونة اللوحة', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          const Center(child: Text('👏', style: TextStyle(fontSize: 50))),
          const SizedBox(height: 16),
          const Text('اللغة', style: TextStyle(fontSize: 16)),
          DropdownButton<String>(
            isExpanded: true,
            value: 'الافتراضية',
            items: ['الافتراضية', 'العربية', 'الإنجليزية']
                .map((String value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
            onChanged: (String? newValue) {},
          ),
          const SizedBox(height: 16),
          const Text('الوصف', style: TextStyle(fontSize: 16)),
          const TextField(
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'أدخل وصف اللوحة',
            ),
          ),
          const SizedBox(height: 16),
          const Text('اللون', style: TextStyle(fontSize: 16)),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(backgroundColor: Colors.white),
              CircleAvatar(backgroundColor: Colors.orange),
              CircleAvatar(backgroundColor: Colors.red),
              CircleAvatar(backgroundColor: Colors.green),
              CircleAvatar(backgroundColor: Colors.blue),
              CircleAvatar(backgroundColor: Colors.black),
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomLeft,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(),
              child: const Text('حذف'),
            ),
          ),
        ],
      ),
    );
  }
}

class UsersTab extends StatelessWidget {
  const UsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: 'ابحث عن مستخدم',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text('اسم المستخدم $index'),
                    subtitle: Text('تفاصيل المستخدم $index'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PrivacyTab extends StatelessWidget {
  const PrivacyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('نوع اللوحة', style: TextStyle(fontSize: 16)),
          DropdownButton<String>(
            isExpanded: true,
            value: 'خاصة',
            items: ['خاصة', 'عامة']
                .map((String value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
            onChanged: (String? newValue) {},
          ),
          const SizedBox(height: 16),
          const Text('مستوى الخصوصية', style: TextStyle(fontSize: 16)),
          DropdownButton<String>(
            isExpanded: true,
            value: 'خاصة',
            items: ['خاصة', 'عامة']
                .map((String value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
            onChanged: (String? newValue) {},
          ),
        ],
      ),
    );
  }
}
