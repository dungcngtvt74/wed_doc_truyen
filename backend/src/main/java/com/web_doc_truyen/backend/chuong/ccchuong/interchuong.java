package com.web_doc_truyen.backend.chuong.ccchuong;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface interchuong extends JpaRepository<chuong, Integer> {
    List<chuong> findByIdtruyen(Integer idtruyen);
    List<chuong> findByIdtruyenOrderBySochuongAsc(Integer idtruyen);
}