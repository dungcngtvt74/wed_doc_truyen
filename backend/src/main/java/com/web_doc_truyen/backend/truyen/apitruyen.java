package com.web_doc_truyen.backend.truyen;

import com.web_doc_truyen.backend.nguoidung.internguoidung;
import com.web_doc_truyen.backend.tacgia.intertacgia;
import com.web_doc_truyen.backend.tacgia.tacgia;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/truyen")
public class apitruyen {

    @Autowired
    private intertruyen ittr;

    @Autowired
    private intertacgia ittg;


    @Autowired
    private internguoidung itnguoidung;
    private boolean isAdmin(Integer idNguoidung) {
        if (idNguoidung == null) return false;
        return itnguoidung.findById(idNguoidung)
                .map(nd -> "admin".equalsIgnoreCase(nd.getVaitro()))
                .orElse(false);
    }

    @PostMapping("/add")
    public ResponseEntity<?> add(
            @RequestParam(value = "id_nguoidung", required = false) Integer idNguoiDung,
            @RequestParam(value = "id_tacgia", required = false) String idtacgiaStr,
            @RequestParam(value = "ten_truyen", required = false) String tentruyen,
            @RequestParam(value = "mo_ta", required = false) String mota,
            @RequestParam(value = "trang_thai", required = false) String trangthai,
            @RequestParam(value = "theloai_ids[]", required = false) List<String> theloaiIds,
            @RequestParam(value = "anh_bia", required = false) MultipartFile anhbia) {

        Map<String, Object> m = new HashMap<>();


        if (!isAdmin(idNguoiDung)) {
            m.put("success", false);
            m.put("message", "Bạn không có quyền thực hiện thao tác này!");
            return ResponseEntity.status(403).body(m);
        }

        if (idtacgiaStr == null || tentruyen == null || tentruyen.trim().isEmpty()) {
            m.put("success", false);
            m.put("message", "Lỗi: Vui lòng nhập đủ tên truyện và tác giả!");
            return ResponseEntity.badRequest().body(m);
        }

        try {
            truyen t = new truyen();
            t.setIdtacgia(Integer.parseInt(idtacgiaStr.trim()));
            t.setTentruyen(tentruyen);
            t.setMota(mota);
            t.setTrangthai(trangthai);

            if (theloaiIds != null && !theloaiIds.isEmpty()) {
                t.setTheloaiids(String.join(",", theloaiIds));
            }

            if (anhbia != null && !anhbia.isEmpty()) {
                String uploadDir = "C:/xampp/htdocs/web_doc_truyen/uploads/anhbia/";
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();
                String fileName = System.currentTimeMillis() + "_" + anhbia.getOriginalFilename();
                Files.copy(anhbia.getInputStream(), Paths.get(uploadDir + fileName));
                t.setAnhbia(fileName);
            }

            ittr.save(t);
            m.put("success", true);
            m.put("message", "Thêm truyện thành công!");
            return ResponseEntity.ok(m);
        } catch (Exception e) {
            m.put("success", false);
            m.put("message", "Lỗi Server: " + e.getMessage());
            return ResponseEntity.status(500).body(m);
        }
    }

    @GetMapping("/all")
    public ResponseEntity<?> all() {
        Map<String, Object> m = new HashMap<>();
        List<truyen> dsTruyen = ittr.findAll();

        List<Map<String, Object>> result = new ArrayList<>();
        for (truyen t : dsTruyen) {
            Map<String, Object> tData = new HashMap<>();
            tData.put("id", t.getId());
            tData.put("ten_truyen", t.getTentruyen());
            result.add(tData);
        }

        m.put("success", true);
        m.put("data", result);
        return ResponseEntity.ok(m);
    }

