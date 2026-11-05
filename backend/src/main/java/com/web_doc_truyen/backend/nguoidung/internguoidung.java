package com.web_doc_truyen.backend.nguoidung;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface internguoidung extends JpaRepository<nguoidung, Integer> {

    Optional<nguoidung> findByTendangnhapAndMatkhau(String tendangnhap, String matkhau);
    Optional<nguoidung> findByTendangnhap(String tendangnhap);
    Optional<nguoidung> findByEmail(String email);
}
