<?php
include('koneksi.php');
$method = $_SERVER["REQUEST_METHOD"];

if ($method === "GET") {
    if (isset($_GET['id'])) {
        $id = $_GET['id'];
        $sql = "SELECT * FROM transaksi WHERE id = $id";
        
        $result = $conn->query($sql);
        if ($result->num_rows > 0) {
            $transaksi = $result->fetch_assoc();
            echo json_encode($transaksi);
        } else {
            echo "Data transaksi dengan ID $id tidak ditemukan.";
        }
    } 
    else {
        $sql = "SELECT * FROM transaksi";
        $result = $conn->query($sql);
        
        if ($result->num_rows > 0) {
            $transaksi = array();
            while ($row = $result->fetch_assoc()) {
                $transaksi[] = $row;
            }
            echo json_encode($transaksi);
        } else {
            echo "Data transaksi kosong.";
        }
    }
}


if ($method === "POST") {
    // Menambahkan data transaksi
   $data = json_decode(file_get_contents("php://input"), true);
   $nama = $data["nama"];
   $catatan = $data["catatan"];
   $jumlah = $data["jumlah"];
   $sql = "INSERT INTO transaksi (nama, jumlah, catatan) VALUES ('$nama', '$jumlah', '$catatan')";
   if ($conn->query($sql) === TRUE) {
   $data['pesan'] = 'berhasil';
   //echo "Berhasil tambah data";
   } else {
   $data['pesan'] = "Error: " . $sql . "<br>" . $conn->error;
   }
   echo json_encode($data);
   } 

   if ($method === "PUT") {
    // Memperbarui data transaksi
        $data = json_decode(file_get_contents("php://input"), true);
        $id = $data["id"];
        $nama = $data["nama"];
        $jumlah = $data["jumlah"];
        $catatan = $data["catatan"];
        $sql = "UPDATE transaksi SET nama='$nama',jumlah = '$jumlah', catatan='$catatan' WHERE id=$id";
        if ($conn->query($sql) === TRUE) {
            $data['pesan'] = 'berhasil';
        } else {
         $data['pesan'] =  "Error: " . $sql . "<br>" . $conn->error;
        }
        echo json_encode($data);
   } 

   if ($method === "DELETE") {
    // Menghapus data transaksi
   $id = $_GET["id"];
   $sql = "DELETE FROM transaksi WHERE id=$id";
   if ($conn->query($sql) === TRUE) {
   $data['pesan'] = 'berhasil';
   } else {
   $data['pesan'] = "Error: " . $sql . "<br>" . $conn->error;
   }
   echo json_encode($data);
   }
   $conn->close();
?>