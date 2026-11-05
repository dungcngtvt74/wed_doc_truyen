package com.web_doc_truyen.backend.trang;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface intertrang extends JpaRepository<trang, Integer> {

    List<trang> findByIdchuongOrderBySotrangAsc(Integer idchuong);

    trang findTopByIdchuongAndSotrangLessThanOrderBySotrangDesc(Integer idchuong, Integer sotrang);

    trang findTopByIdchuongAndSotrangGreaterThanOrderBySotrangAsc(Integer idchuong, Integer sotrang);
    List<trang> findByIdchuongInOrderByIdchuongAscSotrangAsc(List<Integer> idchuongList);
}