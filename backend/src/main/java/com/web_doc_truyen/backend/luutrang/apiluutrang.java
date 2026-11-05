package com.web_doc_truyen.backend.luutrang;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/luutrang")
public class apiluutrang {

    @Autowired
    private interluutrang itlt;


    @PostMapping("/save")
    public ResponseEntity<?> saveProgress(
            @RequestParam("id_nguoidung") Integer idNguoiDung,
            @RequestParam("id_truyen") Integer idTruyen,
            @RequestParam("id_chuong") Integer idChuong,
            @RequestParam("so_trang") Integer soTrang) {

        Map<String, Object> m = new HashMap<>();
        try {

            luutrang.LuutrangId id = new luutrang.LuutrangId();
            id.setIdnguoidung(idNguoiDung);
            id.setIdtruyen(idTruyen);

            Optional<luutrang> opt = itlt.findById(id);
            luutrang lt;

            if (opt.isPresent()) {
                lt = opt.get();
            } else {
                lt = new luutrang();
                lt.setIdnguoidung(idNguoiDung);
                lt.setIdtruyen(idTruyen);
            }

            lt.setIdchuong(idChuong);
            lt.setSotrang(soTrang);
            lt.setNgaycapnhat(LocalDateTime.now());

            itlt.save(lt);

            m.put("success", true);
            m.put("message", "Đã lưu tiến độ đọc");
            return ResponseEntity.ok(m);
        } catch (Exception e) {
            e.printStackTrace();
            m.put("success", false);
            m.put("message", "Lỗi server: " + e.getMessage());
            return ResponseEntity.status(500).body(m);
        }
    }

    @GetMapping("/history")
    public ResponseEntity<?> getHistory(@RequestParam("id_nguoidung") Integer idNguoiDung) {
        Map<String, Object> m = new HashMap<>();
        try {
            m.put("success", true);
            m.put("data", itlt.getHistoryByUser(idNguoiDung));
            return ResponseEntity.ok(m);
        } catch (Exception e) {
            m.put("success", false);
            m.put("message", "Lỗi server: " + e.getMessage());
            return ResponseEntity.status(500).body(m);
        }
    }
}