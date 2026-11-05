package com.web_doc_truyen.backend.truyen;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface intertruyen extends JpaRepository<truyen, Integer> {

    List<truyen> findByTentruyenContainingIgnoreCase(String keyword);
}