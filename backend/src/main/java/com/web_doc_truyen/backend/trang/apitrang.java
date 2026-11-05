package com.web_doc_truyen.backend.trang;

import com.web_doc_truyen.backend.chuong.ccchuong.chuong;
import com.web_doc_truyen.backend.chuong.ccchuong.interchuong;
import com.web_doc_truyen.backend.nguoidung.internguoidung;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/trang")
public class apitrang {

    @Autowired
    private intertrang ittr;

    @Autowired
    private interchuong itchuong;


    @Autowired
    private internguoidung itnguoidung;

    private boolean isAdmin(Integer idNguoidung) {
        if (idNguoidung == null) return false;
        return itnguoidung.findById(idNguoidung)
                .map(nd -> "admin".equalsIgnoreCase(nd.getVaitro()))
                .orElse(false);
    }

    @GetMapping("/get_all_chuong")
    public ResponseEntity<?> getallchuong() {
        Map<String, Object> m = new HashMap<>();
        m.put("success", true);
        m.put("data", itchuong.findAll());
        return ResponseEntity.ok(m);
    }

    @PostMapping("/add")
    public ResponseEntity<?> add(
            @RequestParam(value = "id_nguoidung", required = false) Integer idNguoiDung,
            @RequestParam(value = "id_chuong", required = false) String idchuongStr,
            @RequestParam(value = "so_trang", required = false) String sotrangStr,
            @RequestParam(value = "anh", required = false) MultipartFile anh) {

        Map<String, Object> m = new HashMap<>();


        if (!isAdmin(idNguoiDung)) {
            m.put("success", false);
            m.put("message", "Bạn không có quyền thực hiện thao tác này!");
            return ResponseEntity.status(403).body(m);
        }

        if (idchuongStr == null || idchuongStr.trim().isEmpty() || idchuongStr.equals("undefined")) {
            m.put("success", false);
            m.put("message", "Lỗi: Không nhận được ID Chương. Vui lòng F5 tải lại trang!");
            return ResponseEntity.badRequest().body(m);
        }
        if (sotrangStr == null || sotrangStr.trim().isEmpty()) {
            m.put("success", false);
            m.put("message", "Lỗi: Vui lòng nhập số trang hợp lệ!");
            return ResponseEntity.badRequest().body(m);
        }
        if (anh == null || anh.isEmpty()) {
            m.put("success", false);
            m.put("message", "Lỗi: Vui lòng chọn một file ảnh!");
            return ResponseEntity.badRequest().body(m);
        }

        try {
            Integer idchuong = Integer.parseInt(idchuongStr.trim());
            Integer sotrang = Integer.parseInt(sotrangStr.trim());

            trang t = new trang();
            t.setIdchuong(idchuong);
            t.setSotrang(sotrang);
            t.setLoai("image");

            String uploadDir = "C:/xampp/htdocs/web_doc_truyen/uploads/trang/";
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();
            String fileName = System.currentTimeMillis() + "_" + anh.getOriginalFilename();
            Files.copy(anh.getInputStream(), Paths.get(uploadDir + fileName));
            t.setAnh(fileName);

            ittr.save(t);
            m.put("success", true);
            m.put("message", "Thêm trang thành công!");
            return ResponseEntity.ok(m);

        } catch (NumberFormatException e) {
            m.put("success", false);
            m.put("message", "Lỗi: ID Chương hoặc Số trang gửi lên bị sai định dạng số!");
            return ResponseEntity.badRequest().body(m);
        } catch (Exception e) {
            e.printStackTrace();
            m.put("success", false);
            m.put("message", "Lỗi Server: " + e.getMessage());
            return ResponseEntity.status(500).body(m);
        }
    }

    @GetMapping("/get")
    public ResponseEntity<?> get(@RequestParam("id") Integer id) {
        Map<String, Object> m = new HashMap<>();
        Optional<trang> opt = ittr.findById(id);
        if (opt.isPresent()) {
            trang t = opt.get();
            m.put("success", true);

            Map<String, Object> tData = new HashMap<>();
            tData.put("id", t.getId());
            tData.put("id_chuong", t.getIdchuong());
            tData.put("so_trang", t.getSotrang());
            tData.put("loai", t.getLoai());
            tData.put("anh", t.getAnh());

            Optional<chuong> c = itchuong.findById(t.getIdchuong());
            if(c.isPresent()){
                tData.put("so_chuong", c.get().getSochuong());
                tData.put("tieu_de", c.get().getTieu_de());
            }

            m.put("trang", tData);
            return ResponseEntity.ok(m);
        }
        m.put("success", false);
        m.put("message", "Không tìm thấy trang");
        return ResponseEntity.badRequest().body(m);
    }

