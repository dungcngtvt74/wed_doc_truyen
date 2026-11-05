package com.web_doc_truyen.backend.luutrang;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Map;

public interface interluutrang extends JpaRepository<luutrang, luutrang.LuutrangId> {

    @Query(value = "SELECT l.id_truyen, l.id_chuong, l.so_trang, l.ngay_cap_nhat, " +
            "t.ten_truyen, t.anh_bia, " +
            "c.so_chuong AS so_chuong_dang_doc, c.tieu_de " +
            "FROM luu_trang_doc l " +
            "JOIN truyen t ON l.id_truyen = t.id " +
            "JOIN chuong c ON l.id_chuong = c.id " +
            "WHERE l.id_nguoidung = :idNguoiDung " +
            "ORDER BY l.ngay_cap_nhat DESC", nativeQuery = true)
    List<Map<String, Object>> getHistoryByUser(@Param("idNguoiDung") Integer idNguoiDung);

}