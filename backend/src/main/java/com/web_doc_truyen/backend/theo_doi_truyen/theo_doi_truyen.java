package com.web_doc_truyen.backend.theo_doi_truyen;

import jakarta.persistence.*;

@Entity
@Table(name = "theo_doi_truyen")
public class theo_doi_truyen {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_nguoidung", nullable = false)
    private Integer idnguoidung;

    @Column(name = "id_truyen", nullable = false)
    private Integer idtruyen;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getIdnguoidung() { return idnguoidung; }
    public void setIdnguoidung(Integer idnguoidung) { this.idnguoidung = idnguoidung; }

    public Integer getIdtruyen() { return idtruyen; }
    public void setIdtruyen(Integer idtruyen) { this.idtruyen = idtruyen; }
}