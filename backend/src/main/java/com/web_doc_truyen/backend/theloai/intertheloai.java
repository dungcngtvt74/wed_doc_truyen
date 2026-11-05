package com.web_doc_truyen.backend.theloai;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface intertheloai extends JpaRepository<theloai, Integer> {
    Optional<theloai> findByTentheloai(String tentheloai);
}