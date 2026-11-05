package com.web_doc_truyen.backend.tacgia;

import com.web_doc_truyen.backend.nguoidung.internguoidung;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/tacgia")
public class apitacgia {

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

    private Integer parseIdNguoidung(Object raw) {
        if (raw == null) return null;
        try {
            return Integer.parseInt(String.valueOf(raw).trim());
        } catch (Exception e) {
            return null;
        }
    }

    private ResponseEntity<?> forbidden() {
        Map<String, Object> response = new HashMap<>();
        response.put("success", false);
        response.put("message", "Bạn không có quyền thực hiện thao tác này!");
        return ResponseEntity.status(403).body(response);
    }

    @GetMapping("/list")
    public ResponseEntity<?> getListTacgia() {
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("data", ittg.findAll());
        return ResponseEntity.ok(response);
    }

    @PostMapping("/add")
    public ResponseEntity<?> addTacGia(@RequestBody Map<String, String> payload) {
        Map<String, Object> response = new HashMap<>();

        Integer idNguoiDung = parseIdNguoidung(payload.get("id_nguoidung"));
        if (!isAdmin(idNguoiDung)) return forbidden();

        try {
            String tenTacGia = payload.get("ten_tacgia");

            // ĐÃ THÊM: không cho tên rỗng
            if (tenTacGia == null || tenTacGia.trim().isEmpty()) {
                response.put("success", false);
                response.put("message", "Tên tác giả không được để trống!");
                return ResponseEntity.badRequest().body(response);
            }
            tenTacGia = tenTacGia.trim();

            if (ittg.findByTenTacGia(tenTacGia).isPresent()) {
                response.put("success", false);
                response.put("message", "Tên tác giả này đã tồn tại!");
                return ResponseEntity.status(409).body(response);
            }

            tacgia tg = new tacgia();
            tg.setTenTacGia(tenTacGia);
            tg.setButDanh(payload.get("but_danh"));
            tg.setGioiThieu(payload.get("gioi_thieu"));

            ittg.save(tg);
            response.put("success", true);
            response.put("message", "Thêm tác giả thành công");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Lỗi Server: " + e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }

    @PostMapping("/update")
    public ResponseEntity<?> updateTacGia(@RequestBody Map<String, Object> payload) {
        Map<String, Object> response = new HashMap<>();

        Integer idNguoiDung = parseIdNguoidung(payload.get("id_nguoidung"));
        if (!isAdmin(idNguoiDung)) return forbidden();

        try {
            Integer id = Integer.parseInt(String.valueOf(payload.get("id")));
            Optional<tacgia> opt = ittg.findById(id);

            if (!opt.isPresent()) {
                response.put("success", false);
                response.put("message", "Không tìm thấy tác giả để cập nhật");
                return ResponseEntity.badRequest().body(response);
            }

            // ĐÃ THÊM: kiểm tra tên rỗng
            Object tenRaw = payload.get("ten_tacgia");
            String tenTacGia = tenRaw == null ? "" : String.valueOf(tenRaw).trim();
            if (tenTacGia.isEmpty()) {
                response.put("success", false);
                response.put("message", "Tên tác giả không được để trống!");
                return ResponseEntity.badRequest().body(response);
            }

            // ĐÃ THÊM: kiểm tra trùng tên với tác giả KHÁC
            Optional<tacgia> trung = ittg.findByTenTacGia(tenTacGia);
            if (trung.isPresent() && !trung.get().getId().equals(id)) {
                response.put("success", false);
                response.put("message", "Tên tác giả này đã tồn tại!");
                return ResponseEntity.status(409).body(response);
            }

            tacgia tg = opt.get();
            tg.setTenTacGia(tenTacGia);
            tg.setButDanh(payload.get("but_danh") != null ? String.valueOf(payload.get("but_danh")) : "");
            tg.setGioiThieu(payload.get("gioi_thieu") != null ? String.valueOf(payload.get("gioi_thieu")) : "");

            ittg.save(tg);
            response.put("success", true);
            response.put("message", "Cập nhật tác giả thành công");
            return ResponseEntity.ok(response);
        } catch (NumberFormatException e) {
            response.put("success", false);
            response.put("message", "ID tác giả không hợp lệ!");
            return ResponseEntity.badRequest().body(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Lỗi Server: " + e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }

    @PostMapping("/delete")
    public ResponseEntity<?> deleteTacGia(@RequestBody Map<String, Object> payload) {
        Map<String, Object> response = new HashMap<>();

        Integer idNguoiDung = parseIdNguoidung(payload.get("id_nguoidung"));
        if (!isAdmin(idNguoiDung)) return forbidden();

        try {
            Integer id = Integer.parseInt(String.valueOf(payload.get("id")));
            if (ittg.existsById(id)) {
                ittg.deleteById(id);
                ittg.flush();
                response.put("success", true);
                response.put("message", "Xóa tác giả thành công");
                return ResponseEntity.ok(response);
            }
            response.put("success", false);
            response.put("message", "Không tìm thấy tác giả để xóa");
            return ResponseEntity.badRequest().body(response);

        } catch (NumberFormatException e) {
            response.put("success", false);
            response.put("message", "ID tác giả không hợp lệ!");
            return ResponseEntity.badRequest().body(response);
        } catch (DataIntegrityViolationException e) {

            response.put("success", false);
            response.put("message", "Không thể xóa: tác giả này đang có truyện liên kết. Hãy xóa hoặc chuyển truyện sang tác giả khác trước.");
            return ResponseEntity.status(409).body(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Lỗi Server: " + e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }
}