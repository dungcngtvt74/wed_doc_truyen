package com.web_doc_truyen.backend.hoso_user;

import com.web_doc_truyen.backend.nguoidung.internguoidung;
import com.web_doc_truyen.backend.nguoidung.nguoidung;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/auth")
public class apihoso_user {

    @Autowired
    private interhoso_user iths;

    @Autowired
    private internguoidung itng;

    @GetMapping("/hoso/get")
    public ResponseEntity<?> gethoso_user(@RequestParam(value = "id_nguoidung", required = false) Integer idnguoidung) {
        Map<String, Object> m1 = new HashMap<>();
        if (idnguoidung == null) {
            m1.put("success", false);
            m1.put("message", "Lỗi: Không tìm thấy ID người dùng!");
            return ResponseEntity.badRequest().body(m1);
        }

        Map<String, Object> m2 = new HashMap<>();
        Optional<nguoidung> opng = itng.findById(idnguoidung);
        if (!opng.isPresent()) {
            m1.put("success", false);
            m1.put("message", "Tài khoản không tồn tại trong hệ thống");
            return ResponseEntity.badRequest().body(m1);
        }

        m2.put("ten_dang_nhap", opng.get().getTendangnhap());
        m2.put("email", opng.get().getEmail());
        m2.put("vai_tro", opng.get().getVaitro());

        Optional<hoso_user> opng2 = iths.findById(idnguoidung);
        if (opng2.isPresent()) {
            m2.put("profile", opng2.get());
        } else {
            m2.put("profile", new hoso_user());
        }

        m1.put("success", true);
        m1.put("data", m2);
        return ResponseEntity.ok(m1);
    }

    @PostMapping("/hoso/update")
    public ResponseEntity<?> updateProfile(
            @RequestParam(value = "id_nguoidung", required = false) Integer iduser,
            @RequestParam(value = "ho_ten", required = false) String hoten,
            @RequestParam(value = "so_dien_thoai", required = false) String sodienthoai,
            @RequestParam(value = "gioi_tinh", required = false) String gioitinh,
            @RequestParam(value = "ngay_sinh", required = false) String ngaysinhstr,
            @RequestParam(value = "dia_chi", required = false) String diachi,
            @RequestParam(value = "avatar", required = false) MultipartFile avatarFile) {

        Map<String, Object> m = new HashMap<>();

        if (iduser == null) {
            m.put("success", false);
            m.put("message", "Lỗi: Không nhận được ID tài khoản từ giao diện. Hãy thử Đăng Xuất và Đăng Nhập lại!");
            return ResponseEntity.badRequest().body(m);
        }

        try {

            if (sodienthoai != null && iths.findBySodienthoaiAndIduserNot(sodienthoai, iduser).isPresent()) {
                m.put("success", false);
                m.put("message", "Số điện thoại này đã được sử dụng ở một tài khoản khác!");
                return ResponseEntity.status(409).body(m);
            }

            hoso_user hoSo = iths.findById(iduser).orElse(new hoso_user());
            hoSo.setIduser(iduser);
            hoSo.setHo_ten(hoten);
            hoSo.setSodienthoai(sodienthoai);
            hoSo.setGioitinh(gioitinh);

            if (ngaysinhstr != null && !ngaysinhstr.trim().isEmpty()) {
                hoSo.setNgaysinh(LocalDate.parse(ngaysinhstr));
            }
            hoSo.setDiachi(diachi);


            if (avatarFile != null && !avatarFile.isEmpty()) {
                String uploadDir = "C:/xampp/htdocs/web_doc_truyen/uploads/avatar/";
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();

                String originalName = avatarFile.getOriginalFilename();
                String extension = (originalName != null && originalName.contains("."))
                        ? originalName.substring(originalName.lastIndexOf('.'))
                        : "";
                String fileName = System.currentTimeMillis() + extension;

                Files.copy(avatarFile.getInputStream(), Paths.get(uploadDir + fileName));
                hoSo.setAvatar(fileName);
            }

            iths.save(hoSo);
            m.put("success", true);
            m.put("message", "Cập nhật thành công!");
            return ResponseEntity.ok(m);

        } catch (Exception e) {
            e.printStackTrace();
            m.put("success", false);
            m.put("message", "Lỗi mã Java: " + e.getMessage());
            return ResponseEntity.status(500).body(m);
        }
    }
}