# Submission Akhir: Ditonton — CI, BLoC, SSL Pinning & Firebase

## Deskripsi Proyek

Meningkatkan aplikasi **Ditonton** dari submission sebelumnya dengan menerapkan Continuous Integration, migrasi state management ke BLoC, SSL Pinning, dan integrasi Firebase Analytics & Crashlytics.

---

## Kriteria Wajib

### 1. Continuous Integration (CI)

- Menjalankan **pengujian aplikasi secara otomatis** — semua pengujian harus tetap terpenuhi dan mempertahankan fitur dari submission sebelumnya.
- CI dijalankan setiap ada **push kode terbaru** ke repository.
- Unggah kode ke **GitHub repository milik sendiri** (pastikan repository bersifat **public**) dan cantumkan tautannya sebagai catatan submission.
- Menampilkan **build status badge** pada berkas `README.md` repository GitHub.
  - Contoh dengan [Codemagic Status Badge](https://docs.codemagic.io/yaml-publishing/status-badges/)
- Melampirkan **screenshot salah satu build** dari CI service sebagai attachment file.
- Bebas menggunakan layanan CI apa pun (GitHub Actions, Codemagic, Bitrise, dll.).

---

### 2. Migrasi State Management ke BLoC

- Melakukan **migrasi state management** yang sebelumnya menggunakan **Provider** menjadi **BLoC**.

---

### 3. SSL Pinning

- Memasang **sertifikat SSL** pada aplikasi sebagai lapisan keamanan tambahan untuk mengakses data dari API.

---

### 4. Integrasi Firebase Analytics & Crashlytics

- Memastikan developer mendapat feedback dari pengguna, khususnya terkait **stabilitas** dan **laporan error**.
- Ditunjukkan dengan **screenshot** halaman Analytics dan Crashlytics dari Firebase Console.

---

## Kriteria Opsional

### Modularisasi

- Membagi aplikasi menjadi modul setidaknya untuk **dua fitur**: Movie & TV Series.

---

## Penilaian Submission

| Bintang | Keterangan |
|---------|------------|
| ⭐ | Semua ketentuan wajib terpenuhi, tetapi terdapat indikasi kecurangan/plagiarisme. |
| ⭐⭐ | Semua ketentuan wajib terpenuhi, tetapi terdapat kekurangan pada penulisan kode. |
| ⭐⭐⭐ | Semua ketentuan wajib terpenuhi, tetapi tidak ada improvisasi atau kriteria opsional yang dipenuhi. |
| ⭐⭐⭐⭐ | Semua ketentuan wajib terpenuhi dan menerapkan **minimal 1 saran** di bawah. |
| ⭐⭐⭐⭐⭐ | Semua ketentuan wajib terpenuhi dan menerapkan **seluruh saran** di bawah. |

> **Catatan:** Jika submission ditolak, tidak ada penilaian bintang.

### Saran untuk Nilai Tinggi

- Menyelesaikan kriteria opsional: **season & episode** (dari submission sebelumnya).
- Menambahkan **widget test** dan **integration test**.
- Menerapkan test coverage **> 95%**.
- Menuliskan kode dengan **bersih**, mudah dibaca, dan memenuhi **Dart code convention**.

---

## Alasan Submission Ditolak

- Kriteria wajib tidak terpenuhi.
- Ketentuan berkas submission tidak terpenuhi.
- Proyek yang dikirim tidak dapat dijalankan dengan baik.
- Aplikasi mengalami error.
- Menggunakan bahasa pemrograman atau teknologi **selain Flutter**.
- Melakukan kecurangan seperti **plagiarisme**.
- Tidak menggunakan **versi Flutter terbaru**.

---

## Ketentuan Berkas Submission

- Pastikan mencantumkan **tautan repository GitHub** pada student notes/catatan submission.
- Pastikan repository bersifat **public** (bukan private).
- Kirimkan dalam bentuk **folder proyek Ditonton** yang diarsipkan (**ZIP**).
- **Hapus folder `build`** sebelum mengkompresi menjadi ZIP.

```bash
# Hapus folder build
flutter clean

# Lalu kompresi menjadi ZIP
```

> Jika ukuran ZIP **> 25MB**: upload project ke **GitHub** terlebih dahulu, lalu unduh sebagai ZIP dari GitHub dan submit file ZIP tersebut.

---

## Checklist Sebelum Submit

### Continuous Integration
- [ ] CI berjalan otomatis setiap ada push ke repository.
- [ ] Semua pengujian dari submission sebelumnya tetap lulus (tidak ada yang breaking).
- [ ] Repository GitHub bersifat **public**.
- [ ] Tautan GitHub dicantumkan di student notes / catatan submission.
- [ ] **Build status badge** tampil di `README.md`.
- [ ] **Screenshot build CI** sudah disiapkan sebagai attachment.

### State Management & Arsitektur
- [ ] Migrasi dari **Provider ke BLoC** selesai dan berfungsi.
- [ ] *(Opsional)* Aplikasi dibagi menjadi modul Movie & TV Series.

### Keamanan
- [ ] **SSL Pinning** terpasang dan API request berjalan melalui sertifikat.

### Firebase
- [ ] **Firebase Analytics** terintegrasi dan berjalan.
- [ ] **Firebase Crashlytics** terintegrasi dan berjalan.
- [ ] **Screenshot** halaman Analytics dan Crashlytics sudah disiapkan sebagai attachment.

### Project & Kode
- [ ] Menggunakan Flutter versi terbaru (stable channel).
- [ ] Folder `build` sudah dihapus sebelum di-ZIP.
- [ ] Ukuran ZIP tidak melebihi **25MB**.
- [ ] Aplikasi tidak mengalami error saat dijalankan.
- [ ] Tidak ada Dart warning issue yang signifikan.
- [ ] Kode bersih — tidak ada comment, import, atau kode yang tidak digunakan.
