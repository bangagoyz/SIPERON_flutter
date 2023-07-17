// setting routing
// String baseUrl = 'http://10.0.2.2:5001'; //pake emu
// String baseUrl = 'http://localhost:5001';
String baseUrl = 'https://odd-jade-giraffe-ring.cyclic.app';

//auth
String registerUrl = '$baseUrl/user/register';
String loginUrl = '$baseUrl/user/login';

//CRUD Buku
String inputBuku = '$baseUrl/buku/create';
String editBuku = '$baseUrl/buku/edit';
String getAllBuku = '$baseUrl/buku/getall';
String hapusBuku = '$baseUrl/buku/hapus';
String getIdBuku = '$baseUrl/buku/getbyid';
String getBukuTersedia = '$baseUrl/buku/getbukutersedia';
String getBukuAdmin = '$baseUrl/buku/getbukuadmin';

//peminjaman
String createPeminjaman = '$baseUrl/peminjaman/create';
String getPeminjamanUser = '$baseUrl/peminjaman/getbyiduser';
String getLimitUser = '$baseUrl/peminjaman/getbyiduserlimit';
String getAllPeminjaman = '$baseUrl/peminjaman/getall';
String putPeminjaman = '$baseUrl/peminjaman/upload-bukti';
String getLimitAll = '$baseUrl/peminjaman/limitgetall';

//kunjungan
String postKunjungan = '$baseUrl/kunjungan/create';
String getAllKunjungan = '$baseUrl/kunjungan/getall';
String getUserIdKunjungan = '$baseUrl/kunjungan/getbyiduser';

//pengembalian
String getAllPengembalian = '$baseUrl/pengembalian/getall';
String createPengembalian = '$baseUrl/pengembalian/create';
