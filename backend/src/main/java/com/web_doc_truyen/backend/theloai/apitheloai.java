package com.web_doc_truyen.backend.theloai;

import com.web_doc_truyen.backend.nguoidung.internguoidung;
import com.web_doc_truyen.backend.tacgia.intertacgia;
import com.web_doc_truyen.backend.tacgia.tacgia;
import com.web_doc_truyen.backend.truyen.truyen;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/theloai")
public class apitheloai {

    @Autowired
    private intertheloai ittl;

    @Autowired
    private com.web_doc_truyen.backend.truyen.intertruyen ittr;

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
            @RequestParam("ten_theloai") String tentheloai) {
        Map<String, Object> m = new HashMap<>();


        if (!isAdmin(idNguoiDung)) {
            m.put("success", false);
            m.put("message", "Bạn không có quyền thực hiện thao tác này!");
            return ResponseEntity.status(403).body(m);
        }

        try {
            if (ittl.findByTentheloai(tentheloai).isPresent()) {
                m.put("success", false);
                m.put("message", "Tên thể loại đã tồn tại");
                return ResponseEntity.badRequest().body(m);
            }
            theloai tl = new theloai();
            tl.setTentheloai(tentheloai);
            ittl.save(tl);

            m.put("success", true);
            m.put("message", "Thêm thể loại thành công");
            return ResponseEntity.ok(m);
        } catch (Exception e) {
            m.put("success", false);
            m.put("message", "Lỗi Server: " + e.getMessage());
            return ResponseEntity.status(500).body(m);
        }
    }

    @GetMapping("/get")
    public ResponseEntity<?> get(@RequestParam("id") Integer id) {
        Map<String, Object> m = new HashMap<>();
        Optional<theloai> tl = ittl.findById(id);
        if (tl.isPresent()) {
            Map<String, Object> data = new HashMap<>();
            data.put("id", tl.get().getId());
            data.put("ten_theloai", tl.get().getTentheloai());

            m.put("success", true);
            m.put("data", data);
            return ResponseEntity.ok(m);
        }
        m.put("success", false);
        m.put("message", "Không tìm thấy thể loại");
        return ResponseEntity.badRequest().body(m);
    }

    @PostMapping("/edit")
    public ResponseEntity<?> edit(
            @RequestParam(value = "id_nguoidung", required = false) Integer idNguoiDung,
            @RequestParam("id") Integer id,
            @RequestParam("ten_theloai") String tentheloai) {

        Map<String, Object> m = new HashMap<>();


        if (!isAdmin(idNguoiDung)) {
            m.put("success", false);
            m.put("message", "Bạn không có quyền thực hiện thao tác này!");
            return ResponseEntity.status(403).body(m);
        }

        Optional<theloai> tl = ittl.findById(id);
        if (tl.isPresent()) {
            theloai t = tl.get();
            t.setTentheloai(tentheloai);
            ittl.save(t);

            m.put("success", true);
            m.put("message", "Cập nhật thành công");
            return ResponseEntity.ok(m);
        }
        m.put("success", false);
        m.put("message", "Không tìm thấy thể loại");
        return ResponseEntity.badRequest().body(m);
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

        if (ittl.existsById(id)) {
            ittl.deleteById(id);
            m.put("success", true);
            m.put("message", "Xóa thành công");
            return ResponseEntity.ok(m);
        }
        m.put("success", false);
        m.put("message", "Không tìm thấy thể loại");
        return ResponseEntity.badRequest().body(m);
    }

    @GetMapping("/get_truyen")
    public ResponseEntity<?> getTruyen(@RequestParam("id") Integer id) {
        Map<String, Object> m = new HashMap<>();
        Optional<theloai> tl = ittl.findById(id);
        if (tl.isPresent()) {
            m.put("success", true);
            m.put("ten_theloai", tl.get().getTentheloai());

            List<truyen> tatCaTruyen = ittr.findAll();
            String idTheLoaiStr = String.valueOf(id);

            List<truyen> truyenCungTheLoai = tatCaTruyen.stream()
                    .filter(t -> t.getTheloaiids() != null && !t.getTheloaiids().isEmpty())
                    .filter(t -> Arrays.stream(t.getTheloaiids().split(","))
                            .map(String::trim)
                            .anyMatch(s -> s.equals(idTheLoaiStr)))
                    .collect(Collectors.toList());

            List<Map<String, Object>> truyenDTOs = new ArrayList<>();
            for (truyen t : truyenCungTheLoai) {
                Map<String, Object> dto = new HashMap<>();
                dto.put("id", t.getId());
                dto.put("ten_truyen", t.getTentruyen());
                dto.put("anh_bia", t.getAnhbia());
                dto.put("luot_xem", t.getLuotxem());

                String tenTacGia = "Đang cập nhật";
                String butDanh = "Đang cập nhật";
                if (t.getIdtacgia() != null) {
                    Optional<tacgia> tg = ittg.findById(t.getIdtacgia());
                    if (tg.isPresent()) {
                        tenTacGia = tg.get().getTenTacGia();
                        butDanh = tg.get().getButDanh() != null
                                ? tg.get().getButDanh()
                                : tg.get().getTenTacGia();
                    }
                }
                dto.put("ten_tacgia", tenTacGia);
                dto.put("but_danh", butDanh);

                truyenDTOs.add(dto);
            }

            m.put("total", truyenDTOs.size());
            m.put("truyens", truyenDTOs);
            return ResponseEntity.ok(m);
        }
        m.put("success", false);
        m.put("message", "Không tìm thấy thể loại");
        return ResponseEntity.badRequest().body(m);
    }

    @GetMapping("/list")
    public ResponseEntity<?> getList() {
        Map<String, Object> m = new HashMap<>();
        try {
            m.put("success", true);
            m.put("data", ittl.findAll());
            return ResponseEntity.ok(m);
        } catch (Exception e) {
            m.put("success", false);
            m.put("message", "Lỗi server: " + e.getMessage());
            return ResponseEntity.status(500).body(m);
        }
    }
}