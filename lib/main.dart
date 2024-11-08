import 'dart:async'; // Import for Timer
import 'dart:math'; // Import for random number generation
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Welcome to Green Duck 🦆'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Screen1(),
    const Screen2(),
    const Screen3(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[300],
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Center(
            child: _screens[_currentIndex], // Display the selected screen
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Urban Impact',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.lightGreen[800],
        backgroundColor: Colors.lightGreen[300],
      ),
    );
  }
}

// Moving Banner Widget
class MovingBanner extends StatefulWidget {
  const MovingBanner({Key? key}) : super(key: key);

  @override
  _MovingBannerState createState() => _MovingBannerState();
}

class _MovingBannerState extends State<MovingBanner> {
  double _bannerPosition = -200; // Start off-screen
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _bannerPosition += 20; // Move the banner
        if (_bannerPosition > MediaQuery.of(context).size.width) {
          _bannerPosition = -200; // Reset position to start again
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _bannerPosition,
      top: 100, // Adjust this value to position the banner vertically
      child: Container(
        color: Colors.lightGreen[300],
        padding: const EdgeInsets.all(8.0),
        child: const Text(
          '🌍 Join us in making Kaohsiung Greener! 🌱\n because a green K is a clean K!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}



// Sample screens for demonstration
class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulate the average duck score for the week
    int averageDuckScore = _generateAverageDuckScore();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Positioned.fill(
                  child: _buildBanner(), // Your banner widget here
                ),
                Image.asset(
                  'assets/greenDuck.webp',
                  width: 400,
                  height: 400,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Let's Play for a Greener Kaohsiung,\nbecause a green K is a clean K!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 10, 117, 66)),
            ),
            const SizedBox(height: 40),
            // Row to contain both cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: _buildCard2(
                    context,
                    title: 'Average Duck Score',
                    icon: Icons.score,
                    weekly_average: averageDuckScore,
                    monthly_average: averageDuckScore - 20,
                    yearly_average: averageDuckScore - 40,
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: _buildBadgeCard(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildDailyQuestsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      color: Colors.black,
      height: 50, // Set the height of your banner
      child: Center(
        child: const Text(
          'Test Banner HERE!',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  int _generateAverageDuckScore() {
    // Simulating an average duck score for the last week
    Random random = Random();
    return random.nextInt(500) + 1000; // Random average score between 1000 and 1500
  }

  Widget _buildCard2(BuildContext context, {
    required String title,
    required IconData icon,
    required int weekly_average,
    required int monthly_average,
    required int yearly_average,
  }) {
    return Card(
      color: Colors.lightGreen[100],
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row for the average score title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Icon(icon, size: 40, color: Colors.green), // Display the relevant icon
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Averages:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildAverage(assetPath: 'assets/weekly.png', title: 'Weekly', value: '$weekly_average'),
                _buildAverage(assetPath: 'assets/monthly.png', title: 'Monthly', value: '$monthly_average'),
                _buildAverage(assetPath: 'assets/yearly.png', title: 'Yearly', value: '$yearly_average'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAverage({required String assetPath, required String title, required String value}) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 32, color: Colors.green)), // Use the asset image
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildBadgeCard(BuildContext context) {
    return Card(
      color: Colors.lightGreen[100],
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row for the highest badge title and name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Highest Badge:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Text(
                  'Ultra Green Duck Badge',
                  style: TextStyle(fontSize: 24, color: Colors.green),
                ),
                const Icon(
                  Icons.badge,
                  size: 40,
                  color: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Achievements:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildAchievement(icon: Icons.star, title: 'Ultra Green Duck'),
                _buildAchievement(icon: Icons.rocket, title: 'Take over 100 Players'),
                _buildAchievement(icon: Icons.bike_scooter, title: 'Whole Week Biking'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievement({required IconData icon, required String title}) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.green),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildDailyQuestsCard() {
    return Card(
      color: Colors.lightGreen[100],
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daily Quests',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Icon(
                  Icons.question_mark_sharp,
                  size: 40,
                  color: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 10),
            // List of daily quests
            _buildQuestItem('Help an Elderly across the Street', 50),
            _buildQuestItem('Ride 5 KM on a YouBike', 100),
            _buildQuestItem('Borrow your Vehicle to your Neighbor', 150),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestItem(String title, int points) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          Text('+${points.toString()} Points', style: const TextStyle(color: Colors.green)),
        ],
      ),
    );
  }
}


class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  String _selectedScope = 'Family';
  String _selectedTime = 'Daily';
  String _selectedTeam = 'Individual'; // Default value for the team selection
  List<Map<String, dynamic>> _data = [];

  final List<String> _scopes = ['Family', 'Friends', 'Company', 'Kaohsiung City', 'Interstellar'];
  final List<String> _timeFrames = ['Daily', 'Monthly', 'Yearly'];
  final List<String> _teams = ['Individual', 'Family', 'Company', 'City', 'Country', 'World'];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    setState(() {
      _data = _generateFakeData(_selectedScope, _selectedTime, _selectedTeam);
      // Sort data by Duck Score
      _data.sort((a, b) => int.parse(b['Duck Score']).compareTo(int.parse(a['Duck Score'])));
      // Reassign ranks based on the sorted order
      for (int index = 0; index < _data.length; index++) {
        _data[index]['Rank'] = index + 1; // Update rank to match sorted position
      }
    });
  }

  List<Map<String, dynamic>> _generateFakeData(String scope, String timeFrame, String team) {
    Random random = Random();
    return List.generate(4, (index) {
      int score = random.nextInt(1001) + 1000; // Random score between 1000 and 2000
      return {
        'Rank': index + 1, // This will be updated after sorting
        'Alias': '${team} Player ${index + 1}',
        'Duck Score': score.toString(),
        'Trend': index % 2 == 0 ? 'Up' : 'Down',
        'Color': _getColorFromScore(score),
      };
    });
  }

  Color _getColorFromScore(int score) {
    int red = ((2000 - score) / 1000 * 255).toInt(); // Red decreases as score increases
    int green = ((score - 1000) / 1000 * 255).toInt(); // Green increases as score increases
    return Color.fromARGB(255, red.clamp(0, 255), green.clamp(0, 255), 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Card for dropdowns
        const Padding(
          padding: EdgeInsets.only(top: 16.0, bottom: 16.0), // Padding below the title
        ),
        Card(
          color: Colors.lightGreen[100], // Light green background for the card
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Padding around the dropdowns
            child: Column(
              children: [
                // Title for the dropdowns
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0), // Padding below the title
                  child: Text(
                    'Choose your Fight 🎮🕹️🎰...',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                // Row for dropdowns
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust space evenly
                  children: [
                    // Label and Dropdown for Scope
                    Column(
                      children: [
                        const Text('Scope 🔎', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        DropdownButton<String>(
                          value: _selectedScope,
                          items: _scopes.map((String scope) {
                            return DropdownMenuItem<String>(
                              value: scope,
                              child: Text(scope),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedScope = newValue!;
                              _fetchData(); // Fetch new data based on the selected scope
                            });
                          },
                        ),
                      ],
                    ),
                    // Label and Dropdown for Time Frame
                    Column(
                      children: [
                        const Text('Time 🕗', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        DropdownButton<String>(
                          value: _selectedTime,
                          items: _timeFrames.map((String timeFrame) {
                            return DropdownMenuItem<String>(
                              value: timeFrame,
                              child: Text(timeFrame),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedTime = newValue!;
                              _fetchData(); // Fetch new data based on the selected time frame
                            });
                          },
                        ),
                      ],
                    ),
                    // Label and Dropdown for Team
                    Column(
                      children: [
                        const Text('Team 👯‍♀️', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        DropdownButton<String>(
                          value: _selectedTeam,
                          items: _teams.map((String team) {
                            return DropdownMenuItem<String>(
                              value: team,
                              child: Text(team),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedTeam = newValue!;
                              _fetchData(); // Fetch new data based on the selected team
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20), // Space before the title
        // Title for the leaderboard
        Center(
          child: Text(
            '${_selectedTime} ${_selectedScope} Leaderboard', // Include the selected scope in the title
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        const SizedBox(height: 20), // Space before the data table
        // DataTable
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(label: Text('Rank')),
                DataColumn(label: Text('Alias')),
                DataColumn(label: Text('Duck Score')),
                DataColumn(label: Text('Trend')),
              ],
              rows: _data.map((data) {
                return DataRow(cells: <DataCell>[
                  DataCell(Text(data['Rank'].toString())),
                  DataCell(Text(data['Alias'])),
                  DataCell(
                    Row(
                      children: [
                        Image.asset(
                          'assets/duck.png', // Load the duck image from assets
                          width: 20,
                          height: 20,
                          color: data['Color'], // Change the color based on score
                        ),
                        const SizedBox(width: 4),
                        Text(
                          data['Duck Score'],
                          style: TextStyle(color: data['Color']),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text(data['Trend'])),
                ]);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulate fetching data for passengers
    final passengersData = _generatePassengersData();
    final youBikeData = _generateYouBikeData();
    final co2Data = _generateCO2Data();
    final walkedKmData = _generateWalkedKmData();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: Colors.lightGreen[100], // Light green background for the card
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding inside the card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust space evenly
                children: [
                  const Text(
                    'Impact on the City',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Icon(
                    Icons.location_city,
                    size: 40,
                    color: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 20), // Space between title and content
              
              // Card for Bus Passengers
              _buildCard(
                context,
                title: 'Total Number of Passengers in Buses',
                icon: Icons.directions_bus,
                today: passengersData['today'] ?? 0, // Use 0 as default
                yesterday: passengersData['yesterday'] ?? 0, // Use 0 as default
                lastWeek: passengersData['lastWeek'] ?? 0, // Use 0 as default
              ),
              
              // Card for YouBike Trips
              _buildCard(
                context,
                title: 'Total YouBike Trips per Day',
                icon: Icons.bike_scooter,
                today: youBikeData['today'] ?? 0, // Use 0 as default
                yesterday: youBikeData['yesterday'] ?? 0, // Use 0 as default
                lastWeek: youBikeData['lastWeek'] ?? 0, // Use 0 as default
              ),
              
              // Card for CO2 Emissions
              _buildCard(
                context,
                title: 'Total Estimated CO2 Emissions (kg)',
                icon: Icons.cloud_queue,
                today: co2Data['today'] ?? 0, // Use 0 as default
                yesterday: co2Data['yesterday'] ?? 0, // Use 0 as default
                lastWeek: co2Data['lastWeek'] ?? 0, // Use 0 as default
              ),
              
              // Card for Walked KM
              _buildCard(
                context,
                title: 'Total Walked KM in the City',
                icon: Icons.directions_walk,
                today: walkedKmData['today'] ?? 0, // Use 0 as default
                yesterday: walkedKmData['yesterday'] ?? 0, // Use 0 as default
                lastWeek: walkedKmData['lastWeek'] ?? 0, // Use 0 as default
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, int> _generatePassengersData() {
    // Simulating API response with random passenger counts
    Random random = Random();
    return {
      'today': random.nextInt(500) + 300, // Random count between 300 and 800
      'yesterday': random.nextInt(500) + 300, // Random count between 300 and 800
      'lastWeek': random.nextInt(500) + 300, // Random count between 300 and 800
    };
  }

  Map<String, int> _generateYouBikeData() {
    // Simulating API response with random YouBike trip counts
    Random random = Random();
    return {
      'today': random.nextInt(100) + 50, // Random count between 50 and 150
      'yesterday': random.nextInt(100) + 50, // Random count between 50 and 150
      'lastWeek': random.nextInt(100) + 50, // Random count between 50 and 150
    };
  }

  Map<String, int> _generateCO2Data() {
    // Simulating API response with random CO2 emissions
    Random random = Random();
    return {
      'today': random.nextInt(100) + 20, // Random count between 20 and 120 kg
      'yesterday': random.nextInt(100) + 20, // Random count between 20 and 120 kg
      'lastWeek': random.nextInt(100) + 20, // Random count between 20 and 120 kg
    };
  }

  Map<String, int> _generateWalkedKmData() {
    // Simulating API response with random walked KM
    Random random = Random();
    return {
      'today': random.nextInt(10) + 1, // Random count between 1 and 10 km
      'yesterday': random.nextInt(10) + 1, // Random count between 1 and 10 km
      'lastWeek': random.nextInt(10) + 1, // Random count between 1 and 10 km
    };
  }

  Widget _buildCard(BuildContext context, {
    required String title,
    required IconData icon,
    required int today,
    required int yesterday,
    required int lastWeek,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40), // Display the relevant icon
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text('Today: $today'),
                  Text('Yesterday: $yesterday'),
                  Text('Same Day Last Week: $lastWeek'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
