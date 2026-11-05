package com.web_doc_truyen.backend.hoso_user;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface interhoso_user extends JpaRepository<hoso_user, Integer> {
    Optional<hoso_user> findBySodienthoaiAndIduserNot(String sodienthoai, Integer iduser);
}