package com.web_doc_truyen.backend.nguoidung;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/auth")
public class apinguoidung {

    @Autowired
    private internguoidung inernd;

    @GetMapping("/all")
    public ResponseEntity<?> getallusers() {
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("data", inernd.findAll().stream().map(nguoidungDTO::new).toList());
        return ResponseEntity.ok(response);
    }

    @PostMapping("/delete")
    public ResponseEntity<?> deleteuser(@RequestParam("id") Integer id) {
        Map<String, Object> response = new HashMap<>();
        if (inernd.existsById(id)) {
            inernd.deleteById(id);
            response.put("success", true);
            response.put("message", "Xóa người dùng thành công");
            return ResponseEntity.ok(response);
        }
        response.put("success", false);
        response.put("message", "Không tìm thấy người dùng để xóa");
        return ResponseEntity.ok(response);
    }

    @PostMapping("/dangky")
    public ResponseEntity<?> dangky(@RequestBody Map<String, String> request) {
        String user = request.get("ten_dang_nhap");
        String pass = request.get("mat_khau");
        String email = request.get("email");
        String vaitro = request.get("vai_tro") != null ? request.get("vai_tro") : "user";

        Map<String, Object> response = new HashMap<>();
        if (user == null || pass == null || email == null || user.isEmpty() || pass.isEmpty() || email.isEmpty()) {
            response.put("success", false);
            response.put("message", "Vui lòng nhập đủ thông tin");
            return ResponseEntity.ok(response);
        }
        if (pass.length() < 6) {
            response.put("success", false);
            response.put("message", "Mật khẩu phải có ít nhất 6 ký tự");
            return ResponseEntity.ok(response);
        }
        if (inernd.findByTendangnhap(user).isPresent()) {
            response.put("success", false);
            response.put("message", "Tên đăng nhập đã tồn tại");
            return ResponseEntity.ok(response);
        }
        if (inernd.findByEmail(email).isPresent()) {
            response.put("success", false);
            response.put("message", "Email đã được sử dụng");
            return ResponseEntity.ok(response);
        }

        nguoidung nd = new nguoidung();
        nd.setTendangnhap(user);
        nd.setMatkhau(BCrypt.hashpw(pass, BCrypt.gensalt()));
        nd.setEmail(email);
        nd.setVaitro(vaitro);

        try {
            inernd.save(nd);
        } catch (org.springframework.dao.DataIntegrityViolationException e) {
            response.put("success", false);
            response.put("message", "Tên đăng nhập hoặc email đã tồn tại");
            return ResponseEntity.ok(response);
        }

        response.put("success", true);
        response.put("message", "Đăng ký thành công");
        return ResponseEntity.ok(response);
    }

    @PostMapping("/dangnhap")
    public ResponseEntity<?> dangnhap(@RequestBody Map<String, String> request) {
        String user = request.get("ten_dang_nhap");
        String pass = request.get("mat_khau");
        Map<String, Object> response = new HashMap<>();

        if (user == null || pass == null || user.isEmpty() || pass.isEmpty()) {
            response.put("success", false);
            response.put("message", "Vui lòng nhập đủ thông tin");
            return ResponseEntity.ok(response);
        }

        Optional<nguoidung> foundUser = inernd.findByTendangnhap(user);
        if (foundUser.isPresent()) {
            nguoidung nd = foundUser.get();
            String storedHash = nd.getMatkhau();

            boolean isBcrypt = storedHash.startsWith("$2");
            boolean isValid = isBcrypt
                    ? BCrypt.checkpw(pass, storedHash)
                    : pass.equals(storedHash);

            if (isValid) {
                if (!isBcrypt) {
                    nd.setMatkhau(BCrypt.hashpw(pass, BCrypt.gensalt()));
                    inernd.save(nd);
                }
                response.put("success", true);
                response.put("message", "Đăng nhập thành công");
                response.put("user", new nguoidungDTO(nd));
                return ResponseEntity.ok(response);
            }
        }

        response.put("success", false);
        response.put("message", "Sai tài khoản hoặc mật khẩu");
        return ResponseEntity.ok(response);
    }

    @PostMapping("/update_user")
    public ResponseEntity<?> updateUser(
            @RequestParam("id_nguoidung") Integer id,
            @RequestParam(value = "email", required = false) String email,
            @RequestParam(value = "vai_tro", required = false) String vaiTro) {

        Map<String, Object> response = new HashMap<>();
        Optional<nguoidung> optUser = inernd.findById(id);
        if (optUser.isPresent()) {
            nguoidung nd = optUser.get();
            if (email != null && !email.isEmpty()) nd.setEmail(email);
            if (vaiTro != null && !vaiTro.isEmpty()) nd.setVaitro(vaiTro);
            inernd.save(nd);

            response.put("success", true);
            response.put("message", "Cập nhật thông tin người dùng thành công!");
            return ResponseEntity.ok(response);
        }

        response.put("success", false);
        response.put("message", "Không tìm thấy người dùng!");
        return ResponseEntity.ok(response);
    }
}