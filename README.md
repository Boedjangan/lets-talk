# Boedjangan
Membantu pasangan menumbuhkan 

## Workflows

### Git Branching
- Silahkan melakukan pull terlebih dahulu di branch main agar mendapatkan versi terbaru
> git pull
- Sebelum mengerjakan tiket(task di jira) **harus** membuat branch baru sesuai kode tiket
- Contoh mengerjakan *on-boarding* dengan kode tiket **BOED-12**
- Maka buat branch baru sesuai kode tiket dengan cara 
> git checkout -b **BOED-12/on-boarding**
- Untuk memastikan sudah pindah branch bisa dengan cara 
> git branch
- Pastikan asterisk(\*) berada di branch yg dituju sebelum mulai mengerjakan development

### Git Commit
Berikut adalah format pesan commit:
> <type>: <description>

- Sebelum melakukan commit tentukan dahulu jenis commitnya
- Jika melakukan perbaikan maka jenisnya adalah "fix"
- Sementara jika melakukan penambahan maka jenisnya adalah "feat"
- Lalu tinggal ditambahkan deskripsi apa yang telah dilakukan
- Sehingga jika melakukan penambahan fitur otentikasi bisa dilakukan dengan cara 
> git commit -m "feat: finish auth logic"
- Pastikan menggunakan kata kerja verb 1 untuk deskripsinya

### Git Push
- Setelah selesai commit bisa langsung melakukan push dengan cara
> git push
- Jika tiket sudah selesai dikerjakan bisa kembali ke branch main, sebelum branching lagi mengerjakan tiker lainnya  

## Code Convention