    @GetMapping("/get")
    public ResponseEntity<?> get(@RequestParam("id") Integer id) {
        Map<String, Object> m = new HashMap<>();
        Optional<truyen> opt = ittr.findById(id);

        if (opt.isPresent()) {
            truyen t = opt.get();
            Map<String, Object> tData = new HashMap<>();
            tData.put("id", t.getId());
            tData.put("ten_truyen", t.getTentruyen());
            tData.put("id_tacgia", t.getIdtacgia());
            tData.put("mo_ta", t.getMota());
            tData.put("trang_thai", t.getTrangthai());
            tData.put("anh_bia", t.getAnhbia());

            if (t.getTheloaiids() != null && !t.getTheloaiids().isEmpty()) {
                tData.put("theloai_ids", t.getTheloaiids().split(","));
            } else {
                tData.put("theloai_ids", new ArrayList<>());
            }

            Optional<tacgia> tg = ittg.findById(t.getIdtacgia());
            if (tg.isPresent()) {
                tData.put("ten_tacgia", tg.get().getTenTacGia());
                tData.put("but_danh", tg.get().getButDanh());
            }

            m.put("success", true);
            m.put("truyen", tData);
            return ResponseEntity.ok(m);
        }
        m.put("success", false);
        m.put("message", "Không tìm thấy truyện");
        return ResponseEntity.badRequest().body(m);
    }

    @GetMapping("/chitiet")
    public ResponseEntity<?> chitiet(@RequestParam("id") Integer id) {
        return get(id);
    }

    @PostMapping("/edit")
    public ResponseEntity<?> edit(
            @RequestParam(value = "id_nguoidung", required = false) Integer idNguoiDung,
            @RequestParam(value = "id", required = false) String idStr,
            @RequestParam(value = "id_tacgia", required = false) String idtacgiaStr,
            @RequestParam(value = "ten_truyen", required = false) String tentruyen,
            @RequestParam(value = "mo_ta", required = false) String mota,
            @RequestParam(value = "trang_thai", required = false) String trangthai,
            @RequestParam(value = "theloai_ids[]", required = false) List<String> theloaiIds,
            @RequestParam(value = "anh_bia", required = false) MultipartFile anhbia) {

        Map<String, Object> m = new HashMap<>();

        // chặn nếu không phải admin
        if (!isAdmin(idNguoiDung)) {
            m.put("success", false);
            m.put("message", "Bạn không có quyền thực hiện thao tác này!");
            return ResponseEntity.status(403).body(m);
        }

        if (idStr == null || idStr.trim().isEmpty()) {
            m.put("success", false);
            m.put("message", "Lỗi: Bị thiếu ID truyện!");
            return ResponseEntity.badRequest().body(m);
        }

        try {
            Integer id = Integer.parseInt(idStr.trim());
            Optional<truyen> opt = ittr.findById(id);

            if (opt.isPresent()) {
                truyen t = opt.get();
                if (idtacgiaStr != null && !idtacgiaStr.isEmpty()) t.setIdtacgia(Integer.parseInt(idtacgiaStr.trim()));
                if (tentruyen != null && !tentruyen.isEmpty()) t.setTentruyen(tentruyen);
                t.setMota(mota);
                t.setTrangthai(trangthai);

                if (theloaiIds != null && !theloaiIds.isEmpty()) {
                    t.setTheloaiids(String.join(",", theloaiIds));
                } else {
                    t.setTheloaiids("");
                }

                if (anhbia != null && !anhbia.isEmpty()) {
                    String uploadDir = "C:/xampp/htdocs/web_doc_truyen/uploads/anhbia/";
                    File dir = new File(uploadDir);
                    if (!dir.exists()) dir.mkdirs();
                    String fileName = System.currentTimeMillis() + "_" + anhbia.getOriginalFilename();
                    Files.copy(anhbia.getInputStream(), Paths.get(uploadDir + fileName));
                    t.setAnhbia(fileName);
                }

                ittr.save(t);
                m.put("success", true);
                m.put("message", "Cập nhật thành công!");
                return ResponseEntity.ok(m);
            }
            m.put("success", false);
            m.put("message", "Không tìm thấy truyện để sửa");
            return ResponseEntity.badRequest().body(m);

        } catch (Exception e) {
            e.printStackTrace();
            m.put("success", false);
            m.put("message", "Lỗi Server: " + e.getMessage());
            return ResponseEntity.status(500).body(m);
        }
    }

