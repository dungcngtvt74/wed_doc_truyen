package com.web_doc_truyen.backend.theo_doi_truyen;

import com.web_doc_truyen.backend.truyen.truyen;
import com.web_doc_truyen.backend.truyen.intertruyen;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.*;


@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/theo_doi_truyen")
public class apitheo_doi_truyen {
    @Autowired
    private intertheo_doi_truyen ittd;

    @Autowired
    private intertruyen ittr;


    @PostMapping("/get_by_user")
    public ResponseEntity<?> getByUser(@RequestBody Map<String, Integer> payload) {
        Map<String, Object> response = new HashMap<>();
        Integer idNguoiDung = payload.get("id_nguoidung");

        if (idNguoiDung == null) {
            response.put("success", false);
            response.put("message", "Thiếu ID người dùng");
            return ResponseEntity.badRequest().body(response);
        }

        List<theo_doi_truyen> danhSach = ittd.findByIdnguoidung(idNguoiDung);
        List<Map<String, Object>> result = new ArrayList<>();

        for (theo_doi_truyen td : danhSach) {
            Optional<truyen> t = ittr.findById(td.getIdtruyen());
            if (t.isPresent()) {
                Map<String, Object> truyenData = new HashMap<>();
                truyenData.put("id", t.get().getId());
                truyenData.put("ten_truyen", t.get().getTentruyen());
                truyenData.put("anh_bia", t.get().getAnhbia());
                truyenData.put("luot_xem", t.get().getLuotxem());
                result.add(truyenData);
            }
        }

        response.put("success", true);
        response.put("data", result);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/add")
    public ResponseEntity<?> addTheoDoi(@RequestBody Map<String, Integer> payload) {
        Map<String, Object> response = new HashMap<>();
        Integer idNguoiDung = payload.get("id_nguoidung");
        Integer idTruyen = payload.get("id_truyen");

        if (ittd.findByIdnguoidungAndIdtruyen(idNguoiDung, idTruyen).isPresent()) {
            response.put("success", false);
            response.put("message", "Bạn đã theo dõi truyện này rồi");
            return ResponseEntity.badRequest().body(response);
        }


        theo_doi_truyen td = new theo_doi_truyen();
        td.setIdnguoidung(idNguoiDung);
        td.setIdtruyen(idTruyen);
        ittd.save(td);

        response.put("success", true);
        response.put("message", "Đã thêm vào danh sách theo dõi");
        return ResponseEntity.ok(response);
    }


    @PostMapping("/remove")
    public ResponseEntity<?> removeTheoDoi(@RequestBody Map<String, Integer> payload) {
        Map<String, Object> response = new HashMap<>();
        Integer idNguoiDung = payload.get("id_nguoidung");
        Integer idTruyen = payload.get("id_truyen");

        ittd.deleteByIdnguoidungAndIdtruyen(idNguoiDung, idTruyen);

        response.put("success", true);
        response.put("message", "Đã bỏ theo dõi thành công");
        return ResponseEntity.ok(response);
    }
}
