<?php
include('koneksi.php');
$method = $_SERVER["REQUEST_METHOD"];

if ($method === "GET") {
    if (isset($_GET['id'])) {
        $id = $_GET['id'];
        $sql = "SELECT * FROM mahasiswa WHERE id = $id";
        
        $result = $conn->query($sql);
        if ($result->num_rows > 0) {
            $mahasiswa = $result->fetch_assoc();
            echo json_encode($mahasiswa);
        } else {
            echo "Data mahasiswa dengan ID $id tidak ditemukan.";
        }
    } 
    else {
        $sql = "SELECT * FROM mahasiswa";
        $result = $conn->query($sql);
        
        if ($result->num_rows > 0) {
            $mahasiswa = array();
            while ($row = $result->fetch_assoc()) {
                $mahasiswa[] = $row;
            }
            echo json_encode($mahasiswa);
        } else {
            echo "Data mahasiswa kosong.";
        }
    }
}


if ($method === "POST") {
    // Menambahkan data mahasiswa
   $data = json_decode(file_get_contents("php://input"), true);
   $nama = $data["nama"];
   $jurusan = $data["jurusan"];
   $sql = "INSERT INTO mahasiswa (nama, jurusan) VALUES ('$nama', '$jurusan')";
   if ($conn->query($sql) === TRUE) {
   $data['pesan'] = 'berhasil';
   //echo "Berhasil tambah data";
   } else {
   $data['pesan'] = "Error: " . $sql . "<br>" . $conn->error;
   }
   echo json_encode($data);
   } 

   if ($method === "PUT") {
    // Memperbarui data mahasiswa
        $data = json_decode(file_get_contents("php://input"), true);
        $id = $data["id"];
        $nama = $data["nama"];
        $jurusan = $data["jurusan"];
        $sql = "UPDATE mahasiswa SET nama='$nama', jurusan='$jurusan' WHERE id=$id";
        if ($conn->query($sql) === TRUE) {
            $data['pesan'] = 'berhasil';
        } else {
         $data['pesan'] =  "Error: " . $sql . "<br>" . $conn->error;
        }
        echo json_encode($data);
   } 

   if ($method === "DELETE") {
    // Menghapus data mahasiswa
   $id = $_GET["id"];
   $sql = "DELETE FROM mahasiswa WHERE id=$id";
   if ($conn->query($sql) === TRUE) {
   $data['pesan'] = 'berhasil';
   } else {
   $data['pesan'] = "Error: " . $sql . "<br>" . $conn->error;
   }
   echo json_encode($data);
   }
   $conn->close();
?>