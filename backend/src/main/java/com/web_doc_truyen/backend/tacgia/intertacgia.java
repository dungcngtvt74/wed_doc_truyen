package com.web_doc_truyen.backend.tacgia;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface intertacgia extends JpaRepository<tacgia, Integer> {
    Optional<tacgia> findByTenTacGia(String tenTacGia);
}