    @PostMapping("/edit")
    public ResponseEntity<?> edit(
            @RequestParam(value = "id_nguoidung", required = false) Integer idNguoiDung,
            @RequestParam(value = "id", required = false) String idStr,
            @RequestParam(value = "so_trang", required = false) String sotrangStr,
            @RequestParam(value = "anh", required = false) MultipartFile anh) {

        Map<String, Object> m = new HashMap<>();


        if (!isAdmin(idNguoiDung)) {
            m.put("success", false);
            m.put("message", "Bạn không có quyền thực hiện thao tác này!");
            return ResponseEntity.status(403).body(m);
        }

        if (idStr == null || sotrangStr == null || idStr.trim().isEmpty() || sotrangStr.trim().isEmpty()) {
            m.put("success", false);
            m.put("message", "Lỗi: Bị thiếu ID hoặc Số trang!");
            return ResponseEntity.badRequest().body(m);
        }

        try {
            Integer id = Integer.parseInt(idStr.trim());
            Integer sotrang = Integer.parseInt(sotrangStr.trim());

            Optional<trang> opt = ittr.findById(id);
            if (opt.isPresent()) {
                trang t = opt.get();
                t.setSotrang(sotrang);

                if (anh != null && !anh.isEmpty()) {
                    String uploadDir = "C:/xampp/htdocs/web_doc_truyen/uploads/trang/";
                    File dir = new File(uploadDir);
                    if (!dir.exists()) dir.mkdirs();
                    String fileName = System.currentTimeMillis() + "_" + anh.getOriginalFilename();
                    Files.copy(anh.getInputStream(), Paths.get(uploadDir + fileName));
                    t.setAnh(fileName);
                }

                ittr.save(t);
                m.put("success", true);
                m.put("message", "Cập nhật thành công!");
                return ResponseEntity.ok(m);
            }
            m.put("success", false);
            m.put("message", "Không tìm thấy trang để sửa");
            return ResponseEntity.badRequest().body(m);

        } catch (NumberFormatException e) {
            m.put("success", false);
            m.put("message", "Lỗi: Định dạng ID hoặc Số trang bị sai!");
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

        if (ittr.existsById(id)) {
            ittr.deleteById(id);
            m.put("success", true);
            m.put("message", "Đã xóa thành công");
            return ResponseEntity.ok(m);
        }
        m.put("success", false);
        m.put("message", "Không tìm thấy trang");
        return ResponseEntity.badRequest().body(m);
    }

    @GetMapping("/get_danhsach")
    public ResponseEntity<?> getdanhsach(@RequestParam("id_chuong") Integer idchuong) {
        Map<String, Object> m = new HashMap<>();
        Optional<chuong> c = itchuong.findById(idchuong);
        if (c.isPresent()) {
            m.put("success", true);
            m.put("chuong", c.get());
            m.put("trangs", ittr.findByIdchuongOrderBySotrangAsc(idchuong));
            return ResponseEntity.ok(m);
        }
        m.put("success", false);
        m.put("message", "Không tìm thấy chương");
        return ResponseEntity.badRequest().body(m);
    }

    @GetMapping("/get_chitiet")
    public ResponseEntity<?> getchitiet(@RequestParam("id") Integer id) {
        Map<String, Object> m = new HashMap<>();
        Optional<trang> t = ittr.findById(id);
        if (t.isPresent()) {
            trang current = t.get();
            m.put("success", true);
            m.put("trang", current);

            Optional<chuong> c = itchuong.findById(current.getIdchuong());
            m.put("chuong", c.orElse(null));

            trang prev = ittr.findTopByIdchuongAndSotrangLessThanOrderBySotrangDesc(current.getIdchuong(), current.getSotrang());
            m.put("trangTruoc", prev);

            trang next = ittr.findTopByIdchuongAndSotrangGreaterThanOrderBySotrangAsc(current.getIdchuong(), current.getSotrang());
            m.put("trangSau", next);

            return ResponseEntity.ok(m);
        }
        m.put("success", false);
        m.put("message", "Không tìm thấy trang");
        return ResponseEntity.badRequest().body(m);
    }

    @GetMapping("/first_page_batch")
    public ResponseEntity<?> firstPageBatch(@RequestParam("id_chuong_list") String idChuongListStr) {
        Map<String, Object> m = new HashMap<>();
        try {
            if (idChuongListStr == null || idChuongListStr.trim().isEmpty()) {
                m.put("success", true);
                m.put("data", new HashMap<>());
                return ResponseEntity.ok(m);
            }

            List<Integer> idChuongList = Arrays.stream(idChuongListStr.split(","))
                    .map(String::trim)
                    .filter(s -> !s.isEmpty())
                    .map(Integer::parseInt)
                    .collect(Collectors.toList());

            List<trang> allTrangs = ittr.findByIdchuongInOrderByIdchuongAscSotrangAsc(idChuongList);

            Map<Integer, Integer> firstPageMap = new LinkedHashMap<>();
            for (trang t : allTrangs) {
                firstPageMap.putIfAbsent(t.getIdchuong(), t.getId());
            }

            m.put("success", true);
            m.put("data", firstPageMap);
            return ResponseEntity.ok(m);

        } catch (NumberFormatException e) {
            m.put("success", false);
            m.put("message", "Danh sách ID chương không hợp lệ");
            return ResponseEntity.badRequest().body(m);
        } catch (Exception e) {
            e.printStackTrace();
            m.put("success", false);
            m.put("message", "Lỗi Server: " + e.getMessage());
            return ResponseEntity.status(500).body(m);
        }
    }
}