    @PostMapping("/delete")
    public ResponseEntity<?> delete(
            @RequestParam("id") Integer id,
            @RequestParam(value = "id_nguoidung", required = false) Integer idNguoiDung) {
        Map<String, Object> m = new HashMap<>();


        if (!isAdmin(idNguoiDung)) {
            m.put("success", false);
            m.put("message", "Bạn không có quyền thực hiện thao tác này!");
            return ResponseEntity.status(403).body(m);
        }

        Optional<truyen> opt = ittr.findById(id);
        if (opt.isEmpty()) {
            m.put("success", false);
            m.put("message", "Không tìm thấy truyện");
            return ResponseEntity.badRequest().body(m);
        }

        try {
            String anhBia = opt.get().getAnhbia();

            ittr.deleteById(id);
            ittr.flush();


            if (anhBia != null && !anhBia.isEmpty()) {
                try {
                    Files.deleteIfExists(Paths.get("C:/xampp/htdocs/web_doc_truyen/uploads/anhbia/" + anhBia));
                } catch (Exception ignore) {

                }
            }

            m.put("success", true);
            m.put("message", "Đã xóa truyện thành công");
            return ResponseEntity.ok(m);

        } catch (DataIntegrityViolationException e) {
            e.printStackTrace();
            m.put("success", false);
            m.put("message", "Không thể xóa: truyện còn chương hoặc dữ liệu liên quan (chưa bật ON DELETE CASCADE).");
            return ResponseEntity.status(409).body(m);
        } catch (Exception e) {
            e.printStackTrace();
            m.put("success", false);
            m.put("message", "Lỗi Server: " + e.getMessage());
            return ResponseEntity.status(500).body(m);
        }
    }

    @GetMapping("/search")
    public ResponseEntity<?> search(@RequestParam("keyword") String keyword) {
        Map<String, Object> m = new HashMap<>();
        List<truyen> dsTruyen = ittr.findByTentruyenContainingIgnoreCase(keyword);

        List<Map<String, Object>> result = new ArrayList<>();
        for (truyen t : dsTruyen) {
            Map<String, Object> tData = new HashMap<>();
            tData.put("id", t.getId());
            tData.put("ten_truyen", t.getTentruyen());
            tData.put("anh_bia", t.getAnhbia());
            tData.put("luot_xem", t.getLuotxem());

            Optional<tacgia> tg = ittg.findById(t.getIdtacgia());
            if (tg.isPresent()) {
                tData.put("tac_gia", tg.get().getTenTacGia());
            }
            result.add(tData);
        }

        m.put("success", true);
        m.put("stories", result);
        return ResponseEntity.ok(m);
    }

    @GetMapping("/trangchu")
    public ResponseEntity<?> getTruyenTrangChu() {
        Map<String, Object> m = new HashMap<>();
        try {
            List<truyen> dsTruyen = ittr.findAll();
            List<Map<String, Object>> result = new ArrayList<>();

            for (truyen t : dsTruyen) {
                Map<String, Object> tData = new HashMap<>();
                tData.put("id", t.getId());
                tData.put("ten_truyen", t.getTentruyen());
                tData.put("anh_bia", t.getAnhbia());
                tData.put("luot_xem", t.getLuotxem());

                Optional<com.web_doc_truyen.backend.tacgia.tacgia> tg = ittg.findById(t.getIdtacgia());
                if (tg.isPresent()) {
                    tData.put("tac_gia", tg.get().getTenTacGia());
                    tData.put("but_danh", tg.get().getButDanh());
                }
                result.add(tData);
            }

            m.put("success", true);
            m.put("data", result);
            return ResponseEntity.ok(m);
        } catch (Exception e) {
            m.put("success", false);
            m.put("message", "Lỗi server: " + e.getMessage());
            return ResponseEntity.status(500).body(m);
        }
    }
}