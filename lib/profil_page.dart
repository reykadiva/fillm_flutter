import 'package:flutter/material.dart';
import 'package:halo_flutter/new_form.dart';

// ============================================================
//  PROFIL PAGE - Contoh StatefulWidget dalam Flutter
//  Konsep yang dipelajari:
//  1. StatefulWidget & State
//  2. Scaffold, AppBar, FloatingActionButton
//  3. Stack & Positioned
//  4. Column, Row, Container
//  5. Navigator & Routing
//  6. setState() untuk update UI
// ============================================================

// StatefulWidget digunakan karena halaman ini memiliki
//    data yang bisa berubah (tab yang aktif)
class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilPage();
}

class _ProfilPage extends State<ProfilPage> {
  //  Variabel state: menyimpan tab yang sedang aktif
  //    0 = About Me, 1 = Portfolio, 2 = Contact
  int _activePage = 0;

  //  Data profil dipisah agar mudah diubah
  final String _name = "Muhammad Reyka";
  final String _role = "Mahasiswa Informatika";
  final String _avatarAsset = "assets/keren.png";

  @override
  Widget build(BuildContext context) {
    //  MediaQuery digunakan untuk mendapatkan ukuran layar
    //    agar tampilan responsif di semua ukuran HP
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      //  backgroundColor mengatur warna latar belakang halaman
      backgroundColor: const Color(0xFFF5F7FA),

      //  FloatingActionButton: tombol bulat yang melayang di atas konten
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigator.push: berpindah ke halaman baru
          // MaterialPageRoute: animasi transisi standar Material Design
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewForm()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Tambah Data ditekan!")),
          );
        },
        backgroundColor: const Color(0xFF2563EB),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "Tambah",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      //  body: konten utama halaman
      body: SingleChildScrollView(
        //  SingleChildScrollView: agar halaman bisa di-scroll
        //    ketika konten melebihi tinggi layar
        child: Stack(
          //  Stack: menumpuk widget satu di atas yang lain
          //    Digunakan untuk membuat efek tombol tab
          //    yang "menempel" di antara header dan konten
          children: [
            Column(
              children: [
                _buildHeader(screenHeight, screenWidth),
                const SizedBox(height: 60),
                AnimatedSwitcher(
                  //  AnimatedSwitcher: memberi animasi saat konten berganti
                  duration: const Duration(milliseconds: 300),
                  child: _activePage == 0
                      ? _aboutPage()
                      : (_activePage == 1 ? _portoPage() : _contactPage()),
                ),

                const SizedBox(height: 80),
              ],
            ),

            Positioned(
              top: screenHeight * 0.29,
              left: 16,
              right: 16,
              child: _buildTabBar(),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  //  WIDGET HELPER: Header Profil
  // ============================================================
  Widget _buildHeader(double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.33,
      width: screenWidth,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1D4ED8), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        //  borderRadius hanya di sudut bawah (efek melengkung)
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //  CircleAvatar: menampilkan foto profil berbentuk lingkaran
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            //  Gunakan backgroundImage untuk foto dari assets
            backgroundImage: AssetImage(_avatarAsset),
            // Jika gambar tidak ada, tampilkan icon default:
            child: null,
            // child: Icon(Icons.person, size: 50, color: Color(0xFF2563EB)),
          ),

          const SizedBox(height: 12),

          //  Text widget dengan style kustom
          Text(
            _name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),

          const SizedBox(height: 4),

          //  Chip: label kecil untuk menampilkan role/jabatan
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _role,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  //  WIDGET HELPER: Tab Bar (tombol navigasi)
  // ============================================================
  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        //  boxShadow: efek bayangan di bawah Container
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          //  Expanded: membuat setiap tombol mengisi ruang yang sama
          Expanded(child: _tabButton("About Me", 0, Icons.person_outline)),
          Expanded(child: _tabButton("Porto", 1, Icons.work_outline)),
          Expanded(child: _tabButton("Contact", 2, Icons.mail_outline)),
        ],
      ),
    );
  }

  // ============================================================
  //  WIDGET HELPER: Tombol Tab Individual
  // ============================================================
  Widget _tabButton(String label, int index, IconData icon) {
    //  Cek apakah tab ini sedang aktif
    final bool isActive = _activePage == index;

    return GestureDetector(
      //  GestureDetector: mendeteksi gesture (tap, swipe, dll)
      onTap: () {
        //  setState(): memberitahu Flutter bahwa ada data yang berubah
        //    Flutter akan me-rebuild widget setelah setState dipanggil
        setState(() {
          _activePage = index;
        });
      },
      child: AnimatedContainer(
        //  AnimatedContainer: Container dengan animasi otomatis
        //    saat propertinya berubah
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          //  Warna berubah berdasarkan status aktif/tidak
          color: isActive ? const Color(0xFF2563EB) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive ? Colors.white : Colors.grey,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  //  KONTEN TAB 1: About Me
  // ============================================================
  Widget _aboutPage() {
    //  Key digunakan oleh AnimatedSwitcher untuk membedakan widget
    return Container(
      key: const ValueKey("about"),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("Tentang Saya"),

          //  Card: Container dengan bayangan dan sudut membulat bawaan
          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _infoRow(Icons.person, "Nama", "Rahmad Syalevi"),
                  const Divider(height: 20),
                  _infoRow(Icons.location_on, "Alamat", "Jl. Perjuangan No. 1"),
                  const Divider(height: 20),
                  _infoRow(Icons.school, "Jurusan", "Teknik Informatika"),
                  const Divider(height: 20),
                  _infoRow(Icons.cake, "Angkatan", "2022"),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),
          _sectionTitle("Keahlian"),

          //  Wrap: seperti Row, tapi otomatis pindah baris jika penuh
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _skillChip("Flutter"),
              _skillChip("Dart"),
              _skillChip("Python"),
              _skillChip("UI/UX"),
              _skillChip("Firebase"),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  //  KONTEN TAB 2: Portfolio
  // ============================================================
  Widget _portoPage() {
    return Container(
      key: const ValueKey("porto"),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("Portfolio"),
          _portoCard("Aplikasi Absensi", "Flutter + Firebase", Icons.check_circle_outline),
          const SizedBox(height: 12),
          _portoCard("Website Toko Online", "HTML, CSS, JS", Icons.shopping_cart_outlined),
          const SizedBox(height: 12),
          _portoCard("Analisis Data Nilai", "Python + Pandas", Icons.bar_chart),
        ],
      ),
    );
  }

  // ============================================================
  //  KONTEN TAB 3: Contact
  // ============================================================
  Widget _contactPage() {
    return Container(
      key: const ValueKey("contact"),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("Hubungi Saya"),
          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _infoRow(Icons.email, "Email", "syalevi@email.com"),
                  const Divider(height: 20),
                  _infoRow(Icons.phone, "WhatsApp", "+62 812 3456 7890"),
                  const Divider(height: 20),
                  _infoRow(Icons.code, "GitHub", "github.com/syalevi"),
                  const Divider(height: 20),
                  _infoRow(Icons.link, "LinkedIn", "linkedin.com/in/syalevi"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  //  WIDGET HELPER KECIL (reusable components)
  // ============================================================

  //  Widget judul section
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1E293B),
        ),
      ),
    );
  }

  //  Widget baris info (icon + label + value)
  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        //  Container dengan warna latar untuk icon
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: const Color(0xFF2563EB)),
        ),
        const SizedBox(width: 12),
        //  Expanded agar teks mengisi sisa ruang
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //  Widget chip untuk menampilkan keahlian
  Widget _skillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Text(
        skill,
        style: const TextStyle(
          fontSize: 13,
          color: Color(0xFF2563EB),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  //  Widget card untuk portfolio
  Widget _portoCard(String title, String tech, IconData icon) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        //  ListTile: widget praktis untuk baris dengan icon, judul, subtitle
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF2563EB)),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          tech,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      ),
    );
  }
}
