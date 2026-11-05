package com.web_doc_truyen.backend.chuong.ccchuong;


import jakarta.persistence.Id;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/auth/chuong")
public class apichuong {
    @Autowired
    private interchuong itc;

    @PostMapping("/add")
    public ResponseEntity<?> add(
            @RequestParam("id_truyen") Integer idtruyen,
            @RequestParam("so_chuong") Integer sochuong,
            @RequestParam("tieu_de") String tieude
    )
    {
        chuong c = new chuong();
        c.setIdtruyen(idtruyen);
        c.setSochuong(sochuong);
        c.setTieu_de(tieude);

        itc.save(c);

        Map<String,Object> m = new HashMap<>();
        m.put("Success",true);
        m.put("message","Them chuong thanh cong");
        return ResponseEntity.ok(m);

    }

    @GetMapping("/get")
    public ResponseEntity<?> getchuong
            (
                    @RequestParam("id")  Integer id
            )
    {
        Map<String,Object> m = new HashMap<>();
        Optional<chuong> c = itc.findById(id);


        if(c.isPresent())
        {
            m.put("Success",true);
            m.put("chuong",c.get());
            return ResponseEntity.ok(m);
        }
        m.put("Success",false);
        m.put("message","Khong tim thay");

        return ResponseEntity.badRequest().body(m);
    }

    @PostMapping("/edit")
    public ResponseEntity<?> edit
            (
                    @RequestParam("id")   Integer id,
                    @RequestParam("id_truyen") Integer idtruyen,
                    @RequestParam("so_chuong")Integer sotruyen,
                    @RequestParam("tieu_de")String tieude

            )
    {
        Map<String,Object> m = new HashMap<>();
        Optional<chuong> c = itc.findById(id);

        if(c.isPresent())
        {
            chuong cc = c.get();
            cc.setIdtruyen(idtruyen);
            cc.setSochuong(sotruyen);
            cc.setTieu_de(tieude);

            itc.save(cc);
            m.put("Success",true);
            m.put("chuong","Cap nhat thanh cong");

            return ResponseEntity.ok(m);
        }
        m.put("Success",false);
        m.put("message","Khong tim thay");
        return ResponseEntity.badRequest().body(m);
    }

    @PostMapping("/delete")
    public ResponseEntity<?> delete(@RequestParam("id") Integer id) {
        Map<String, Object> m = new HashMap<>();
        if (itc.existsById(id)) {
            itc.deleteById(id);
            m.put("Success", true);
            m.put("message", "Đã xóa chương");
            return ResponseEntity.ok(m);
        }
        m.put("Success", false);
        m.put("message", "Không tìm thấy chương để xóa");
        return ResponseEntity.badRequest().body(m);
    }

    @GetMapping("/get_all")
    public ResponseEntity<?> getAllChuongByTruyen(@RequestParam("id_truyen") Integer idtruyen) {
        Map<String, Object> m = new HashMap<>();
        m.put("success", true);
        m.put("data", itc.findByIdtruyenOrderBySochuongAsc(idtruyen));
        return ResponseEntity.ok(m);
    }

}