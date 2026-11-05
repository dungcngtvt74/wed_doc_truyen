package com.web_doc_truyen.backend.theo_doi_truyen;

import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface intertheo_doi_truyen extends JpaRepository<theo_doi_truyen,Integer> {
    List<theo_doi_truyen> findByIdnguoidung(Integer idnguoidung);

    Optional<theo_doi_truyen> findByIdnguoidungAndIdtruyen(Integer idnguoidung, Integer idtruyen);

    @Transactional
    void deleteByIdnguoidungAndIdtruyen(Integer idnguoidung, Integer idtruyen);
}
