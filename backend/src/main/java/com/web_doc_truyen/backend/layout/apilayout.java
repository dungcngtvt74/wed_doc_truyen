package com.web_doc_truyen.backend.layout;

import com.web_doc_truyen.backend.hoso_user.hoso_user;
import com.web_doc_truyen.backend.hoso_user.interhoso_user;
import com.web_doc_truyen.backend.nguoidung.internguoidung;
import com.web_doc_truyen.backend.nguoidung.nguoidung;
import com.web_doc_truyen.backend.theloai.intertheloai;
import com.web_doc_truyen.backend.theloai.theloai;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/auth/header")
public class apilayout {


    @Autowired
    private intertheloai ittheloai;

    @Autowired
    private internguoidung itinternguoidung;

    @Autowired
    private interhoso_user ithoso_user;

    @GetMapping("/init")
    public ResponseEntity<?> init(@RequestParam(value = "id_nguoidung", required = false) Integer idnguoidung) {
        Map<String, Object> response = new HashMap<>();

        // ĐÃ SỬA: build thủ công đúng field "id" + "ten_theloai" từ bảng theloai thật
        List<Map<String, Object>> danhSachTheLoai = new ArrayList<>();
        for (theloai tl : ittheloai.findAll()) {
            Map<String, Object> item = new HashMap<>();
            item.put("id", tl.getId());
            item.put("ten_theloai", tl.getTentheloai());
            danhSachTheLoai.add(item);
        }
        response.put("danhSachTheLoai", danhSachTheLoai);

        Map<String, Object> m2 = new HashMap<>();
        if (idnguoidung != null) {
            Optional<nguoidung> nd = itinternguoidung.findById(idnguoidung);
            if (nd.isPresent()) {
                m2.put("isLoggedIn", true);
                m2.put("id", nd.get().getId());
                m2.put("vaiTro", nd.get().getVaitro());

                String hienthiten = nd.get().getTendangnhap();
                String avatarUrl = null;

                Optional<hoso_user> hs = ithoso_user.findById(idnguoidung);
                if (hs.isPresent()) {
                    if (hs.get().getHo_ten() != null && !hs.get().getHo_ten().trim().isEmpty()) {
                        hienthiten = hs.get().getHo_ten();
                    }
                    avatarUrl = resolveAvatarUrl(hs.get().getAvatar());
                }

                m2.put("displayName", hienthiten);
                m2.put("avatar", avatarUrl);
            } else {
                m2.put("isLoggedIn", false);
            }
        } else {
            m2.put("isLoggedIn", false);
        }

        response.put("user", m2);
        return ResponseEntity.ok().body(response);
    }

    private String resolveAvatarUrl(String rawFileName) {
        if (rawFileName == null || rawFileName.trim().isEmpty()) {
            return null;
        }
        String fileName = rawFileName.trim();
        if (fileName.startsWith("http://") || fileName.startsWith("https://")) {
            return fileName;
        }
        return "/web_doc_truyen/backend/uploads/avatar/" + fileName;
    }
}